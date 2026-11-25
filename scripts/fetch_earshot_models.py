"""Download earshot's listening models at the revisions earshot pins, into an earshot-style Hugging Face cache.

Mirrors exactly what `earshot doctor --fetch` does (same snapshot_download call, same files), so the resulting
cache can be extracted into $EARSHOT_HOME/hf on a machine that cannot reach Hugging Face.
Pins copied from earshot/config.py (PINS) at earshot 1.0.0 (7a7f7c5).

usage: python fetch_earshot_models.py <cache_dir>
"""
import sys

from huggingface_hub import snapshot_download

PINS = {
    'laion/larger_clap_general': {
        'revision': '16c8cc3159a3c8a31e8ff5ef1f66b0d9ab3667db', 'weights': 'model.safetensors',
        'files': ('config.json', 'preprocessor_config.json', 'merges.txt', 'special_tokens_map.json',
                  'tokenizer.json', 'tokenizer_config.json', 'vocab.json')},
    'MIT/ast-finetuned-audioset-10-10-0.4593': {
        'revision': 'f826b80d28226b62986cc218e5cec390b1096902', 'weights': 'model.safetensors',
        'files': ('config.json', 'preprocessor_config.json')},
}

cache = sys.argv[1]
for model_id, pin in PINS.items():
    path = snapshot_download(model_id, revision=pin['revision'], cache_dir=cache,
                             allow_patterns=[*pin['files'], pin['weights']])
    print(model_id, '->', path)
