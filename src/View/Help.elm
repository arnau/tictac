module View.Help exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import Html.Events exposing (onClick)
import World exposing (Model, Msg(LegendToggle))


type Name
    = Help


rule : Snippet
rule =
    class Help
        [ fontSize (Css.rem 1)
        , fontFamilies [ "Roboto Condensed", "sans-serif" ]
        , backgroundColor (hex "000")
        , border3 (px 1) solid (hex "555")
        , borderRadius (px 3)
        , color (hex "999")
        , minHeight (vh 3)
        , padding2 zero (vh 1)
        ]


button : Html Msg
button =
    Html.button
        [ onClick LegendToggle
        , At.class (toString Help)
        ]
        [ Html.text "Help" ]
