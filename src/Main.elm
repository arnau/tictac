module Main exposing (..)

import Html
import Notification exposing (receivePermission)
import Time exposing (Time, second)
import View.Main exposing (view)
import World exposing (Flags, Model, Msg(AllowNotifications, Tick))


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = World.init
        , view = view
        , update = World.update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every second Tick
        , receivePermission AllowNotifications
        ]
