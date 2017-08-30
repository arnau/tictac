module View.Wrapper exposing (..)

import Css exposing (..)
import Css.Extra exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import World exposing (Msg)


type Name
    = Wrapper


rule : Snippet
rule =
    class Wrapper
        [ display grid
        , gridTemplateRows2 (px 50) (fr 1)
        , height (vh 100)
        ]


node : List (Html Msg) -> Html Msg
node children =
    Html.div [ At.class (toString Wrapper) ]
        children
