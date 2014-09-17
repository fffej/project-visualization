{-# LANGUAGE NoMonomorphismRestriction #-}

import Diagrams.Prelude hiding (duration)
import Diagrams.Backend.SVG.CmdLine

import Project

-- Define a few constants about the diagram
verticalSpacing :: Double
verticalSpacing = 5



-- Eventually, I'd parse this from a file
projects :: [Project]
projects = [
    Project "Develop UI"              Improvement 400   100
  , Project "Research shoe size"      Learn       100    20
  , Project "Make financial plans"    Sustain     30     10
  , Project "Add formatting features" Execute     30     80
  ]

main :: IO ()
main = mainWith (vcat $ map (alignL . visualize) projects)

visualize :: Project -> Diagram B R2
visualize p = text t <> (rect w h # fc c === strutY verticalSpacing)
  where
    w = fromIntegral $ cost p
    h = fromIntegral $ duration p
    c = colorFrom $ outcome p
    t = name p

colorFrom :: (Ord a, Floating a) => Outcome -> Colour a
colorFrom Improvement = blue
colorFrom Learn       = red
colorFrom Sustain     = yellow
colorFrom Execute     = green

example :: Diagram B R2
example = circle 1 # fc blue
                   # lw veryThick
                   # lc purple
                   # dashingG [0.2,0.05] 0
