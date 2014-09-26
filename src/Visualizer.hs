module Visualizer where

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5

now :: [Project] -> [Project]
now = filter (null . dependency)

next :: [Project] -> [Project]
next = filter (not . null . dependency)

diagram :: [Project] -> Diagram B R2
diagram projects = vcat $ map (alignL . visualize) projects

visualize :: Project -> Diagram B R2
visualize p = (text d) <> ((rect w h # fc c) === strutY verticalSpacing)
  where
    w = fromIntegral $ 10
    h = fromIntegral $ 20
    c = colorFrom $ outcome p
    d = name p

colorFrom :: (Ord a, Floating a) => Outcome -> Colour a
colorFrom Improve     = blue
colorFrom Learn       = red
colorFrom Sustain     = yellow
colorFrom Execute     = green

