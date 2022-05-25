{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Frontend where

import Control.Monad
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import Language.Javascript.JSaddle (eval, liftJSM)

import Obelisk.Frontend
import Obelisk.Configs
import Obelisk.Route
import Obelisk.Generated.Static

import Reflex.Dom.Core

import Common.Api
import Common.Route
import Menu


-- This runs in a monad that can be run on the client or the server.
-- To run code in a pure client or pure server context, use one of the
-- `prerender` functions.

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      el "title" $ text "Fatec Indica"
      elAttr "link" ("href" =: $(static "bootstrap.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "bootstrap.css.map") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "main.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      
      elAttr "script" ("src" =: $(static "jquery.min.js")) blank
      elAttr "script" ("src" =: $(static "bootstrap.js")) blank
      elAttr "script" ("src" =: $(static "bootstrap.js.map")) blank
      elAttr "script" ("src" =: $(static "main.js")) blank
  , _frontend_body = do
     
      mainPag
      
      return ()
  }
