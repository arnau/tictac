module View.Timer exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import Timer exposing (Timer)
import Trail.Record exposing (Record)
import View.Helpers exposing (style)
import View.Topic as Topic
import World exposing (Msg(..))


type Name
    = Timer


rule : Snippet
rule =
    class Timer
        [ backgroundColor (hex "000")
        , border zero
        , display block
        , fontFamilies [ "Roboto Condensed", "sans-serif" ]
        , fontSize (Css.rem 10)
        , outline none
        ]


node : Timer -> Record -> Html Msg
node state { topic } =
    let
        color_ =
            [ color
                (if Timer.isRunning state then
                    hex "CCC"
                 else
                    hex "FFF"
                )
            ]
    in
    Html.button [ At.class (toString Timer), style color_ ]
        [ Topic.node topic
        , Html.text (Timer.formatWithDefault 0 state)
        ]
