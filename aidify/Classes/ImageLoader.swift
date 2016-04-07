//
//  ImageLoader.swift
//  aidify
//
//  Created by salazar on 6/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    var cache = NSCache()
    
    static let sharedInstance = ImageLoader()
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {()in
            if let data = self.cache.objectForKey(urlString) as? NSData {
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                guard error == nil, let data = data else {
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                let image = UIImage(data: data)
                self.cache.setObject(data, forKey: urlString)
                dispatch_async(dispatch_get_main_queue(), {() in
                    completionHandler(image: image, url: urlString)
                })
            })
            downloadTask.resume()
        })
        
    }
}

extension UIImageView {
    func loadImageFromURL(urlString: String) {
        ImageLoader.sharedInstance.imageForUrl(urlString) { (image, url) -> () in
            guard url == urlString, let image = image else {
                return
            }
            
            self.image = image
        }
    }
}

