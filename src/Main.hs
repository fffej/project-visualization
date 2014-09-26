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

mkProject :: ProjectId -> String -> String -> Outcome -> [String] -> [String] -> Cost -> Project
mkProject i n dept o t d c = Project i n dept divGoalA "Win" o t d c

projects :: [Project]
projects = [
    mkProject "AG1" "Complete an APPLE framework" "AG" Execute [] [] High
  , mkProject "AG2" "Complete the BANANA implementation" "AG" Improve [] [] Medium
  , mkProject "AG3" "Develop campaigns for X & Y" "AG" Learn [] [] Low
  , mkProject "AG4" "Develop a campaign for A & B" "AG" Sustain [] ["AG1"] Medium
  , mkProject "AG5" "Develop a campaign for Mango" "AG" Execute [] ["AG1"] Medium
  , mkProject "AG6" "Develop brand strategy" "AG" Improve [] ["AG3"] Medium
  ]

main :: IO ()
main = mainWith $ diagram (sortBy (comparing cost) projects)


