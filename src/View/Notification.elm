module View.Notification exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import World exposing (Msg(..))


style : List Style -> Attribute Msg
style =
    Css.asPairs >> At.style


message : Html Msg
message =
    let
        buttonStyle =
            [ backgroundColor (hex "000")
            , border zero
            , color (hex "FFF")
            , display block
            , fontFamilies [ "Roboto Condensed", "sans-serif" ]
            , fontSize (Css.rem 3)
            , textAlign left
            , height (vh 96)
            , width (vw 100)
            ]

        wrapper =
            [ width (vw 50)
            , padding2 (vw 5) zero
            , margin auto
            ]
    in
    Html.div [ style buttonStyle ]
        [ Html.div [ style wrapper ]
            [ Html.text "TicTac needs access to Desktop Notifications to operate"
            ]
        ]
