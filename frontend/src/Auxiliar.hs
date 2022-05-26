{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Auxiliar where

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

import Text.Read
import Data.Maybe

textoInput :: (DomBuilder t m, PostBuild t m) => m ()
textoInput = do
    el "div" $ do
        t <- inputElement def 
        text " "
    -- dynText (zipDynWith (<>) (_inputElement_value t))

textoArea :: (DomBuilder t m, PostBuild t m) => m ()
textoArea = do
    el "div" $ do
        t <- textAreaElement def
        text " "
-- formulario de indicacoes

campoNome :: (DomBuilder t m, PostBuild t m) => m ()
campoNome = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Título do Filme")
        nome <- textoInput
        return ()

campoDiretor :: (DomBuilder t m, PostBuild t m) => m ()
campoDiretor = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Diretor(a)")
        nome <- textoInput
        return ()

campoElenco :: (DomBuilder t m, PostBuild t m) => m ()
campoElenco = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Elenco")
        nome <- textoArea
        return ()

campoImagem :: (DomBuilder t m, PostBuild t m) => m ()
campoImagem = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Link do Poster")
        imagem <- textoInput
        return ()

campoDesc :: (DomBuilder t m, PostBuild t m) => m ()
campoDesc = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Sinopse")
        desc <- textoArea
        return ()

botaoEnviar :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
botaoEnviar = do
    elAttr "button" ("class" =: "btn btn-success btn-block col-8 mx-auto") (text "Divulgar")
    return ()
