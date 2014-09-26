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
diagram projects = vcat $ map (visualize projects) projects

visualize :: [Project] -> Project -> Diagram B R2
visualize all p = (text d) <> paddedRect
  where
    paddedRect = rect w h # fc c === strutY verticalSpacing
    w = fromIntegral $ 75
    h = heightFrom $ cost p 
    c = colorFrom $ outcome p
    d = name p

colorFrom :: (Ord a, Floating a) => Outcome -> Colour a
colorFrom Improve     = blue
colorFrom Learn       = red
colorFrom Sustain     = yellow
colorFrom Execute     = green

heightFrom :: (Floating a) => Cost -> a
heightFrom High   = 30
heightFrom Medium = 20
heightFrom Low    = 10