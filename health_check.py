from flask import Flask

app = Flask(__name__)

# Health check route
@app.route('/health')
def health_check():
    return "Healthy", 200

@app.route('/')
def home():
    return "Hello, World!"

if __name__ == '__main__':
    # This is for local development, Gunicorn will take care of production deployment
    app.run(host='0.0.0.0', port=8000)
