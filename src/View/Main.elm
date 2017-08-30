module View.Main exposing (..)

import Html exposing (Html, button, div, header, input)
import Keyring exposing (Mode(..))
import View.Header as Header
import View.Legend as Legend
import View.Timer as Timer
import View.TopicInput as TopicInput
import View.Wrapper as Wrapper
import World exposing (Model, Msg(TimerReset))


view : Model -> Html Msg
view model =
    Wrapper.node
        [ Header.node model
        , case model.mode of
            Help ->
                Legend.node model

            Insert ->
                TopicInput.node model

            Normal ->
                Timer.button model.timer model.record
        ]
