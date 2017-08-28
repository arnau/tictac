module View.AlertIcon exposing (..)

{-| This icon is a translation from "alert-circle.svg" from <https://feathericons.com/>

Its original license is MIT <https://github.com/colebemis/feather/blob/master/LICENSE>

Thanks to Cole Bemis for the effort of making this nice icon set.

-}

import Html.Attributes exposing (attribute)
import Svg exposing (Attribute, Svg, circle, line, svg, text)
import Svg.Attributes exposing (..)


role : String -> Attribute msg
role =
    attribute "role"


ariaLabelledBy : String -> Attribute msg
ariaLabelledBy =
    attribute "aria-labelledby"


icon : String -> String -> Svg msg
icon color title =
    svg
        [ role "image"
        , ariaLabelledBy "notification-title"
        , width "24"
        , height "24"
        , viewBox "0 0 24 24"
        , stroke color
        , strokeWidth "2"
        , fill "none"
        , strokeLinecap "round"
        , strokeLinejoin "round"
        ]
        [ Svg.title [] [ text title ]
        , circle [ cx "12", cy "12", r "10" ] []
        , line [ x1 "12", y1 "8", x2 "12", y2 "12" ] []
        , line [ x1 "12", y1 "16", x2 "12", y2 "16" ] []
        ]
