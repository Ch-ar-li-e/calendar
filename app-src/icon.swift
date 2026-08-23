import AppKit

// 生成 512x512 应用图标：圆角底 + 📅 emoji
let size = NSSize(width: 512, height: 512)
let image = NSImage(size: size)
image.lockFocus()

// 背景：圆角矩形，主题蓝渐变
let rect = NSRect(x: 12, y: 12, width: 488, height: 488)
let path = NSBezierPath(roundedRect: rect, xRadius: 100, yRadius: 100)
let gradient = NSGradient(colors: [
    NSColor(srgbRed: 0.31, green: 0.49, blue: 1.0, alpha: 1.0),
    NSColor(srgbRed: 0.20, green: 0.35, blue: 0.90, alpha: 1.0)
])!
gradient.draw(in: path, angle: -90)

// 白色小圆点缀右上角
let dot = NSBezierPath(ovalIn: NSRect(x: 388, y: 388, width: 44, height: 44))
NSColor.white.setFill()
dot.fill()

// 中央日历 emoji
let para = NSMutableParagraphStyle()
para.alignment = .center
let str = NSAttributedString(string: "📅", attributes: [
    .font: NSFont.systemFont(ofSize: 270),
    .paragraphStyle: para
])
str.draw(in: NSRect(x: 0, y: 76, width: 512, height: 360))

image.unlockFocus()

let tiff = image.tiffRepresentation!
let rep = NSBitmapImageRep(data: tiff)!
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("icon written")
