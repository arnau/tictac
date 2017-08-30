module Style exposing (..)

-- import Css.Namespace exposing (namespace)

import Css exposing (..)
import Css.Elements exposing (body)
import View.Help as Help
import View.Legend as Legend
import View.Mode as Mode


init : Css.Stylesheet
init =
    -- (stylesheet << namespace "tictac")
    stylesheet
        [ body
            [ backgroundColor (hex "000000")
            , fontFamilies [ "Roboto Condensed", "sans-serif" ]
            , margin zero
            , padding zero
            ]
        , Legend.rule
        , Help.rule
        , Mode.rule
        ]
