module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)


type Classes
    = Container
    | Timer
    | Header


type Ids
    = Main


init : Css.Stylesheet
init =
    stylesheet
        [ body
            [ backgroundColor (hex "000000")
            , margin zero
            , padding zero
            ]
        ]
