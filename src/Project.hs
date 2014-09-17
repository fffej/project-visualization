{-# LANGUAGE OverloadedStrings #-}

module Project
       (
         Outcome(..),
         Project(..)
       )
       where

import Data.Csv
import Data.Vector
import Data.ByteString
import Control.Applicative ((<$>), (<*>), pure)
import Control.Monad (mzero)

data Outcome = Execute
             | Improvement
             | Learn
             | Sustain
               deriving (Ord,Show,Eq)

data Project = Project
               {
                 name :: String
               , outcome :: Outcome
               , cost :: Int
               , duration :: Int
               } deriving (Show)
                 
instance FromNamedRecord Project where
  parseNamedRecord m = Project <$>
                       m .: "Name" <*>
                       m .: "Outcome" <*>
                       m .: "Cost" <*>
                       m .: "Duration"

instance FromField Outcome where
  parseField s
    | s == "Develop" = pure Execute
    | s == "Improvement" = pure Improvement
    | s == "Learn" = pure Learn
    | s == "Sustain" = pure Sustain
    | otherwise = mzero
