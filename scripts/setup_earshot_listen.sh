#!/usr/bin/env bash
# Install earshot with its listening models from this repo's release: no Hugging Face, no PyTorch index.
# usage: bash setup_earshot_listen.sh        then:  export EARSHOT_HOME=... EARSHOT_OFFLINE=1  (printed at the end)
set -euo pipefail

REPO=${MT_REPO:-miguelfdsc/motion-toolkit}
TAG=${MT_TAG:-models-v1}
EARSHOT_COMMIT=${EARSHOT_COMMIT:-7a7f7c5c70d4a763a1eca4b3666af7c77e313f97}
BASE="https://github.com/$REPO/releases/download/$TAG"
export EARSHOT_HOME=${EARSHOT_HOME:-$HOME/.cache/earshot}

py=$(python3 -c 'import sys; print(f"cp{sys.version_info.major}{sys.version_info.minor}")')
work=$(mktemp -d)
cd "$work"

curl -fsSL -O "$BASE/SHA256SUMS"
files=(earshot-clap-hf-cache.tar earshot-ast-hf-cache.tar "torch-cpu-$py.tar")
for f in "${files[@]}"; do
  grep -q " $f\$" SHA256SUMS || { echo "no $f in release $TAG (Python $py not mirrored?)" >&2; exit 1; }
  curl -fsSL -O "$BASE/$f"
done
grep -E " ($(IFS='|'; echo "${files[*]}"))\$" SHA256SUMS | sha256sum -c -

mkdir -p "$EARSHOT_HOME/hf" wheels
tar -C "$EARSHOT_HOME/hf" -xf earshot-clap-hf-cache.tar
tar -C "$EARSHOT_HOME/hf" -xf earshot-ast-hf-cache.tar
tar -C wheels -xf "torch-cpu-$py.tar"

pip install -q --break-system-packages wheels/torch-*.whl
pip install -q --break-system-packages "earshot[listen] @ git+https://github.com/miguelfdsc/earshot@$EARSHOT_COMMIT"

echo "ready. In each shell:  export EARSHOT_HOME=$EARSHOT_HOME EARSHOT_OFFLINE=1"
