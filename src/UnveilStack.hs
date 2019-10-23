module UnveilStack (printAndExitIfUnveilStackOptionsExist) where

import Paths_unveil_stack (version)

import Data.Version (showVersion)
import System.Exit (exitSuccess)

printAndExitIfUnveilStackOptionsExist :: [String] -> IO ()
printAndExitIfUnveilStackOptionsExist ("--unveil-stack":_) = do
  putStrLn $ "unveil-stack " <> showVersion version
  exitSuccess
printAndExitIfUnveilStackOptionsExist _ = pure ()
