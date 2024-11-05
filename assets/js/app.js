import hljs from "highlight.js"

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

const hooks = {}
hooks.Highlight = {
  mounted() {
    const name = this.el.getAttribute("data-name")
    const codeblock = this.el.querySelector("pre code")    
    if (name && codeblock) {
      codeblock.className = codeblock.className.replace(/language-\S+/g, "")
      codeblock.classList.add(`language-${this.getLang(name)}`)
      const trimmed = this.trimCode(codeblock)
      hljs.highlightElement(trimmed)
      updateLineNumbers(trimmed.textContent)
    }
  },
  
  getLang(name) {
    const ext = name.split(".").pop()
    switch(ext) {
      case "txt": 
        return "text"
      case "json": 
        return "json"
      case "html": 
      case "heex": 
        return "html"
      case "js": 
      case "jsx": 
      case "ts": 
      case "tsx": 
        return "javascript"
      default:
        return "elixir"
    }
  },

  trimCode(codeblock) {
    const lines = codeblock.textContent.split("\n")
    if (lines.length <= 2) return

    lines.shift()
    lines.pop()
    codeblock.textContent = lines.join("\n")

    return codeblock
  },
}

hooks.UpdateLineNumber = {
  mounted() {
    this.el.addEventListener("keydown", this.handleTabulation)
    this.el.addEventListener("scroll", this.syncLineNumbers)
    this.el.addEventListener("input", () => updateLineNumbers(this.el.value))
    this.handleEvent("spell-created", this.clearLines)

    updateLineNumbers(this.el.value)
  },

  handleTabulation(e) {
    if (e.key !== "Tab") return;

    e.preventDefault();
    const start = this.selectionStart
    const end = this.selectionEnd
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

}

hooks.CopyToClipboard = {
  mounted() {
    this.el.addEventListener("click", e => {
      const text = this.el.getAttribute("data-clipboard-spell")
      if (!text) return

      navigator
        .clipboard
        .writeText(text)
        .then(() => console.log("copied"))
        .catch(err => console.log(`Error ${err}`))
    })
  }
}

function updateLineNumbers(value) {
  const lineNumberText = document.querySelector("#line-numbers")
  if (!lineNumberText) return

  const numbers = value.split("\n")
    .map((_, i) => i + 1)
    .join("\n") + "\n"

  lineNumberText.value = numbers
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

