//
//  UIViewController+Loading.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 12/11/2020.
//

import UIKit

extension UIWindow {
    private static var _thisActivityIndicator = StoredProperty<UIActivityIndicatorView>()
    
    var thisActivityIndicator: UIActivityIndicatorView {
        get {
            if let indicator = UIWindow._thisActivityIndicator.get(self) {
                return indicator
            } else {
                UIWindow._thisActivityIndicator.set(self, value: UIActivityIndicatorView.customIndicator(at: self.center))
                return UIWindow._thisActivityIndicator.get(self)!
            }
        }
        set {
            UIWindow._thisActivityIndicator.set(self, value: newValue)
        }
    }
    
    // MARK: - Activity Indicator
    public func startIndicatingActivity(_ ignoringEvents: Bool? = true) {
        DispatchQueue.main.async {
            self.addSubview(self.thisActivityIndicator)
            self.thisActivityIndicator.startAnimating()
            if ignoringEvents! {
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    public func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.thisActivityIndicator.removeFromSuperview()
            self.thisActivityIndicator.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
}

extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        indicator.layer.cornerRadius = 0
        indicator.color = UIColor.black
        indicator.center = center
        indicator.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.5)
        indicator.hidesWhenStopped = true
        return indicator
    }
}

