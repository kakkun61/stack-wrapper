# unveil-stack

This helps you when you are working with stack but developing tools don't support stack.

To check a unveil-stack version, you give `--unveil-stack` as the first option to commands.

This package creates 2 executable files.

## ghc

_ghc_ runs like:

1. search a compiler under stack environment
2. give the snapshot package DB to the compiler
3. give the local pachage DB to the compiler
4. run the compiler

## exe

An executable file which is renamed from _exe_, for example _hhpc_, runs new process `stack exec -- hhpc`.
