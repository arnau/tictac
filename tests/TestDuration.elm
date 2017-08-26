module TestDuration exposing (..)

import Duration exposing (..)
import Expect
import Fuzz exposing (intRange)
import Test exposing (..)


suite : Test
suite =
    describe "Amount operations"
        [ test "Subtract amount of 00:00" <|
            \_ ->
                Expect.equal (subtract 0) Nothing
        , test "Subtract amount of 25:00" <|
            \_ ->
                Expect.equal (subtract 1500) (Just 1499)
        , fuzz (intRange 0 (60 * 25)) "Subtracts amount" <|
            \x ->
                case subtract x of
                    Nothing ->
                        Expect.equal x 0

                    Just result ->
                        Expect.lessThan x result
        , describe "Formatting"
            [ test "Formats 0" <|
                \_ ->
                    Expect.equal (formatDigit 0) "00"
            , test "Formats 42" <|
                \_ ->
                    Expect.equal (formatDigit 42) "42"
            , fuzz (intRange 0 9) "Formats a number below 10 with a leading 0" <|
                \x ->
                    Expect.equal 2 <| String.length (formatDigit 0)
            , test "Formats as 00:00" <|
                \_ ->
                    Expect.equal (format 0) "00:00"
            , test "Formats as 24:59" <|
                \_ ->
                    Expect.equal (format 1499) "24:59"
            ]
        ]
