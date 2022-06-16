{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Indicacoes where

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
import Control.Monad.Fix

import Auxiliar

indica :: (DomBuilder t m, PostBuild t m, MonadHold t m, MonadFix m, Prerender t m) => m ()
indica = do
    elAttr "main" ("class" =: "container-fluid my-2") $ do
        elAttr "div" ("class" =: "row" <> "id" =: "inicio") $ do
            elAttr "div" ("class" =: "col-md-10 mx-auto") $ do
                elAttr "h1" ("class" =: "text-center h3 my-2") (text "Todas as Indicações")

                reqLista

    -- elAttr "footer" ("class" =: "footer") $ do
    --     elAttr "p" ("class" =: "text-center text-white") (text "Desenvolvido por © WPK")                                            
