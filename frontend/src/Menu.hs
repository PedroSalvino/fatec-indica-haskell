{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Menu where

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

import Text.Read
import Data.Maybe
import Control.Monad.Fix
import Auxiliar
import Homepage
import Indicacoes

data Pagina = Pagina0 | Pagina1 | Pagina2

clickLi :: DomBuilder t m => Pagina -> T.Text -> m (Event t Pagina)
clickLi p t = do
    (ev, _) <- el' "li" (elAttr "a" ("href" =: "#") (text t))
    return ((\_ -> p) <$> domEvent Click ev)

menuLi :: (DomBuilder t m, MonadHold t m) => m (Dynamic t Pagina)
menuLi = do
    evs <- elAttr "header" ("class" =: "header") $ do
        el "div" $ do
          elAttr "a" ("href" =: "#") $ do
            elAttr "img" ("src" =: $(static "fatecindicafi.png") <> ("class" =: "card-img"))  blank
        el "ul" $ do
            p1 <- clickLi Pagina1 "Home"
            p2 <- clickLi Pagina2 "Indicações"
            return (leftmost [p1,p2])
    holdDyn Pagina0 evs

    -- evs <- el "ul" $ do
    --     p1 <- clickLi Pagina1 "Home"
    --     return (leftmost [p1])
    -- holdDyn Pagina0 evs

currPag :: (DomBuilder t m, MonadHold t m, PostBuild t m, MonadFix m) => Pagina -> m ()
currPag p = case p of
    Pagina0 -> main
    Pagina1 -> main
    Pagina2 -> indica

mainPag :: (DomBuilder t m, MonadHold t m, PostBuild t m, MonadFix m) => m ()
mainPag = do
    pag <- menuLi
    dyn_ $ currPag <$> pag