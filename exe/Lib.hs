-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree. An additional grant
-- of patent rights can be found in the PATENTS file in the same directory.


{-# LANGUAGE
    DeriveGeneric
  , OverloadedStrings
  #-}

module Lib where

import Control.Applicative hiding (empty)
import Control.Arrow ((***))
import Control.Monad (unless)
import Control.Monad.IO.Class
import Data.Aeson
import qualified Data.Aeson as Aeson
import Data.ByteString (ByteString, empty)
import Data.HashMap.Strict (HashMap)
import Data.Maybe
import Data.String
import Data.Char                   (chr)
import Data.Text (Text)
import Data.Time.LocalTime.TimeZone.Series
import Prelude
import System.Directory
import TextShow
import Text.Read (readMaybe)
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as LBS
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)

import Duckling.Core
import Duckling.Data.TimeZone
import Duckling.Resolve (DucklingTime)
import qualified Data.Time as Time
import Data.Fixed (Pico)
import Duckling.Testing.Types

import GHC.Generics


parseHandler :: String -> String
parseHandler parsetext = do
    let cont =  Context
                { locale = makeLocale EN Nothing
                , referenceTime = refTime (2020, 4, 28, 4, 30, 0) (-2)
                    -- 
                }
    let opt = Options
                { withLatent = False
                }
    let dims = []
    let inText = parsetext
    let parsedResult = parse (Text.pack inText) cont opt dims
    let res = encode parsedResult
    map (chr . fromEnum) . LBS.unpack $ res
