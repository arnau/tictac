port module Stylesheets exposing (..)

import Css.File exposing (..)
import Style


port files : CssFileStructure -> Cmd msg


structure : CssFileStructure
structure =
    toFileStructure [ ( "stylesheet.css", compile [ Style.init ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files structure
