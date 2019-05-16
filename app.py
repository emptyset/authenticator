from flask import Flask
app = Flask(__name__)

import sqlite3
from flask import g

# best to do this with environment variables (12-factor app)
DATABASE = 'data/database.db'

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

# could use sql alchemy instead
def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

@app.route('/login', methods=['POST'])
def login():
    # check username/password (grab parameters from body)
    # generate the key
    # update record with key
    return "OK"

@app.route('/logout', methods=['POST'])
def logout():
    # update record to clear key
    return "OK"

@app.route('/actions', methods=['GET'])
def actions():
    # query the actions table via user/group/actions join
    # iterate through actions, and convert to JSON record
    # return all actions as json
    return "OK"

if __name__ == '__main__':
    app.run()
