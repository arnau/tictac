module View.Helpers exposing (style)

import Css exposing (Style)
import Html exposing (Attribute)
import Html.Attributes as At
import World exposing (Msg)


style : List Style -> Attribute Msg
style =
    Css.asPairs >> At.style
