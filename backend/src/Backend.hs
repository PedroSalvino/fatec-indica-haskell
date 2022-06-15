{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase, GADTs, ScopedTypeVariables #-}

module Backend where

import Common.Route
import Obelisk.Backend
import Database.PostgreSQL.Simple
import Obelisk.Route
import Snap.Core
import Control.Monad.IO.Class (liftIO)
import qualified Data.Aeson as A
import Data.Text (Text)
import Common.Api
import Data.Aeson.Text

migration :: Query
migration = "CREATE TABLE IF NOT EXISTS filme\
\ (id SERIAL PRIMARY KEY, nome TEXT NOT NULL, imagem TEXT NOT NULL, diretor TEXT NOT NULL, elenco TEXT NOT NULL, descricao TEXT NOT NULL)"

getConn :: ConnectInfo
getConn = ConnectInfo "ec2-23-23-182-238.compute-1.amazonaws.com"
                      5432
                      "cncoxkiinphfgv"
                      "8daac8ddfd7c9d01084b4987921189f34499bf9287084d7743ead35a6145e1fd"
                      "ddhaoosq63csah"


backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve -> do
      dbcon <- connect getConn

      serve $ do
        \case
          BackendRoute_Listar :/ () -> method GET $ do
            res :: [Filme] <- liftIO $ do
                  execute_ dbcon migration
                  query_ dbcon "SELECT * from filme"
            modifyResponse $ setResponseStatus 200 "OK"
            writeLazyText (encodeToLazyText res)
          BackendRoute_Filme :/ () -> method POST $ do
            filme <- A.decode <$> readRequestBody 2000
            case filme of
              Just ff -> do
                liftIO $ do
                  execute_ dbcon migration
                  execute dbcon "INSERT INTO filme (nome, imagem, diretor, elenco, descricao) VALUES (?,?,?,?,?)" (filmeNome ff, filmeImagem ff, filmeDiretor ff, filmeElenco ff, filmeDescricao ff)
                modifyResponse $ setResponseStatus 200 "OK"
              _ ->  modifyResponse $ setResponseStatus 500 "Erro ao cadastrar filme"
  , _backend_routeEncoder = fullRouteEncoder
  }