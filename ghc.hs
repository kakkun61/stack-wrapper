module Main where

import System.Environment
import System.FilePath
import System.Process

main :: IO ()
main = do
  args <- getArgs
  compilerBin <- head . lines <$> readProcess "stack" ["path", "--compiler-bin"] ""
  callProcess (compilerBin </> "ghc") args
