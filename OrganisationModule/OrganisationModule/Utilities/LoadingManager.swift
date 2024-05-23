//
//  LoadingManager.swift
//  OrganisationModule
//
//  Created by Arif ww on 20/05/2024.
//

import Foundation
import UIKit


class LoaderManager {

    // Shared instance for singleton pattern
    static let shared = LoaderManager()

    // Private initializer to prevent multiple instances
    private init() {}

    private var activityIndicator: UIActivityIndicatorView?

    // Function to show the loader
    func showLoader(on view: UIView) {
        if activityIndicator == nil {
            // Initialize the activity indicator
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.color = .gray
            activityIndicator?.center = view.center

            // Optional: Customize the appearance further if needed
        }

        // Ensure activityIndicator is not nil
        guard let activityIndicator = activityIndicator else { return }

        // Add the activity indicator to the view if not already added
        if activityIndicator.superview == nil {
            view.addSubview(activityIndicator)
        }

        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    // Function to hide the loader
    func hideLoader() {
        activityIndicator?.stopAnimating()
        activityIndicator?.isHidden = true
        activityIndicator?.removeFromSuperview()
    }
}
