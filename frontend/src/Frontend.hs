{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}

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
import Control.Monad.Fix
import qualified Data.Aeson as A
import Data.Aeson

-- This runs in a monad that can be run on the client or the server.
-- To run code in a pure client or pure server context, use one of the
-- `prerender` functions.

-- req :: ( DomBuilder t m, Prerender t m) => m ()
-- req = do
--     inputEl <- inputElement def
--     (submitBtn,_) <- el' "button" (text "Inserir")
--     let click = domEvent Click submitBtn
--     let nm = tag (current $ _inputElement_value inputEl) click  
--     _ :: Dynamic t (Event t (Maybe T.Text)) <- prerender
--         (pure never)
--         (fmap decodeXhrResponse <$> performRequestAsync (nomeRequest <$> nm))
--     return ()

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