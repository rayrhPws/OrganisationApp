import UIKit
import WebKit

protocol SecondApproachTestVCCollCellDelegate: AnyObject {
    func webViewDidFinishLoading(_ cell: secondApproachTestVCCollCell, height: CGFloat)
    func didTapTitleLabel(_ cell: secondApproachTestVCCollCell)
}

class secondApproachTestVCCollCell: UICollectionViewCell, WKNavigationDelegate {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var webkitHeight: NSLayoutConstraint!
    @IBOutlet weak var viewWK: WKWebView!
    
    weak var delegate: SecondApproachTestVCCollCellDelegate?
    
    // Property to track the current expansion state
    private var isCurrentlyExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewWK.navigationDelegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelTapped))
        lbl1.isUserInteractionEnabled = true
        lbl1.addGestureRecognizer(tapGesture)
        
        // Ensure the arrow image is initially pointing down
        imgArrow.transform = CGAffineTransform.identity
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewWK.navigationDelegate = self
        viewWK.stopLoading()
        viewWK.loadHTMLString("", baseURL: nil)
        webkitHeight.constant = 0
        
        // Reset arrow rotation and expansion state
        imgArrow.layer.removeAllAnimations()
        imgArrow.transform = CGAffineTransform.identity
        isCurrentlyExpanded = false
    }
    
    @objc func titleLabelTapped() {
        delegate?.didTapTitleLabel(self)
    }
    
    func configure(with item: ExpandedModel) {
        lbl1.text = item.title
        viewWK.scrollView.isScrollEnabled = false
        viewWK.scrollView.bounces = false
        viewWK.isUserInteractionEnabled = true
        viewWK.contentMode = .scaleToFill
        let headString = Constants.shared.constHeaderStringForWebView

        // Determine the target rotation based on the new expansion state
        let targetRotationAngle: CGFloat = item.isExpanded ? .pi : 0

        // Check if the expansion state has changed
        if item.isExpanded != isCurrentlyExpanded {
            // Create a CABasicAnimation for rotation
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = isCurrentlyExpanded ? CGFloat.pi : 0
            rotationAnimation.toValue = item.isExpanded ? CGFloat.pi : 0
            rotationAnimation.duration = 0.3
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            rotationAnimation.fillMode = .forwards
            rotationAnimation.isRemovedOnCompletion = false

            // Add the animation to the arrow's layer
            imgArrow.layer.add(rotationAnimation, forKey: "rotationAnimation")

            // Update the current state
            isCurrentlyExpanded = item.isExpanded

            // Ensure the transform is set to the final state after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + rotationAnimation.duration) {
                self.imgArrow.transform = CGAffineTransform(rotationAngle: targetRotationAngle)
                self.imgArrow.layer.removeAnimation(forKey: "rotationAnimation")
            }
        } else {
            // Set the rotation without animation if the state hasn't changed
            imgArrow.transform = CGAffineTransform(rotationAngle: targetRotationAngle)
        }

        // Handle WebView content
        if item.htmlStr != "" {
            if item.isExpanded {
                viewWK.loadHTMLString(headString + item.htmlStr, baseURL: nil)
                if item.isLoaded {
                    UIView.performWithoutAnimation {
                        self.webkitHeight.constant = item.height
                        self.layoutIfNeeded()
                    }
                }
            } else {
                UIView.performWithoutAnimation {
                    self.webkitHeight.constant = 0
                    self.layoutIfNeeded()
                }
                viewWK.loadHTMLString("", baseURL: nil)
            }
        } else {
            viewWK.loadHTMLString("", baseURL: nil)
            UIView.performWithoutAnimation {
                self.webkitHeight.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState") { [weak self] (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] (height, error) in
                    if let self = self, let height = height as? CGFloat {
                        UIView.performWithoutAnimation {
                            self.webkitHeight.constant = height
                            self.layoutIfNeeded()
                        }
                        self.delegate?.webViewDidFinishLoading(self, height: height)
                    }
                }
            }
        }
    }
}

