{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Diagrams.Backend.SVG.CmdLine (mainWith)
import Data.ByteString.Lazy (ByteString,readFile)

import Project
import Visualizer
import Data.Vector (Vector())
import qualified Data.Vector as V
import Data.Csv (decodeByName)
import Data.List
import Data.Ord

-- Eventually, I'd parse this from a file
divGoalA :: String
divGoalA = "Divisional Goal1"

mkProject :: ProjectId -> String -> Outcome -> [String] -> [String] -> Cost -> Project
mkProject i dept o t d c = Project i "Generic Goal" dept divGoalA "Win" o t d c

projects :: [Project]
projects = [
    mkProject "AG1" "AG" Execute [] [] Medium
  , mkProject "AG2" "AG" Improve [] [] Medium
  , mkProject "AG3" "AG" Learn [] [] Medium
  , mkProject "AG4" "AG" Sustain [] [] Medium
  , mkProject "AG5" "AG" Execute [] [] Medium
  , mkProject "AG6" "AG" Improve [] ["AG3","AG4"] Medium
  ]

main :: IO ()
main = mainWith $ diagram (sortBy (comparing outcome) projects)


