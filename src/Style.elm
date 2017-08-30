module Style exposing (..)

-- import Css.Namespace exposing (namespace)

import Css exposing (..)
import Css.Elements exposing (body)
import View.Header as Header
import View.Legend as Legend
import View.Timer as Timer
import View.Topic as Topic
import View.TopicInput as TopicInput
import View.Wrapper as Wrapper


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
        , Wrapper.rule
        , Header.rule
        , Legend.rule
        , Topic.rule
        , TopicInput.rule
        , Timer.rule
        ]
