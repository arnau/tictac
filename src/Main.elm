module Main exposing (..)

import Html
import Time exposing (Time, second)
import View.Main exposing (view)
import World exposing (Model, Msg(Tick))


main : Program Never Model Msg
main =
    Html.program
        { init = World.init
        , view = view
        , update = World.update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick
