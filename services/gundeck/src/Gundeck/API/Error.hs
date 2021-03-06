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

module Gundeck.API.Error where

import Data.Text.Lazy (Text)
import Network.HTTP.Types.Status
import Network.Wai.Utilities.Error (Error (..))

notificationNotFound :: Error
notificationNotFound = Error status404 "not-found" "Some notifications not found."

clientError :: Text -> Error
clientError = Error status400 "client-error"

invalidNotificationId :: Error
invalidNotificationId = clientError "Notification ID must be a version 1 UUID"
