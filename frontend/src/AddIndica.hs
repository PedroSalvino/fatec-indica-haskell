{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module AddIndica where

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

import Auxiliar

formIndica :: (DomBuilder t m, PostBuild t m, MonadHold t m, Prerender t m) => m ()
formIndica = do
    elAttr "main" ("class" =: "container-fluid my-2") $ do
        elAttr "div" ("class" =: "row" <> "id" =: "inicio") $ do
            elAttr "div" ("class" =: "col") $ do
                elAttr "h1" ("class" =: "h3 text-center my-2") (text "Faça sua indicação!")
                
                elAttr "div" ("class" =: "row") $ do
                    elAttr "div" ("class" =: "col-md-10 mx-auto text-center area-form") $ do
                    
                    reqFilme

                return ()