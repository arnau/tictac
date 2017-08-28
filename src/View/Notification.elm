module View.Notification exposing (..)

import Html exposing (Attribute, Html)
import Notification exposing (Permission)
import View.NotificationIcon exposing (icon)
import World exposing (Msg)


message : Permission -> Html Msg
message permission =
    icon (Notification.isGranted permission)
