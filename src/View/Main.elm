module View.Main exposing (..)

-- import View.Helpers

import Css exposing (..)
import Html exposing (Html, button, div, header, input)
import Html.Attributes exposing (..)
import Keyring
import View.ActivityIcon as Activity
import View.Help as Help
import View.Legend as Legend
import View.Mode as Mode
import View.Notification as Notification
import View.Timer as Timer
import View.TopicInput as TopicInput
import World exposing (Model, Msg(TimerReset))


{-| Hack to define `display: grid`. elm-css doesn't seem to offer a better
way to do it
-}
grid : Display {}
grid =
    { block | value = "grid" }


view : Model -> Html Msg
view model =
    wrapper
        [ topBar model
        , if Keyring.isHelp model.mode then
            Legend.node model
          else if Keyring.isInsert model.mode then
            TopicInput.node model
          else
            Timer.button model.timer model.record
        ]


wrapper : List (Html Msg) -> Html Msg
wrapper children =
    let
        styleList =
            [ ( "display", "grid" )
            , ( "grid-template-rows", "50px 1fr" )
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
    in
    header [ style headerStyle ]
        -- [ Activity.icon "#F26"
        [ div []
            [ Activity.icon "#FFF"
            , Notification.message model.notifications
            ]
        , Help.button
        , Mode.node model.mode
        ]
