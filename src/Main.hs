{-# LANGUAGE NoMonomorphismRestriction #-}
module Main where

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5

-- Eventually, I'd parse this from a file
projects :: [Project]
projects = [
    Project "Develop UI"              Improvement 4000   1000
  , Project "Research shoe size"      Learn       1000    200
  , Project "Make financial plans"    Sustain     300     100
  , Project "Add formatting features" Execute     300     800
  ]

main :: IO ()
main = mainWith $ vcat $ map (alignL . visualize) projects

visualize :: Project -> Diagram B R2
visualize p = (text d) <> ((rect w h # fc c) === strutY verticalSpacing)
  where
    w = fromIntegral $ cost p
    h = fromIntegral $ duration p
    c = colorFrom $ outcome p
    d = name p

colorFrom :: (Ord a, Floating a) => Outcome -> Colour a
colorFrom Improvement = blue
colorFrom Learn       = red
colorFrom Sustain     = yellow
colorFrom Execute     = green

