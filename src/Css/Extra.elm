module Css.Extra exposing (..)

import Css exposing (..)


{-| Hack to define `display: grid`. elm-css doesn't seem to offer a better
way to do it
-}
grid : Display {}
grid =
    { block | value = "grid" }


fr : Float -> ExplicitLength FrUnits
fr value =
    -- lengthConverter FrUnits "fr" value
    let
        temp =
            px value

        unitLabel =
            "fr"
    in
    { temp
        | units = FrUnits
        , unitLabel = unitLabel
        , value = numberToString value ++ unitLabel
    }


numberToString : number -> String
numberToString num =
    toString (num + 0)


type FrUnits
    = FrUnits


gridTemplateRows2 : LengthOrAuto compatibleA -> LengthOrAuto compatibleB -> Style
gridTemplateRows2 =
    prop2 "grid-template-rows"


justifySelf : JustifySelf -> Style
justifySelf value =
    let
        normalisedValue =
            String.toLower (toString value)
    in
    property "justify-self" normalisedValue


type JustifySelf
    = Start
    | End
    | Center
    | Stretch


prop2 : String -> Value a -> Value b -> Style
prop2 key argA argB =
    property key (String.join " " [ argA.value, argB.value ])
