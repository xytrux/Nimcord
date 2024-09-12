import webview

# Create the webview with debug enabled
let w = newWebView(debug=true)

w.title = "Nimcord"
w.size = (800, 600)

w.init(cstring(readFile("Vencord/vencord.js")))

# Navigate to Discord
w.navigate("https://discord.com/app")

w.run()