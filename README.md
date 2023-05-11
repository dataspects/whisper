# whisper

https://lablab.ai/t/whisper-api-flask-docker

## ENVIRONMENT: Python environment and requirements

- `~/whisper$ virtualenv /home/lex/.virtualenvs/whisper`
- `~/whisper$ source ~/.virtualenvs/whisper/bin/activate`
- `(whisper) ~/whisper$ pip install ...`
- `(whisper) ~/whisper$ pip freeze > requirements.txt`
- `(whisper) ~/whisper$ pip install -r requirements.txt`

## Docker

- `sudo docker build -t dataspects/whisper:1.0.0 .`
- `sudo docker run -p 5000:5000 dataspects/whisper:1.0.0`
- `sudo docker login && sudo docker push dataspects/whisper:1.0.0`

## Test

- `curl -F "file=@/path/to/file" http://localhost:5000/whisper`
