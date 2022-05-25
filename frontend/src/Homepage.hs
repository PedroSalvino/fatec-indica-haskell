{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Homepage where

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


main :: (DomBuilder t m, PostBuild t m, MonadHold t m) => m ()
main = do
      elAttr "main" ("class" =: "container-fluid my-2") $ do
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
        elAttr "div" ("class" =: "row py-5" <> "id" =: "filmes") $ do
          elAttr "section" ("class" =: "col-md-10 mx-auto") $ do
            el "h2" (text "Indicação dos Editores")  

            elAttr "div" ("class" =: "row") $ do
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme1") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto1") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 1")
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme2") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto2") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 2")
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme3") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto3") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 3")
            elAttr "div" ("class" =: "row my-3") $ do
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme4") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto4") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 4")
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme5") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto5") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 5")
              elAttr "div" ("class" =: "col") $ do
                -- Filme 1
                elAttr "a" ("href" =: "#" <> "data-toggle" =: "modal" <> "data-target" =: "#filmeModal" <> "id" =: "filme6") $ do
                  elAttr "div" ("class" =: "card bg-dark") $ do
                    elAttr "img" ("src" =: "https://dummyimage.com/600x400/b01116/000" <> "class" =: "card-img" <> "id" =: "foto6") blank
                    elAttr "div" ("class" =: "card-body") $ do
                      elAttr "p" ("class" =: "card-title text-center" <> "id" =: "titulo1") (text "Filme 6")

        elAttr "div" ("class" =: "row py-auto mx-5" <> "id" =: "sobre") $ do
          el "h2" (text "Sobre o Projeto")
          elAttr "div" ("class" =: "row") $ do
            elAttr "div" ("class" =: "col-md-6") $ do
              el "p" (text "Você não aguenta mais passar horas e horas na frente do computador tentando achar um filme bacana para assistir? Finalmente achamos a solução!")
              el "p" (text "Nossa iniciativa é trazer a todos os nossos usuários uma nova perpectiva sobre cada filme que abordamos, dando a vocês nossa mais integra e sincera avaliação para cada filme que avaliamos.")
            elAttr "div" ("class" =: "col-md-6") $ do
              elAttr "div" ("class" =: "row") $ do
                elAttr "div" ("class" =: "col") $ do
                  elAttr "a" ("href" =: "https://linktr.ee/kateodoros") $ do
                    elAttr "img" ("src" =: $(static "karoline.png")) blank
                    elAttr "p" ("class" =: "text-center") (text "Karoline Teodoro")
                elAttr "div" ("class" =: "col") $ do
                  elAttr "a" ("href" =: "https://linktr.ee/pedrosalvino") $ do
                    elAttr "img" ("src" =: $(static "pedro.jpg")) blank
                    elAttr "p" ("class" =: "text-center") (text "Pedro Salvino")
                elAttr "div" ("class" =: "col") $ do
                  elAttr "a" ("href" =: "https://linktr.ee/wesley23") $ do
                    elAttr "img" ("src" =: $(static "wesley.png")) blank
                    elAttr "p" ("class" =: "text-center") (text "Wesley Nascimento")
      return ()