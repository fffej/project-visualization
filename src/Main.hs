{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Diagrams.Backend.SVG.CmdLine (mainWith)
import Data.ByteString.Lazy (ByteString,readFile)

import Project
import Visualizer (diagram)
import Data.Vector (Vector())
import qualified Data.Vector as V
import Data.Csv (decodeByName)
import Data.List
import Data.Ord

-- Eventually, I'd parse this from a file
projects :: [Project]
projects = [
    Project "Develop UI"              Improvement 4000   1000
  , Project "Research shoe size"      Learn       1000    200
  , Project "Make financial plans"    Sustain     300     100
  , Project "Add formatting features" Execute     300     800
  ]

inputFile :: String
inputFile = "csvdata.csv"

main :: IO ()
main = do
  x <- Data.ByteString.Lazy.readFile inputFile
  let projects = decodeByName x
  case projects of
    Left s       -> putStrLn s
    Right (h,p)  -> mainWith $ diagram (sortBy (comparing outcome) $ V.toList p)


