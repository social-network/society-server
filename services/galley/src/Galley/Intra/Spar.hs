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

module Galley.Intra.Spar
  ( deleteTeam,
  )
where

import Bilge
import Data.ByteString.Conversion
import Data.Id
import Galley.App
import Galley.Intra.Util
import Imports
import Network.HTTP.Types.Method

-- | Notify Spar that a team is being deleted.
deleteTeam :: TeamId -> Galley ()
deleteTeam tid = do
  (h, p) <- sparReq
  _ <-
    call "spar" $
      method DELETE . host h . port p
        . paths ["i", "teams", toByteString' tid]
        . expect2xx
  pure ()
