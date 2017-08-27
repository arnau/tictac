module View.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Notification
import StatsIcon
import View.Notification
import View.Timer
import World exposing (Model, Msg(TicAddTopic, Tick, TimerReset))


view : Model -> Html Msg
view model =
    let
        headerStyle =
            [ ( "height", "4vh" )
            , ( "padding", "0.4rem" )
            , ( "box-sizing", "border-box" )
            , ( "background-color", "black" )
            , ( "display", "flex" )
            , ( "flex-direction", "row" )
            , ( "justify-content", "space-between" )
            , ( "align-items", "stretch" )
            ]

        resetButton =
            [ ( "font-size", "1rem" )
            , ( "font-family", "'Roboto Condensed', sans-serif" )
            , ( "background-color", "black" )
            , ( "border", "1px solid #555" )
            , ( "border-radius", "3px" )
            , ( "color", "#999" )
            , ( "min-height", "3vh" )
            , ( "padding", "0 1rem" )
            ]
    in
    div []
        [ header [ style headerStyle ]
            [ StatsIcon.regular
            , topicView model.tic.topic
            , button [ onClick TimerReset, style resetButton ] [ text "Reset timer" ]
            ]
        , if Notification.isGranted model.notifications then
            View.Timer.button model.timer model.tic
          else
            View.Notification.message
        ]


topicView : String -> Html Msg
topicView topic =
    let
        topicStyle =
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
        , style topicStyle
        , placeholder "Topic"
        , onInput TicAddTopic
        , value topic
        ]
        []
