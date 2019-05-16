from flask import Flask
app = Flask(__name__)

import sqlite3
from flask import g
from flask import request
from flask import jsonify

import bcrypt
import json

# TODO: best to do this with environment variables (12-factor app)
DATABASE = 'data/database.db'

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read().replace('\n',' '))
        db.commit()

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

# TODO: could use sql alchemy instead
def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

@app.route('/login', methods=['POST'])
def login():
    # TODO: sanitize the input
    username = request.get_json()['username']
    password = request.get_json()['password']
    # check username/password (grab parameters from body)
    user = query_db("select username, password from users where username = '{}'".format(username), one=True)
    if user is None:
        return "NO", 401
    if not bcrypt.checkpw(password.encode(), user[1].encode()):
        return "NO", 401
    # TODO: generate the key with uuid.uuid4()
    key = username
    # TODO: handle errors and do not set key when errors present
    # update record with key
    query_db("update users set key = '{}' where username = '{}'".format(key, username))
    get_db().commit()
    return key, 200

@app.route('/logout', methods=['POST'])
def logout():
    # supply key in the body of the request
    key = request.get_json()['key']
    # check for existence of the key
    user = query_db("select key from users where key = '{}'".format(key))
    if user is None:
        return "NO", 404
    # update record to clear key
    query_db("update users set key = NULL where key = '{}'".format(key))
    get_db().commit()
    return "SURE", 200

@app.route('/actions', methods=['GET'])
def actions():
    # TODO: do unit tests throughout
    key = request.args['key']
    # query the actions table via user/group/actions join
    query = "select verb, url " \
            "from actions a join groups_actions ga on a.action_id = ga.action_id " \
            "join users_groups ug on ga.group_id = ug.group_id " \
            "join users u on u.user_id = ug.user_id " \
            "where u.key = '{}'".format(key)
    actions = query_db(query)
    # MAYBE: iterate through actions, and convert to JSON record
    # return all actions as json
    return json.dumps(actions), 200

if __name__ == '__main__':
    app.run()
