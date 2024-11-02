// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

const hooks = {}
hooks.UpdateLineNumber = {
  mounted() {
    this.el.addEventListener("keydown", this.handleTabulation)
    this.el.addEventListener("scroll", this.syncLineNumbers)
    this.el.addEventListener("input", this.updateLineNumbers)
    this.handleEvent("spell-created", this.clearLines)

    this.updateLineNumbers()
  },

  handleTabulation(e) {
    if (e.key !== "Tab") return;

    e.preventDefault();
    let start = this.selectionStart
    let end = this.selectionEnd
    this.value = this.value.substring(0, start) + "\t" + this.value.substring(end)
    this.selectionStart = this.selectionEnd = start + 1
  },

  clearLines() {
    document.querySelector("#line-numbers").value = "1\n"
    document.querySelector("#spell-textarea").value = ""
  },

  syncLineNumbers() {
    const lineNumberText = document.querySelector("#line-numbers")
    lineNumberText.scrollTop = this.scrollTop
  },

  updateLineNumbers() {
    const lineNumberText = document.querySelector("#line-numbers")
    if (!lineNumberText) return

    const lines = this.value ? this.value.split("\n") : [""]
    const numbers = lines
      .map((_, i) => i + 1)
      .join("\n") + "\n"

    lineNumberText.value = numbers
  },
}

let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

