module View.NotificationIcon exposing (..)

-- import Html exposing (Attribute)

import Html.Attributes exposing (attribute)
import Svg exposing (..)
import Svg.Attributes exposing (cx, cy, fill, height, id, r, viewBox, width)
import View.AlertIcon as AlertIcon


role : String -> Attribute msg
role =
    attribute "role"


ariaLabelledBy : String -> Attribute msg
ariaLabelledBy =
    attribute "aria-labelledby"


allowed : String
allowed =
    "green"


blocked : String
blocked =
    "red"



-- icon : Bool -> Svg msg
-- icon isAllowed =
--     let
--         message =
--             if isAllowed then
--                 "Notifications allowed"
--             else
--                 "Notifications blocked"
--         color =
--             if isAllowed then
--                 allowed
--             else
--                 blocked
--     in
--     AlertIcon.icon color message


icon : Bool -> Svg msg
icon isAllowed =
    let
        message =
            if isAllowed then
                "Notifications allowed"
            else
                "Notifications blocked"

        color =
            if isAllowed then
                allowed
            else
                blocked
    in
    svg
        [ role "image", ariaLabelledBy "notification-title", width "20", height "20", viewBox "0 0 40 40" ]
        [ title [ id "notification-title" ] [ text message ]
        , circle [ fill color, cx "20", cy "20", r "10" ] []
        ]
