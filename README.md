# whisper

https://lablab.ai/t/whisper-api-flask-docker

## ENVIRONMENT: Python environment and requirements

- `~/whisper$ virtualenv /home/lex/.virtualenvs/whisper`
- `~/whisper$ source ~/.virtualenvs/whisper/bin/activate`
- `(solverion) ~/whisper$ pip install ...`
- `(solverion) ~/whisper$ pip freeze > requirements.txt`
- `(solverion) ~/whisper$ pip install -r requirements.txt`

## Docker

- `docker build -t whisper-api .`
- `docker run -p 5000:5000 whisper`

## Test

- `curl -F "file=@/path/to/file" http://localhost:5000/whisper`
