{-# LANGUAGE OverloadedStrings #-}

module Project
       (
         Outcome(..),
         Project(..),
	 Cost(..),
	 ProjectId(..)
       )
       where

data Outcome = Execute
             | Improve
             | Learn
             | Sustain
               deriving (Ord,Show,Eq)

data Cost = Low | Medium | High deriving (Ord,Show,Eq)

type ProjectId = String

data Project = Project 
  {
    projectId :: ProjectId
  , name :: String
  , dept :: String
  , support :: String
  , goal :: String
  , outcome :: Outcome
  , tags :: [String]
  , dependency :: [ProjectId]
  , cost :: Cost
  } deriving (Show,Eq)
     