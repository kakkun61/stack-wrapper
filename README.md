# stack-wrapper

When you invoke `ghc` of stack-wrapper, you can invoke the appropriate one which specified by the resolver of _stack.yaml_.

This helps you when you are working with stack but developing tools etc. don't support stack.

To check a stack-wrapper version, you give `--stack-wrapper` as the first option to commands.

You can set the default executable files with environment variables. They are used when no executable files found except the stack-wrapper's ones.

This package creates 2 types of executable files.

## ghc etc.

`ghc` runs like:

1. search a compiler under stack environment
2. give the global, snapshot and local package DB to the compiler
3. run the compiler

`ghc-pkg`, `ghci`, `haddock`, `hp2ps`, `hsc2hs`, `runghc` and `runhaskell` are also given.

## exe

An executable file which is renamed from `exe`, for example `hhpc`, runs new process `stack exec -- hhpc`.

## Options

- `--stack-wrapper`
  - print the stack-wrapper version

## Environment variables

- `STACK_WRAPPER_GHC_DIR`
  - the default directory which contains `ghc`, `ghc-pkg` etc.
- `STACK_WRAPPER_<exe name>`
  - the default executable file for &lt;exe name&gt;
  - on Windows remove the `.exe` extension
