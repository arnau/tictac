module View.Main exposing (..)

-- import Css exposing (..)
-- import View.Helpers

import Html exposing (Html, button, div, header, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import View.ActivityIcon as Activity
import View.Notification as Notification
import View.Timer as Timer
import View.Topic as Topic
import World exposing (Model, Msg(TimerReset))


-- grid : Display {}
-- grid =
--     { value = "grid"
--     , display = Compatible
--     }


view : Model -> Html Msg
view model =
    wrapper
        [ topBar model
        , Timer.button model.timer model.record
        ]


wrapper : List (Html Msg) -> Html Msg
wrapper children =
    let
        styleList =
            [ ( "display", "grid" )
            , ( "grid-template-rows", "40px 1fr" )
            , ( "height", "100vh" )
            ]
    in
    div [ style styleList ]
        children


topBar : Model -> Html Msg
topBar model =
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
    in
    header [ style headerStyle ]
        -- [ Activity.icon "#F26"
        [ Activity.icon "#FFF"
        , Topic.view model.record.topic
        , div []
            [ button [ onClick TimerReset, style resetButton ] [ Html.text "Reset timer" ]
            , Notification.message model.notifications
            ]
        ]
