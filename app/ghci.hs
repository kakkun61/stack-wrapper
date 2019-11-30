module Main where

import StackWrapper

import qualified GhcLib as G

import System.Environment
import System.FilePath
import System.Process

main :: IO ()
main =
  run $ G.run "ghci" $ do
    args <- getArgs
    binDir <- head . lines <$> readProcess "stack" ["path", "--compiler-bin"] ""
    globalPackageDB <- head . lines <$> readProcess "stack" ["path", "--global-pkg-db"] ""
    snapshotPackageDB <- head . lines <$> readProcess "stack" ["path", "--snapshot-pkg-db"] ""
    localPackageDB <- head . lines <$> readProcess "stack" ["path", "--local-pkg-db"] ""
    callProcess (binDir </> "ghci") ("-package-db":globalPackageDB:"-package-db":snapshotPackageDB:"-package-db":localPackageDB:args)
