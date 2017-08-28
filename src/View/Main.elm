module View.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import View.ActivityIcon as Activity
import View.Notification
import View.Timer
import World exposing (Model, Msg(TicAddTopic, Tick, TimerReset))


view : Model -> Html Msg
view model =
    let
        headerStyle =
            [ ( "padding", "10px" )
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

        wrapperStyle =
            [ ( "display", "grid" )
            , ( "grid-template-rows", "40px 1fr" )
            , ( "height", "100vh" )
            ]
    in
    div [ style wrapperStyle ]
        [ header [ style headerStyle ]
            -- [ Activity.icon "#F26"
            [ Activity.icon "#FFF"
            , topicView model.tic.topic
            , div []
                [ button [ onClick TimerReset, style resetButton ] [ text "Reset timer" ]
                , View.Notification.message model.notifications
                ]
            ]
        , View.Timer.button model.timer model.tic
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
