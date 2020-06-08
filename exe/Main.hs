{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Aeson as Aeson

import AWSLambda
import Data.Aeson.Types
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.HashMap.Strict as HM
import qualified Data.Maybe as DM
import Data.Aeson
import Data.Text
import GHC.Generics

import Lib

main = lambdaMain handler

data IPData = IPData { text :: String } deriving (Generic, Show)

instance FromJSON IPData
instance ToJSON IPData

handler :: IPData -> IO(String)
handler evt = do
  putStrLn "This should go to logs"
  let iptext = text evt
  print iptext
  let res = Lib.parseHandler iptext
  print res
  pure res