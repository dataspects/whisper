from flask import Flask, abort, request
from tempfile import NamedTemporaryFile
import whisper, torch, librosa, os
import soundfile as sf
from pydub import AudioSegment
import io
from rich.console import Console
console = Console()

# Check if NVIDIA GPU is available
torch.cuda.is_available()
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"

# https://huggingface.co/spaces/openai/whisper/discussions/30

# Load the Whisper model:
# https://github.com/openai/whisper?tab=readme-ov-file#available-models-and-languages
model = whisper.load_model("base", device=DEVICE)

app = Flask(__name__)

@app.route("/")
def hello():
    return "Whisper Hello World!"

@app.route('/whisper', methods=['POST'])
def handler():
    if not request.files:
        abort(400)

    results = []

    for filename, handle in request.files.items():
        console.log(f"Processing file: {filename, handle}")
        # Load uploaded file into AudioSegment (auto-handles .m4a, .mp3, etc.)
        audio = AudioSegment.from_file(handle.stream)

        # Export to raw audio in memory as WAV
        wav_io = io.BytesIO()
        audio.export(wav_io, format='wav')
        wav_io.seek(0)

        # Load into librosa for volume analysis and potential normalization
        audio_data, sr = librosa.load(wav_io, sr=None, mono=True)
        peak = max(abs(audio_data))
        min_peak = float(os.environ.get("MIN_AUDIO_PEAK", 0.8))
        if peak < min_peak:
            audio_data *= (min_peak / peak)

        # Save normalized audio to a temporary WAV file
        with NamedTemporaryFile(suffix=".wav", delete=False) as temp:
            sf.write(temp.name, audio_data, sr)
            temp.flush()

            # Transcribe using Whisper
            result = model.transcribe(temp.name)

        results.append({
            'filename': filename,
            'transcript': result['text'],
        })

    return {'results': results}