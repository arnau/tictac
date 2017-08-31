module Trail.TestRecord exposing (..)

import Date
import Expect exposing (Expectation)
import Test exposing (..)
import Trail.Record exposing (..)


expectWork : Record -> Expectation
expectWork actual =
    let
        message =
            "Expected a Work record but found\n\n" ++ toString actual
    in
    Expect.true message <| isWork actual


expectRest : Record -> Expectation
expectRest actual =
    let
        message =
            "Expected a Rest record but found\n\n" ++ toString actual
    in
    Expect.true message <| isRest actual


suite : Test
suite =
    describe "Record"
        [ test "Init Rest inits Rest" <|
            \_ ->
                expectRest <| initRest
        , test "Init Work inits Work" <|
            \_ ->
                expectWork <| initWork "foo"
        , test "Opposite of Work is Rest" <|
            \_ ->
                expectRest <| opposite "foo" (initWork "foo")
        , test "Opposite of Rest is Work" <|
            \_ ->
                expectWork <| opposite "foo" initRest
        , test "Next from [Work] is Rest" <|
            \_ ->
                expectRest <| next [ initWork "foo" ]
        , test "Next from [Rest] is Work" <|
            \_ ->
                expectWork <| next [ initRest, initWork "foo" ]
        , test "Stamp record with start date" <|
            \_ ->
                let
                    record =
                        initWork "foo"

                    date =
                        Date.fromTime 0

                    actual =
                        startWith date record
                in
                Expect.equal actual.startDate (Just date)
        ]
