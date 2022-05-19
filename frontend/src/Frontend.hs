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


-- This runs in a monad that can be run on the client or the server.
-- To run code in a pure client or pure server context, use one of the
-- `prerender` functions.

menu :: DomBuilder t m => m ()
menu = do
  el "ul" $ do
    el "li" $ do
      el "a" (text "Início")
    el "li" $ do
      el "a" (text "Indicações")
    el "li" $ do
      el "a" (text "Sobre")

-- buttons :: DomBuilder t m => m ()
-- buttons = do
--   elAttr "ol" ("class" =: "carousel-indicators") $ do
--     elAttr "li" ("class" =: "carousel-indicators") $ do
--       el "a" (text "Início")
--     el "li" $ do
--       el "a" (text "Indicações")
--     el "li" $ do
--       el "a" (text "Sobre")


frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      el "title" $ text "Fatec Indica"
      elAttr "link" ("href" =: $(static "main.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "bootstrap.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "bootstrap.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
  , _frontend_body = do
      -- el "h1" $ text "Welcome to Obelisk!"
      -- el "p" $ text $ T.pack commonStuff
      
      -- `prerender` and `prerender_` let you choose a widget to run on the server
      -- during prerendering and a different widget to run on the client with
      -- JavaScript. The following will generate a `blank` widget on the server and
      -- print "Hello, World!" on the client.
      -- prerender_ blank $ liftJSM $ void $ eval ("console.log('Hello, World!')" :: T.Text)

      -- elAttr "img" ("src" =: $(static "obelisk.jpg")) blank
      -- el "div" $ do
        -- exampleConfig <- getConfig "common/example"
        -- case exampleConfig of
        --   Nothing -> text "No config file found in config/common/example"
        --   Just s -> text $ T.decodeUtf8 s
        
      el "header" $ do
        el "div" $ do
          elAttr "img" ("src" =: $(static "banner.png") <> ("class" =: "card-img"))  blank
        menu
      
      elAttr "main" ("class" =: "container") $ do
        elAttr "div" ("class" =: "row" <> "id" =: "inicio") $ do
           elAttr "div" ("class" =: "col-md-12") $ do
              elAttr "div" ("class" =: "carousel" <> "class" =: "slide" <> "data-ride" =: "carousel") $ do
                el "p" (text "Carousel")



      return ()
  }
