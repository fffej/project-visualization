module Project
       (
         Outcome(..),
         Project(..)
       )
       where

data Outcome = Execute
             | Improvement
             | Learn
             | Sustain
               deriving (Show,Eq)

data Project = Project
               {
                 name :: String
               , outcome :: Outcome
               , cost :: Int
               } deriving (Show)
                 
