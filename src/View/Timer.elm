module View.Timer exposing (..)

import Css exposing (..)
import Css.Extra exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import Timer exposing (Timer)
import Trail.Record exposing (Record)
import View.Topic as Topic
import World exposing (Msg(..))


type Name
    = Timer
    | TimerStarted


rule : Snippet
rule =
    class Timer
        [ backgroundColor (hex "000")
        , border zero
        , display block
        , fontFamilies [ "Roboto Condensed", "sans-serif" ]
        , fontSize (Css.rem 10)
        , outline none
        , justifySelf Center
        , alignSelf center
        , color (hex "FFF")
        , withClass TimerStarted
            [ color (hex "888")
            ]
        ]


node : Timer -> Record -> Html Msg
node state { topic } =
    Html.div
        [ At.classList
            [ ( toString Timer, True )
            , ( toString TimerStarted, Timer.isRunning state )
            ]
        ]
        [ Topic.node topic
        , Html.text (Timer.formatWithDefault 0 state)
        ]
