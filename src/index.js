"use strict";

require("./index.html")
require("./Stylesheets.elm")

const Elm = require("./Main")

const topicKey = "tictac-topic"

const topic = localStorage.getItem(topicKey)
const app = Elm.Main.embed(document.getElementById("main"), {topic: topic})
// const app = Elm.Main.fullscreen()


function requestPermission(message) {
  Notification.requestPermission().then(app.ports.receivePermission.send)
}

app.ports.requestPermission.subscribe(requestPermission)

app.ports.notify.subscribe((message) =>
  new Notification(message, {requireInteraction: true, body: "TicTac says so"}))

app.ports.storeTopic.subscribe((topic) => localStorage.setItem(topicKey, topic))
