module Keyring exposing (..)

import Keyboard exposing (KeyCode)
import Keyring.Action as Action exposing (Action(..))


type Mode
    = Insert
    | Normal


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
            Action.fromCode code
