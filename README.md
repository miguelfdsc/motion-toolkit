# motion-toolkit

Support files for `motion-video-router`, a Claude skill that picks the route and the external skills for motion design work (After Effects, code-rendered films, Lottie, Blender, AI-generated shots, footage edits, sound).

- `skills.lock.json`: the external skills, each pinned to a fork and a tested commit.
- `MODELS.md`: open models mirrored as release files (earshot's listening models, CPU-only PyTorch).
- `scripts/setup_earshot_listen.sh`: installs earshot with listening in a session that can't reach Hugging Face.
- `.github/workflows/mirror-models.yml`: builds the model release (Actions → Mirror models → Run workflow).

## Updating a skill
1. On the fork, **Sync fork**.
2. Test it in a session.
3. Bump `commit` and `tested` in `skills.lock.json`.

No client material lives here.
