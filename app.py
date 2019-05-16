from flask import Flask
app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    return "OK"

@app.route('/logout', methods=['POST'])
def logout():
    return "OK"

@app.route('/actions', methods=['GET'])
def actions():
    return "OK"

if __name__ == '__main__':
    app.run()
