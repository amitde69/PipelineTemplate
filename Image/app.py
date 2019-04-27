from flask import Flask,jsonify

app = Flask(__name__)

version = {'version': '2'}
response = [
    version,
    {
        'response': 'success'
    }
]

@app.route('/amit')
def get():
    return jsonify(response)


if __name__ == "__main__":
    app.run(debug=True, port='3000', host='0.0.0.0')