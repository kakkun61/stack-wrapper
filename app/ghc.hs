module Main where

import StackWrapper

import System.Environment
import System.Process

main :: IO ()
main =
  run $ do
    args <- getArgs
    mdefaultDir <- lookupEnv $ envPrefix <> "GHC_DIR"
    case mdefaultDir of
      Just defaultDir ->
        callProcess (defaultDir <> "/ghc") args
      Nothing -> do
        compilerExe <- head . lines <$> readProcess "stack" ["path", "--compiler-exe"] ""
        snapshotPackageDB <- head . lines <$> readProcess "stack" ["path", "--snapshot-pkg-db"] ""
        localPackageDB <- head . lines <$> readProcess "stack" ["path", "--local-pkg-db"] ""
        callProcess compilerExe ("-package-db":snapshotPackageDB:"-package-db":localPackageDB:args)
