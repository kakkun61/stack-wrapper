module Main where

import System.Environment
import System.Process

main :: IO ()
main = do
  args <- getArgs
  compilerExe <- head . lines <$> readProcess "stack" ["path", "--compiler-exe"] ""
  snapshotPackageDB <- head . lines <$> readProcess "stack" ["path", "--snapshot-pkg-db"] ""
  localPackageDB <- head . lines <$> readProcess "stack" ["path", "--local-pkg-db"] ""
  callProcess compilerExe ("-package-db":snapshotPackageDB:"-package-db":localPackageDB:args)
