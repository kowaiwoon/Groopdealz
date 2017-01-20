//
//  ImageViewWithLoader.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 11.12.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit


class ImageViewWithLoader : UIImageView {
    
    var loaderView: UIActivityIndicatorView!
    
    override var image: UIImage? {
        didSet {
            if image != nil && loaderView != nil {
                loaderView.stopAnimating()
            }
        }
    }
    
    func loadImage(_ url: URL) {
        if loaderView == nil {
            loaderView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            loaderView.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
            loaderView.hidesWhenStopped = true
            loaderView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]
            self.addSubview(loaderView)
        }
        
        loaderView.startAnimating()
        AsyncImagePreloader.sharedInstance.loadImageFromUrlToView(url, view: self)
    }
    
}
