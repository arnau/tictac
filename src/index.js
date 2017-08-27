"use strict";

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main")

Elm.Main.embed(document.getElementById("main"))
