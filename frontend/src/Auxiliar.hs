{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}

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

import qualified Data.Aeson as A
import Data.Aeson

getPath :: R BackendRoute -> T.Text
getPath p = renderBackendRoute checFullREnc p

sendRequest :: ToJSON a => R BackendRoute -> a -> XhrRequest T.Text
sendRequest r dados = postJson (getPath r) dados

getListReq :: XhrRequest ()
getListReq = xhrRequest "GET" (getPath (BackendRoute_Listar :/ ())) def

-- tabFilme :: DomBuilder t m => Filme -> m ()
-- tabFilme ff = do
--     el "tr" $ do
--         el "td" (text $ T.pack $ show $ filmeId ff)
--         el "td" (text $ filmeNome ff)
--         el "td" (text $ T.pack $ show $ filmeImagem ff)
--         el "td" (text $ T.pack $ show $ filmeDiretor ff)
--         el "td" (text $ T.pack $ show $ filmeElenco ff)
--         el "td" (text $ T.pack $ show $ filmeDescricao ff)

-- reqLista :: ( DomBuilder t m, Prerender t m, MonadHold t m, MonadFix m, PostBuild t m) => m ()
-- reqLista = do
--     (btn, _) <- el' "button" (text "Listar")
--     let click = domEvent Click btn
--     prods :: Dynamic t (Event t (Maybe [Filme])) <- prerender
--         (pure never)
--         (fmap decodeXhrResponse <$> performRequestAsync (const getListReq <$> click))
--     dynP <- foldDyn (\ps d -> case ps of
--                         Nothing -> []
--                         Just p -> d++p) [] (switchDyn prods)
--     el "table" $ do
--         el "thead" $ do
--             el "tr" $ do
--                 el "th" (text "Id")
--                 el "th" (text "Nome")
--                 el "th" (text "Imagem")
--                 el "th" (text "Diretor")
--                 el "th" (text "Elenco")
--                 el "th" (text "Descri????o")
--         el "tbody" $ do
--             dyn_ (fmap sequence (ffor dynP (fmap tabFilme)))

cardFilme :: DomBuilder t m => Filme -> m ()
cardFilme ff = do
    elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
        elAttr "div" ("class" =: "row") $ do
            elAttr "div" ("class" =: "col-md-4") $ do
                elAttr "img" ("src" =: (filmeImagem ff)  <> "class" =: "card-img") blank
            elAttr "div" ("class" =: "col-md-8") $ do
                elAttr "div" ("class" =: "card-body") $ do
                    elAttr "h2" ("class" =: "text-center") (text $ filmeNome ff)

                    elAttr "h3" ("class" =: "text-primary h4") (text "Diretor")
                    elAttr "p" ("class" =: "card-text") (text $ filmeDiretor ff)
                    
                    elAttr "h3" ("class" =: "text-primary h4") (text "Elenco")
                    elAttr "p" ("class" =: "card-text") (text $ filmeElenco ff)
                    
                    elAttr "h3" ("class" =: "text-primary") (text "Sinopse")
                    elAttr "p" ("class" =: "card-text") (text $ T.pack $ show $ filmeDescricao ff)
                    
reqLista :: ( DomBuilder t m, Prerender t m, MonadHold t m, MonadFix m, PostBuild t m) => m ()
reqLista = do
    (btn, _) <- elAttr' "button" ("class" =: "btn btn-primary btn-block col-8 mx-auto my-3") (text "Listar Indica????es")
    let click = domEvent Click btn
    prods :: Dynamic t (Event t (Maybe [Filme])) <- prerender
        (pure never)
        (fmap decodeXhrResponse <$> performRequestAsync (const getListReq <$> click))
    dynP <- foldDyn (\ps d -> case ps of
                        Nothing -> []
                        Just p -> d++p) [] (switchDyn prods)

    dyn_ (fmap sequence (ffor dynP (fmap cardFilme)))


cardFilmes :: DomBuilder t m => Filme -> m ()
cardFilmes ff = do
    elAttr "div" ("class" =: "col-md-4 my-2") $ do
        elAttr "div" ("class" =: "card bg-dark") $ do
            elAttr "img" ("src" =: (filmeImagem ff)  <> "class" =: "card-img") blank
            elAttr "div" ("class" =: "card-body") $ do
                elAttr "p" ("class" =: "card-title text-center") (text $ filmeNome ff)

reqListar :: ( DomBuilder t m, Prerender t m, MonadHold t m, MonadFix m, PostBuild t m) => m ()
reqListar = do
    (btn, _) <- elAttr' "button" ("class" =: "btn btn-secondary btn-block mx-auto my-3") (text "Ver Indica????es")
    let click = domEvent Click btn
    prods :: Dynamic t (Event t (Maybe [Filme])) <- prerender
        (pure never)
        (fmap decodeXhrResponse <$> performRequestAsync (const getListReq <$> click))
    dynP <- foldDyn (\ps d -> case ps of
                        Nothing -> []
                        Just p -> d++p) [] (switchDyn prods)

    dyn_ (fmap sequence (ffor dynP (fmap cardFilmes)))

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
        elAttr "label" ("class" =: "h5 mr-2") (text "T??tulo do Filme")
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
        nome <- textoInput
        return ()

campoImagem :: (DomBuilder t m, PostBuild t m) => m ()
campoImagem = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Link do Poster")
        nome <- textoInput
        return ()

campoDesc :: (DomBuilder t m, PostBuild t m) => m ()
campoDesc = do
    elAttr "div" ("class" =: "form-group") $ do
        elAttr "label" ("class" =: "h5 mr-2") (text "Sinopse")
        nome <- textoInput
        return ()

botaoEnviar :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
botaoEnviar = do
    elAttr "button" ("class" =: "btn btn-success btn-block col-8 mx-auto") (text "Divulgar")
    return ()

reqFilme :: ( DomBuilder t m, Prerender t m, PostBuild t m) => m ()
reqFilme = do
    
    elAttr "label" ("class" =: "h5 my-2") (text "T??tulo do Filme")
    el "br" blank
    nome <- inputElement def

    el "hr" blank

    elAttr "label" ("class" =: "h5 my-2") (text "URL da Imagem")
    el "br" blank
    imagem <- inputElement def

    el "hr" blank

    elAttr "label" ("class" =: "h5 my-2") (text "Diretor")
    el "br" blank
    diretor <- inputElement def

    el "hr" blank
    
    elAttr "label" ("class" =: "h5 my-2") (text "Elenco")
    el "br" blank
    elenco <- inputElement def

    el "hr" blank

    elAttr "label" ("class" =: "h5 my-2") (text "Sinopse")
    el "br" blank
    descricao <- inputElement def

    let film = fmap (\((((n,im),d),e),dc) -> Filme 0 n im d e dc)
            (zipDyn (zipDyn (zipDyn (zipDyn (_inputElement_value nome) (_inputElement_value imagem)) (_inputElement_value diretor)) (_inputElement_value elenco)) (_inputElement_value descricao))
    (submitBtn,_) <- elAttr' "button" ("class" =: "btn btn-success btn-block col-8 mx-auto my-3") (text "Inserir")
    let click = domEvent Click submitBtn
    let prodEvt = tag (current film) click
    _ :: Dynamic t (Event t (Maybe T.Text)) <- prerender
        (pure never)
        (fmap decodeXhrResponse <$>
            performRequestAsync (sendRequest (BackendRoute_Filme :/ ())
                <$> prodEvt))
    return ()