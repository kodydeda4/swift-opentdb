import UIKit
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

extension Color {
  public func adjustBrightness(by amount: Double) -> Color {
    Color(uiColor: UIColor(self).adjustBrightness(by: CGFloat(amount)))
  }
  
  public init(emoji: String) {
    if let color = Self.make(from: emoji) {
      self = color
    } else {
      self = Color(.systemGray)
    }
  }
}

// MARK: - Private

private extension UIColor {
  func adjustBrightness(by amount: CGFloat) -> UIColor {
    var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
    guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return self }
    
    return UIColor(hue: hue, saturation: saturation, brightness: min(brightness + amount, 1.0), alpha: alpha)
  }
}

private extension Color {
  /// Create a `Color` from the dominant color of an Emoji.
  static func make(from emoji: String) -> Color? {
    let nsString = (emoji as NSString)
    let font = UIFont.systemFont(ofSize: 1024)
    let stringAttributes = [NSAttributedString.Key.font: font]
    let imageSize = nsString.size(withAttributes: stringAttributes)
    
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    UIColor.clear.set()
    UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
    nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let image, let ciImage = CIImage(image: image) else { return nil }
    
    let filter = CIFilter.areaAverage()
    filter.inputImage = ciImage
    filter.extent = ciImage.extent
    
    let context = CIContext()
    var bitmap = [UInt8](repeating: 0, count: 4)
    
    context.render(
      filter.outputImage!,
      toBitmap: &bitmap,
      rowBytes: 4,
      bounds: CGRect(
        x: 0,
        y: 0,
        width: 1,
        height: 1
      ),
      format: .RGBA8,
      colorSpace: CGColorSpaceCreateDeviceRGB()
    )
    
    return Color(
      red: Double(bitmap[0]) / 255,
      green: Double(bitmap[1]) / 255,
      blue: Double(bitmap[2]) / 255
    )
  }
}
