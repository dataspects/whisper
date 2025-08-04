# whisper

https://lablab.ai/t/whisper-api-flask-docker

# Develop

- `poetry run python3 -m flask run --host 0.0.0.0 --port 5000`

## Docker

- `sudo docker run -p 5000:5000 dataspects/whisper:1.0.2`
- `sudo docker login && sudo docker push dataspects/whisper:1.0.2`

## Test

- `curl -F "file=@/path/to/file" http://dataspects-docker-server:5000/whisper`

## Converters

- `ffmpeg -i *.m4a *.wav`
