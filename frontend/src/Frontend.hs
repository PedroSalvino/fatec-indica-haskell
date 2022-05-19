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
      elAttr "a" ("href" =: "#") (text "Início")
    el "li" $ do
      elAttr "a" ("href" =: "#") (text "Indicações")
    el "li" $ do
      elAttr "a" ("href" =: "#") (text "Sobre")

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
      elAttr "link" ("href" =: $(static "bootstrap.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "bootstrap.css.map") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      elAttr "link" ("href" =: $(static "main.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
      
      elAttr "script" ("src" =: $(static "jquery.min.js")) blank
      elAttr "script" ("src" =: $(static "bootstrap.js")) blank
      elAttr "script" ("src" =: $(static "bootstrap.js.map")) blank
      elAttr "script" ("src" =: $(static "main.js")) blank
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
        
      elAttr "header" ("class" =: "header") $ do
        el "div" $ do
          elAttr "a" ("href" =: "#") $ do
            elAttr "img" ("src" =: $(static "fatecindicafi.png") <> ("class" =: "card-img"))  blank
        menu
      
      elAttr "main" ("class" =: "container-fluid") $ do
        elAttr "div" ("class" =: "row" <> "id" =: "inicio") $ do
           elAttr "div" ("class" =: "col") $ do
              elAttr "div" ("class" =: "carousel slide" <> "data-ride" =: "carousel" <> "id" =: "carrossel") $ do
                elAttr "ol" ("class" =: "carousel-indicators") $ do
                  elAttr "li" ("data-target" =: "carrossel" <> "data-slide-to" =: "0" <> "class" =: "active") blank
                  elAttr "li" ("data-target" =: "carrossel" <> "data-slide-to" =: "1") blank
                  elAttr "li" ("data-target" =: "carrossel" <> "data-slide-to" =: "2") blank
                elAttr "div" ("class" =: "carousel-inner") $ do
                  elAttr "div" ("class" =: "carousel-item active") $ do
                    elAttr "img" ("src" =: $(static "BANNER1.png") <> ("class" =: "d-block" <> "class" =: "w-100")) blank
                  elAttr "div" ("class" =: "carousel-item") $ do
                    elAttr "img" ("src" =: $(static "BANNER2.png") <> ("class" =: "d-block" <> "class" =: "w-100")) blank
                  elAttr "div" ("class" =: "carousel-item") $ do
                    elAttr "img" ("src" =: $(static "BANNER3.png") <> ("class" =: "d-block" <> "class" =: "w-100")) blank
                elAttr "a" ("class" =: "carousel-control-prev" <> "href" =: "#carrossel" <> "role" =: "button" <> "data-slide" =: "prev") $ do
                  elAttr "span" ("class" =: "carousel-control-prev-icon" <> "aria-hidden" =: "true") blank
                  elAttr "span" ("class" =: "sr-only") (text "Anterior")
                elAttr "a" ("class" =: "carousel-control-next" <> "href" =: "#carrossel" <> "role" =: "button" <> "data-slide" =: "next") $ do
                  elAttr "span" ("class" =: "carousel-control-next-icon" <> "aria-hidden" =: "true") blank
                  elAttr "span" ("class" =: "sr-only") (text "Próximo")


      return ()
  }
