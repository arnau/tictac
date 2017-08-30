module Help exposing (..)


type alias Stroke =
    String


type alias Description =
    String


type alias Help =
    List ( Stroke, Description )


init : Help
init =
    [ ( "i", "Enters Insert mode" )
    , ( "<esc>", "Exits Insert mode. Back to Normal mode" )
    , ( "h", "Normal mode: Shows this help" )
    , ( "s", "Normal mode: Start timer" )
    , ( "p", "Normal mode: Pause timer" )
    , ( "x", "Normal mode: Reset timer" )
    ]
