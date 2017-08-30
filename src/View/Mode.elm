module View.Mode exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import Keyring
import World exposing (Msg)


type Name
    = Mode


rule : Snippet
rule =
    class Mode
        [ backgroundColor (hex "F89")
        , border3 (px 1) solid (hex "404")
        , borderRadius (px 2)
        , color (hex "000")
        , padding2 (px 5) (px 10)
        ]


node : Keyring.Mode -> Html Msg
node mode =
    Html.div [ At.class (toString Mode) ]
        [ Html.text (toString mode) ]
