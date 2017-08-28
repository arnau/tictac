port module Notification exposing (..)

{-| Handle Desktop Notifications and its permissions

See <https://developer.mozilla.org/en-US/docs/Web/API/Notifications_API>

-}


{-| Notifies a message via Desktop Notifications
-}
port notify : String -> Cmd msg


{-| Requests permission to send Desktop Notifications
-}
port requestPermission : String -> Cmd msg


{-| Receives permission from the user to send Desktop Notifications
-}
port receivePermission : (String -> msg) -> Sub msg


type Permission
    = Granted
    | Default
    | Denied


toPermission : String -> Permission
toPermission message =
    case message of
        "granted" ->
            Granted

        "default" ->
            Default

        "denied" ->
            Denied

        -- Unexpected leg
        _ ->
            Denied


isGranted : Permission -> Bool
isGranted permission =
    permission == Granted


denied : Permission
denied =
    Denied
