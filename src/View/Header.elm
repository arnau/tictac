module View.Header exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import View.ActivityIcon as Activity
import View.Help as Help
import View.Mode as Mode
import View.Notification as Notification
import World exposing (Model, Msg)


type Name
    = Header


rule : Snippet
rule =
    class Header
        [ displayFlex
        , padding (px 10)
        , boxSizing borderBox
        , backgroundColor (hex "000")
        , flexDirection row
        , justifyContent spaceBetween
        , alignItems stretch
        , children
            [ Help.rule
            , Mode.rule
            ]
        ]


node : Model -> Html Msg
node model =
    Html.header [ At.class (toString Header) ]
        -- [ Activity.icon "#F26"
        [ Html.div []
            [ Activity.icon "#FFF"
            , Notification.message model.notifications
            ]
        , Help.button
        , Mode.node model.mode
        ]
