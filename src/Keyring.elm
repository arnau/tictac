module Keyring exposing (..)

import Char
import Keyboard exposing (KeyCode)


type Mode
    = Insert
    | Normal


type Action
    = Reset
    | Start
    | Pause
    | SwitchToWork
    | SwitchToBreak


toMode : KeyCode -> Maybe Mode
toMode code =
    case code of
        73 ->
            -- I
            Just Insert

        27 ->
            -- Esc
            Just Normal

        _ ->
            Nothing


normal : Mode
normal =
    Normal


isNormal : Mode -> Bool
isNormal mode =
    mode == Normal


isInsert : Mode -> Bool
isInsert mode =
    mode == Insert


toAction : Mode -> KeyCode -> Maybe Action
toAction mode code =
    case mode of
        Insert ->
            Nothing

        Normal ->
            normalToAction code


normalToAction : KeyCode -> Maybe Action
normalToAction code =
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
