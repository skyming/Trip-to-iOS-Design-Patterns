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

class LibraryAPI: NSObject {
  private let persistencyManager: PersistencyManager
  private let httpClient: HTTPClient
  private let isOnline: Bool

  //1
  class var sharedInstance: LibraryAPI {
    //2
    struct Singleton {
      //3
      static let instance = LibraryAPI()
    }
    //4
    return Singleton.instance
  }

  override init() {
    persistencyManager = PersistencyManager()
    httpClient = HTTPClient()
    isOnline = false

    super.init()

    NSNotificationCenter.defaultCenter().addObserver(self, selector:"downloadImage:", name: "BLDownloadImageNotification", object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  func downloadImage(notification: NSNotification) {
    //1
    let userInfo = notification.userInfo as [String: AnyObject]
    var imageView = userInfo["imageView"] as UIImageView?
    let coverUrl = userInfo["coverUrl"] as NSString

    //2
    if let imageViewUnWrapped = imageView {
      imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent)
      if imageViewUnWrapped.image == nil {
        //3
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
          let downloadedImage = self.httpClient.downloadImage(coverUrl)
          //4
          dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            imageViewUnWrapped.image = downloadedImage
            self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
          })
        })
      }
    }
  }

  func getAlbums() -> [Album] {
    return persistencyManager.getAlbums()
  }

  func addAlbum(album: Album, index: Int) {
    persistencyManager.addAlbum(album, index: index)
    if isOnline {
      httpClient.postRequest("/api/addAlbum", body: album.description())
    }
  }

  func deleteAlbum(index: Int) {
    persistencyManager.deleteAlbumAtIndex(index)
    if isOnline {
      httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
    }
  }

  func saveAlbums() {
    persistencyManager.saveAlbums()
  }

}
