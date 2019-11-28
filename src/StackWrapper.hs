module StackWrapper (run) where

import Paths_stack_wrapper (version)

import Data.Version (showVersion)
import System.Environment (getArgs, getExecutablePath, lookupEnv, setEnv)
import System.Exit (exitFailure, exitSuccess)
import System.IO (hPutStrLn, stderr)

option :: String
option = "--stack-wrapper"

callerEnv :: String
callerEnv = "STACK_WRAPPER_CALLER"

run :: IO () -> IO ()
run act = do
  args <- getArgs
  case args of
    a0:_ | a0 == option -> do
      putStrLn $ "stack-wrapper " <> showVersion version
      exitSuccess
    _ -> do
      this <- getExecutablePath
      mcaller <- lookupEnv callerEnv
      case mcaller of
        Just caller | this == caller -> do
          hPutStrLn stderr "recursive call detected"
          exitFailure
        _ -> do
          setEnv callerEnv this
          act
