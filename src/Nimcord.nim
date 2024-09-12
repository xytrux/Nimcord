import std/[os,strutils]
import webview

const Js = staticRead(currentSourcePath.parentDir.parentDir / "Vencord" / "vencord.js")
const Css = staticRead(currentSourcePath.parentDir.parentDir / "Vencord" / "vencord.css")
const CssInjectFunction = """
  (function(e){window.onload = function(){
  var t=document.createElement('style'),d=document.head||document.getElementsByTagName('head')[0];
  t.setAttribute('type','text/css');
  t.styleSheet?t.styleSheet.cssText=e:t.appendChild(document.createTextNode(e)),d.appendChild(t);
  }})
  """

func jsEncode(s: string): string =
  result = newStringOfCap(s.len * 4) # Allocate reasonable buffer size
  var n = s.len * 4
  var r = 1 # At least one byte for trailing zero
  for c in s:
    let byte = c.uint8
    if byte >= 0x20 and byte < 0x80 and c notin {'<', '>', '\\', '\'', '"'}:
      if n > 0:
        result.add c
        dec(n)
      r += 1
    else:
      if n > 0:
        result.add "\\x" & byte.toHex(2)
        n -= 4 # We add 4 bytes, so we want to subtract 4 from remaining space
      r += 4

# Create the webview with debug enabled
let w = newWebView(debug=true)

w.title = "Nimcord"
w.size = (1280, 720)

w.init(cstring(CssInjectFunction & "(\"" & Css.jsEncode & "\")" & Js))

# Navigate to Discord
w.navigate("https://discord.com/app")

w.run()