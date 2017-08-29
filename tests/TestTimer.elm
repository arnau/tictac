module TestTimer exposing (..)

import Expect
import Test exposing (..)
import Timer exposing (..)


suite : Test
suite =
    describe "Clock"
        [ test "A new clock doesn't run" <|
            \_ ->
                let
                    ( timer, _ ) =
                        Timer.initRest
                in
                Expect.equal timer (Stopped 300)
        , test "A stopped clock can be started" <|
            \_ ->
                let
                    actual =
                        Timer.start (Stopped 1)

                    expected =
                        Ok (Started 1)
                in
                Expect.equal actual expected
        , test "A done timer can't be stopped" <|
            \_ ->
                case Timer.stop Done of
                    Err _ ->
                        Expect.pass

                    _ ->
                        Expect.fail "Unexpected stop"
        , test "A paused clock can't be paused" <|
            \_ ->
                case Timer.stop (Stopped 1) of
                    Err _ ->
                        Expect.pass

                    _ ->
                        Expect.fail "Unexpected stop"
        , test "A started clock can't be started" <|
            \_ ->
                case Timer.start (Started 1) of
                    Err _ ->
                        Expect.pass

                    _ ->
                        Expect.fail "Unexpected start"
        ]
