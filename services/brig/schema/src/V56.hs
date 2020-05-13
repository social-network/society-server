{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

-- This file is part of the Society Server implementation.
--

--
-- This program is free software: you can redistribute it and/or modify it under
-- the terms of the GNU Affero General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option) any
-- later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
-- details.
--
-- You should have received a copy of the GNU Affero General Public License along
-- with this program. If not, see <https://www.gnu.org/licenses/>.

module V56
  ( migration,
  )
where

import Cassandra.Schema
import Imports
import Text.RawString.QQ

migration :: Migration
migration = Migration 56 "Add table to exclude phone number prefixes" $ do
  -- A table for manual excluding of phone number prefixes that abuse sms sending
  -- and/or calling.
  --
  -- Operations we need to support:
  --   * Add a new prefix of arbitrary length
  --   * Remove a prefix
  --   * Given a phone number, check whether it matches any existing prefix
  void $
    schema'
      [r|
        create table if not exists excluded_phones
            ( prefix text
            , comment text
            , primary key (prefix)
            )
    |]