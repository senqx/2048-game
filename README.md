# 2048-game

**Unfinished experiment — not playable yet.** Development is paused; I plan
to return to it later.

This repository currently contains a C++20 build setup, an empty `Board`
class, and a placeholder executable that prints `Hello, World!`. Tile movement,
merging, scoring, and a game interface have not been implemented.

## Build the placeholder

You need a C++20 compiler and GNU Make:

```sh
make
./bin/release/2048
```

For a debug build, use `make debug` and run `./bin/debug/2048`.
The existing example test checks the placeholder output; it does not test
2048 gameplay.

Licensed under the [MIT License](LICENSE).
