module View.Topic exposing (..)

import Css exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as At
import World exposing (Model, Msg(RecordAddTopic))


type Name
    = Topic


rule : Snippet
rule =
    class Topic
        [ color (hex "999")
        , fontSize (Css.rem 1.8)
        ]


node : String -> Html Msg
node topic =
    Html.div [ At.class (toString Topic) ]
        [ Html.text topic ]
