"use strict";

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main")

const app = Elm.Main.embed(document.getElementById("main"))
// const app = Elm.Main.fullscreen()

app.ports.notify.subscribe(function (message) {
  new Notification(message, {requireInteraction: true, body: "TicTac says so"});
});

app.ports.requestPermission.subscribe(function (message) {
  Notification.requestPermission().then(
    function (permission) {
      console.log("received permission: " + permission)
      app.ports.receivePermission.send(permission)
    }
  );
  console.log(message);
});
