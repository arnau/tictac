module Keyring.Action exposing (..)

import Char
import Keyboard exposing (KeyCode)


type Action
    = Reset
    | Start
    | Pause
    | SwitchToWork
    | SwitchToBreak


fromCode : KeyCode -> Maybe Action
fromCode code =
    case Char.fromCode code of
        'X' ->
            Just Reset

        'S' ->
            Just Start

        'P' ->
            Just Pause

        'W' ->
            Just SwitchToWork

        'B' ->
            Just SwitchToBreak

        _ ->
            Nothing
