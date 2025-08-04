# whisper

https://lablab.ai/t/whisper-api-flask-docker

## ENVIRONMENT: Python environment and requirements

Poetry

## Docker

- `sudo docker run -p 5000:5000 dataspects/whisper:1.0.2`
- `sudo docker login && sudo docker push dataspects/whisper:1.0.2`

## Test

- `curl -F "file=@/path/to/file" http://dataspects-docker-server:5000/whisper`

## Converters

- `ffmpeg -i *.m4a *.wav`
