module View.Main exposing (..)

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
import View.Wrapper as Wrapper
import World exposing (Model, Msg(TimerReset))


view : Model -> Html Msg
view model =
    Wrapper.node
        [ topBar model
        , if Keyring.isHelp model.mode then
            Legend.node model
          else if Keyring.isInsert model.mode then
            TopicInput.node model
          else
            Timer.button model.timer model.record
        ]


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
