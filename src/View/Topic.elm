module View.Topic exposing (..)

-- import Css exposing (..)
-- import View.Helpers

import Html exposing (Html, button, div, header, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import World exposing (Model, Msg(RecordAddTopic, Tick, TimerReset))


view : String -> Html Msg
view state =
    let
        styleList =
            [ ( "font-size", "1.4rem" )
            , ( "font-family", "'Roboto Condensed', sans-serif" )
            , ( "color", "grey" )
            , ( "background-color", "black" )
            , ( "margin", "0 1rem" )
            , ( "padding", "0.8rem 0" )
            , ( "display", "block" )
            , ( "border", "none" )
            , ( "border-bottom", "1px solid #444" )
            , ( "width", "20vw" )
            ]
    in
    input
        [ type_ "text"
        , style styleList
        , placeholder "Topic"
        , onInput RecordAddTopic
        , value state
        ]
        []
