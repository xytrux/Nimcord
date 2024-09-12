import webview

# Create the webview with debug enabled
let w = newWebView(debug=true)

w.title = "Nimcord"
w.size = (800, 600)

# Read and inject the JavaScript file
let jsCode = cstring(readFile("Vencord/vencord.js"))
w.init(jsCode)

# Navigate to Discord
w.navigate("https://discord.com/app")

w.run()