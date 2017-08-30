module Keyring exposing (..)

import Keyboard exposing (KeyCode)
import Keyring.Action as Action exposing (Action(..))


type Mode
    = Insert
    | Normal
    | Help


toMode : Mode -> KeyCode -> Maybe Mode
toMode mode code =
    case code of
        72 ->
            -- H
            if isInsert mode then
                Nothing
            else
                Just Help

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


help : Mode
help =
    Help


isNormal : Mode -> Bool
isNormal mode =
    mode == Normal


isInsert : Mode -> Bool
isInsert mode =
    mode == Insert


isHelp : Mode -> Bool
isHelp mode =
    mode == Help


toAction : Mode -> KeyCode -> Maybe Action
toAction mode code =
    case mode of
        Insert ->
            Nothing

        Help ->
            Nothing

        Normal ->
            Action.fromCode code
