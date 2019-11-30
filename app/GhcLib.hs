module GhcLib (run) where

import StackWrapper (envPrefix)

import System.Environment
import System.FilePath
import System.Process

run :: String -> IO () -> IO ()
run name act = do
  args <- getArgs
  mdefaultDir <- lookupEnv $ envPrefix <> "GHC_DIR"
  case mdefaultDir of
    Just defaultDir ->
      callProcess (defaultDir </> name) args
    Nothing -> do
      act
