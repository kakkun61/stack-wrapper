{-# LANGUAGE CPP #-}

module StackWrapper
  ( run
  , envPrefix
  ) where

import Paths_stack_wrapper (version)

import Data.Version (showVersion)
import System.Environment (getArgs, getExecutablePath, getProgName, lookupEnv, setEnv)
import System.Exit (exitFailure, exitSuccess)
import System.IO (hPutStrLn, stderr)
import System.Process (callProcess)

#ifdef mingw32_HOST_OS
import System.FilePath (takeBaseName)
#endif

option :: String
option = "--stack-wrapper"

envPrefix :: String
envPrefix = "STACK_WRAPPER_"

callerEnv :: String
callerEnv = envPrefix <> "CALLER"

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
          name <- getProgBaseName
          mdefaultExe <- lookupEnv $ envPrefix <> name
          case mdefaultExe of
            Just defaultExe ->
              callProcess defaultExe args
            Nothing -> do
              hPutStrLn stderr "recursive call detected"
              exitFailure
        _ -> do
          setEnv callerEnv this
          act

getProgBaseName :: IO String
#ifdef mingw32_HOST_OS
getProgBaseName = takeBaseName <$> getProgName
#else
getProgName = getProgName
#endif
