# Mirrored models

Copies of open models used by the skills in `skills.lock.json`, for cloud sessions that cannot reach Hugging Face or the PyTorch index. Built by `.github/workflows/mirror-models.yml`; each file's SHA-256 is in `SHA256SUMS` in the release.

| File | Source | Revision | Licence |
|---|---|---|---|
| `earshot-clap-hf-cache.tar` | [laion/larger_clap_general](https://huggingface.co/laion/larger_clap_general) (776 MB) | `16c8cc3` | Apache-2.0 |
| `earshot-ast-hf-cache.tar` | [MIT/ast-finetuned-audioset-10-10-0.4593](https://huggingface.co/MIT/ast-finetuned-audioset-10-10-0.4593) (346 MB) | `f826b80` | BSD-3-Clause |
| `torch-cpu-cp312.tar`, `torch-cpu-cp313.tar` | [PyTorch](https://pytorch.org) CPU wheels, Linux x86_64 | latest at build time | BSD-3-Clause |

The two model tars hold earshot's own Hugging Face cache layout at the revisions earshot pins (earshot 1.0.0). Extract them into `$EARSHOT_HOME/hf` and set `EARSHOT_OFFLINE=1`; `scripts/setup_earshot_listen.sh` does all of it.

All rights in the models stay with their authors under the licences above.
