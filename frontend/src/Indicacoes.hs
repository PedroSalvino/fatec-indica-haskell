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

indica :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
indica = do
    elAttr "main" ("class" =: "container-fluid my-2") $ do
        elAttr "div" ("class" =: "row" <> "id" =: "inicio") $ do
            elAttr "div" ("class" =: "col-md-10 mx-auto") $ do
                elAttr "h1" ("class" =: "text-center h3 my-2") (text "Todas as Indicações")

            -- cards
                elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
                    elAttr "div" ("class" =: "row") $ do
                        elAttr "div" ("class" =: "col-md-4") $ do
                            elAttr "img" ("src" =: "https://dummyimage.com/400x200/b01116/000" <> "class" =: "card-img") blank
                        elAttr "div" ("class" =: "col-md-8") $ do
                            elAttr "div" ("class" =: "card-body") $ do
                                elAttr "h2" ("class" =: "text-center") (text "Filme 1")
                                elAttr "p" ("class" =: "card-text") (text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.")
                -- 2
                elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
                    elAttr "div" ("class" =: "row") $ do
                        elAttr "div" ("class" =: "col-md-4") $ do
                            elAttr "img" ("src" =: "https://dummyimage.com/400x200/b01116/000" <> "class" =: "card-img") blank
                        elAttr "div" ("class" =: "col-md-8") $ do
                            elAttr "div" ("class" =: "card-body") $ do
                                elAttr "h2" ("class" =: "text-center") (text "Filme 2")
                                elAttr "p" ("class" =: "card-text") (text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.")
                -- 3
                elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
                    elAttr "div" ("class" =: "row") $ do
                        elAttr "div" ("class" =: "col-md-4") $ do
                            elAttr "img" ("src" =: "https://dummyimage.com/400x200/b01116/000" <> "class" =: "card-img") blank
                        elAttr "div" ("class" =: "col-md-8") $ do
                            elAttr "div" ("class" =: "card-body") $ do
                                elAttr "h2" ("class" =: "text-center") (text "Filme 3")
                                elAttr "p" ("class" =: "card-text") (text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.")
                -- 4
                elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
                    elAttr "div" ("class" =: "row") $ do
                        elAttr "div" ("class" =: "col-md-4") $ do
                            elAttr "img" ("src" =: "https://dummyimage.com/400x200/b01116/000" <> "class" =: "card-img") blank
                        elAttr "div" ("class" =: "col-md-8") $ do
                            elAttr "div" ("class" =: "card-body") $ do
                                elAttr "h2" ("class" =: "text-center") (text "Filme 4")
                                elAttr "p" ("class" =: "card-text") (text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.")
                -- 5
                elAttr "div" ("class" =: "card my-2" <> "style" =: "height: auto") $ do
                    elAttr "div" ("class" =: "row") $ do
                        elAttr "div" ("class" =: "col-md-4") $ do
                            elAttr "img" ("src" =: "https://dummyimage.com/400x200/b01116/000" <> "class" =: "card-img") blank
                        elAttr "div" ("class" =: "col-md-8") $ do
                            elAttr "div" ("class" =: "card-body") $ do
                                elAttr "h2" ("class" =: "text-center") (text "Filme 5")
                                elAttr "p" ("class" =: "card-text") (text "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.")
    
    -- elAttr "footer" ("class" =: "footer") $ do
    --     elAttr "p" ("class" =: "text-center text-white") (text "Desenvolvido por © WPK")                                            
