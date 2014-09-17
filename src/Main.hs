{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Diagrams.Backend.SVG.CmdLine (mainWith)

import Project
import Visualizer (diagram)

-- Eventually, I'd parse this from a file
projects :: [Project]
projects = [
    Project "Develop UI"              Improvement 4000   1000
  , Project "Research shoe size"      Learn       1000    200
  , Project "Make financial plans"    Sustain     300     100
  , Project "Add formatting features" Execute     300     800
  ]

main :: IO ()
main = mainWith $ diagram projects


