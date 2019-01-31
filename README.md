# AGImagesDownloader

[![Build Status](https://travis-ci.com/ToGohi/AGImagesDownloader.svg?branch=master)](https://travis-ci.com/ToGohi/AGImagesDownloader)
[![Version](https://img.shields.io/cocoapods/v/AGImagesDownloader.svg?style=flat)](https://cocoapods.org/pods/AGImagesDownloader)
[![License](https://img.shields.io/cocoapods/l/AGImagesDownloader.svg?style=flat)](https://cocoapods.org/pods/AGImagesDownloader)
[![Platform](https://img.shields.io/cocoapods/p/AGImagesDownloader.svg?style=flat)](https://cocoapods.org/pods/AGImagesDownloader)

## Requirements

## Installation

AGImagesDownloader is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AGImagesDownloader'
```

## Description

This pod is an extension of the UIImageView class. The main functionality is to have the possibility of download images from URL easier. AGImagesDownloader has an internal cache to store all the downloaded images. At the first time to download an image the UIImageView shows an activity monitor since the start to the finish of http download.

```ruby

    /// Download an image from URL or load from internal cache
    ///
    /// - Parameter url: URL of the image to download.
    public func loadImageFromCache(url:URL)

    /// Download an image from URL or load from internal cache
    ///
    /// - Parameters:
    ///   - filename: The filename of the image to store in internal cache.
    ///   - url: URL of the image to download.
    public func loadImageFromCache(filename:String, url:URL)

```
## Usage

An example of use:

```ruby

    import AGImagesDownloader

    @IBOutlet weak var imageView: UIImageView!

    func ... {
        imageView.loadImageFromCache(url: imageURL)
    }

```

## Screenshots

The UIImageView will show an activity monitor at the center.

![Downloading an image](https://github.com/ToGohi/AGImagesDownloader/raw/master/screen01.png)

## Author

Antonio González, togohi@gmail.com

## License

AGImagesDownloader is available under the MIT license. See the LICENSE file for more info.
