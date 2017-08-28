module View.Timer exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Events exposing (onClick)
import Tic exposing (Tic)
import Timer exposing (Timer)
import View.Helpers exposing (style)
import World exposing (Msg(..))


button : Timer -> Tic -> Html Msg
button state { topic, amount } =
    let
        clickAction =
            if Timer.isRunning state then
                TimerStop
            else
                TimerStart

        buttonStyle =
            [ backgroundColor (hex "000")
            , border zero
            , color
                (if Timer.isRunning state then
                    hex "CCC"
                 else
                    hex "FFF"
                )
            , display block
            , fontFamilies [ "Roboto Condensed", "sans-serif" ]
            , fontSize (Css.rem 10)
            , outline none
            ]
    in
    Html.button [ onClick clickAction, style buttonStyle ]
        [ Html.text (Timer.formatWithDefault 0 state)
        ]
