{-# LANGUAGE NoMonomorphismRestriction #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

import Project

-- Eventually, I'd parse this from a file
projects :: [Project]
projects = [
    Project "Develop UI" Improvement 400
  , Project "Research shoe size" Learn 100
  , Project "Make financial plans" Sustain 30
  , Project "Add formatting features" Execute 30
  ]

main :: IO ()
main = mainWith (square 1 `atop` example)

example :: Diagram B R2
example = circle 1 # fc blue
                   # lw veryThick
                   # lc purple
                   # dashingG [0.2,0.05] 0
