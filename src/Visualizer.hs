module Visualizer where

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5

diagram projects = vcat $ map (alignL . visualize) projects

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

