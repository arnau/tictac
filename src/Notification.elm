port module Notification exposing (..)


port notify : String -> Cmd msg


port requestPermission : String -> Cmd msg


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
