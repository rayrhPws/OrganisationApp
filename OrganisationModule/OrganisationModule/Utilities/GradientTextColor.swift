
import UIKit
func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {

      UIGraphicsBeginImageContext(gradientLayer.bounds.size)
      gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIColor(patternImage: image!)
}
func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [Color.Dark_blue.color().cgColor, Color.Dark_blue.color().cgColor]

    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
    return gradient
}

