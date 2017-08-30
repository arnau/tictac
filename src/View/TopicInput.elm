module View.TopicInput exposing (..)

import Css exposing (..)
import Css.Elements exposing (input)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import Html.Events exposing (onInput)
import World exposing (Model, Msg(RecordAddTopic))


type Name
    = TopicInput


rule : Snippet
rule =
    class TopicInput
        [ margin auto
        , width (pct 80)
        , children
            [ input
                [ backgroundColor (hex "000")
                , border zero
                , borderBottom3 (px 1) solid (hex "666")
                , outlineOffset (px 10)
                , borderRadius (px 2)
                , color (hex "FFF")
                , fontSize (Css.rem 8)
                , padding2 (px 5) zero
                , textAlign center
                , width (pct 100)
                , focus
                    [ borderBottom3 (px 2) solid (hex "F89")
                    , outline zero
                    ]
                ]
            ]
        ]


node : Model -> Html Msg
node model =
    Html.div [ At.class (toString TopicInput) ]
        [ Html.input
            [ At.type_ "text"
            , At.placeholder "Topic"
            , onInput RecordAddTopic
            , At.autofocus True
            , At.value model.record.topic
            ]
            []
        ]
