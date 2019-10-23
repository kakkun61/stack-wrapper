module Main where

import UnveilStack

import System.Process
import System.Environment

main :: IO ()
main = do
  name <- getProgName
  args <- getArgs
  printAndExitIfUnveilStackOptionsExist args
  callProcess "stack" ("exec":"--":name:args)
