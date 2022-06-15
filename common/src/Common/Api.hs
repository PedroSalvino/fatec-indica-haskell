{-# LANGUAGE DeriveGeneric #-}
{-# language DeriveAnyClass #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Common.Api where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics (Generic)
import Database.PostgreSQL.Simple

data Filme = Filme {
    filmeId :: Int,
    filmeNome :: Text,
    filmeImagem :: Text,
    filmeDiretor :: Text,
    filmeElenco :: Text,
    filmeDescricao :: Text
} deriving (Generic, ToJSON, FromJSON, ToRow, FromRow, Eq, Show)

commonStuff :: String
commonStuff = "Here is a string defined in Common.Api"
