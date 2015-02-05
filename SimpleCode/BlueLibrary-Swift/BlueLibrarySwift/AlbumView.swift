/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class AlbumView: UIView {

  private let coverImage: UIImageView!
  private let indicator: UIActivityIndicatorView!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init(frame: CGRect, albumCover: String) {
    super.init(frame: frame)
    backgroundColor = UIColor.blackColor()
    coverImage = UIImageView(frame: CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10))
    addSubview(coverImage)
    coverImage.addObserver(self, forKeyPath: "image", options: nil, context: nil)
    
    indicator = UIActivityIndicatorView()
    indicator.center = center
    indicator.activityIndicatorViewStyle = .WhiteLarge
    indicator.startAnimating()
    addSubview(indicator)

    NSNotificationCenter.defaultCenter().postNotificationName("BLDownloadImageNotification", object: self, userInfo: ["imageView":coverImage, "coverUrl" : albumCover])
  }

  deinit {
    coverImage.removeObserver(self, forKeyPath: "image")
  }

  override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
    if keyPath == "image" {
      indicator.stopAnimating()
    }
  }

  func highlightAlbum(#didHighlightView: Bool) {
    if didHighlightView == true {
      backgroundColor = UIColor.whiteColor()
    } else {
      backgroundColor = UIColor.blackColor()
    }
  }

}
