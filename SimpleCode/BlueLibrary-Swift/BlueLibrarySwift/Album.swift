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

class Album: NSObject, NSCoding {
  var title : String!
  var artist : String!
  var genre : String!
  var coverUrl : String!
  var year : String!

  init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
    super.init()

    self.title = title
    self.artist = artist
    self.genre = genre
    self.coverUrl = coverUrl
    self.year = year
  }

  required init(coder decoder: NSCoder) {
    super.init()
    self.title = decoder.decodeObjectForKey("title") as String?
    self.artist = decoder.decodeObjectForKey("artist") as String?
    self.genre = decoder.decodeObjectForKey("genre") as String?
    self.coverUrl = decoder.decodeObjectForKey("cover_url") as String?
    self.year = decoder.decodeObjectForKey("year") as String?
  }

  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(title, forKey: "title")
    aCoder.encodeObject(artist, forKey: "artist")
    aCoder.encodeObject(genre, forKey: "genre")
    aCoder.encodeObject(coverUrl, forKey: "cover_url")
    aCoder.encodeObject(year, forKey: "year")
  }

  func description() -> String {
    return "title: \(title)" +
      "artist: \(artist)" +
      "genre: \(genre)" +
      "coverUrl: \(coverUrl)" +
      "year: \(year)"
  }

}
