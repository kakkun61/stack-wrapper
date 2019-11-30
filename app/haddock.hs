module Main where

import StackWrapper

import qualified GhcLib as G

import System.Environment
import System.FilePath
import System.Process

main :: IO ()
main =
  run $ G.run "haddock" $ do
    args <- getArgs
    binDir <- head . lines <$> readProcess "stack" ["path", "--compiler-bin"] ""
    callProcess (binDir </> "haddock") args
