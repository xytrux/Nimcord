import webview

# Create the webview with debug enabled
let w = newWebView(debug=true)

w.title = "Nimcord"
w.size = (1280, 720)

w.init(cstring(readFile("Vencord/vencord.js")))

# Navigate to Discord
w.navigate("https://discord.com/app")

w.run()