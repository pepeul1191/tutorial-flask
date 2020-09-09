from flask import Flask

APP = Flask(
  __name__,
  static_folder='static',
  static_url_path='/',
)

@APP.route('/')
def home():
    return 'Hello, World?'

if __name__ == '__main__':
    APP.run(
        debug=True, 
    )
