module Visualizer where

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine
import Graphics.SVGFonts.ReadFont

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5

now :: [Project] -> [Project]
now = filter (null . dependency)

next :: [Project] -> [Project]
next = filter (not . null . dependency)

text' :: String -> Diagram B R2
text' t = stroke (textSVG' $ TextOpts t lin INSIDE_H HADV False 14 14) 
    # fillRule EvenOdd 
    # fc black
    # lw veryThin

diagram :: [Project] -> Diagram B R2
diagram projects = header === strutY verticalSpacing === (vcat $ map (visualize projects) (now projects))

header :: Diagram B R2
header = (text' "Now" <> (rect 300 10 # fc gray)) ||| 
         strutX verticalSpacing ||| 
         (text' "Next" <> (rect 300 10 # fc gray))

visualize :: [Project] -> Project -> Diagram B R2
visualize ps p = ((text' d) <> paddedRect) ||| (strutX verticalSpacing) ||| vcat (map (visualize ps) dependentProjects) === strutY verticalSpacing 
  where
    paddedRect = (rect w h # fc c) 
    w = fromIntegral $ 300
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
heightFrom High   = 100
heightFrom Medium = 70
heightFrom Low    = 40