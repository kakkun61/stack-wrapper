module Main where

import System.Environment
import System.FilePath
import System.Process

main :: IO ()
main = do
  args <- getArgs
  cimpilerBin <- head . lines <$> readProcess "stack" ["path", "--compiler-bin"] ""
  callProcess (cimpilerBin </> "ghc") args
