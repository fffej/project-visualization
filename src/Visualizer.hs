module Visualizer where

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine
import Graphics.SVGFonts.ReadFont (textSVG)

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5

now :: [Project] -> [Project]
now = filter (null . dependency)

next :: [Project] -> [Project]
next = filter (not . null . dependency)

diagram :: [Project] -> Diagram B R2
diagram projects = header === strutY verticalSpacing === (vcat $ map (visualize projects) (now projects))

header :: Diagram B R2
header = (text "Now" <> (rect 75 10 # fc gray)) ||| 
         strutX verticalSpacing ||| 
         (text "Next" <> (rect 75 10 # fc gray))

visualize :: [Project] -> Project -> Diagram B R2
visualize ps p = ((text d) <> paddedRect) ||| (strutX verticalSpacing) ||| vcat (map (visualize ps) dependentProjects) === strutY verticalSpacing 
  where
    paddedRect = (rect w h # fc c) 
    w = fromIntegral $ 75
    h = heightFrom $ cost p 
    c = colorFrom $ outcome p
    d = name p
    dependentProjects = filter (\x -> projectId p `elem` dependency x) ps

colorFrom :: (Ord a, Floating a) => Outcome -> Colour a
colorFrom Improve     = blue
colorFrom Learn       = red
colorFrom Sustain     = yellow
colorFrom Execute     = green

heightFrom :: (Floating a) => Cost -> a
heightFrom High   = 30
heightFrom Medium = 20
heightFrom Low    = 10