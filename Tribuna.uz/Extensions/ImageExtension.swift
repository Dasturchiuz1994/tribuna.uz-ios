//
//  ImageExtension.swift
//  parking-dude-ios
//
//  Created by Bahrom Abdullaev on 11/21/16.
//  Copyright © 2016 TechCells. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

extension UIImage{
    
    class func getImageWithColor(_ color: UIColor, withSize size: CGSize) -> UIImage! {
        
        var img: UIImage!
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    //GIF IMAGE DISPLAY CODE
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData as Data)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
    
//    func scaleToSize(size: CGSize) -> UIImage{
//        // Create a bitmap graphics context
//        // This will also set it as the current context
//        UIGraphicsBeginImageContext(size)
//        
//        // Draw the scaled image in the current context
//        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
//        
//        // Create a new image from current context
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        // Pop the current context from the stack
//        UIGraphicsEndImageContext()
//        
//        // Return our new scaled image
//        return scaledImage!
//    }
//    
//    func  fixOrientation() -> UIImage {
//        
//        // No-op if the orientation is already correct
//        if (self.imageOrientation == .Up) {return self}
//        
//        // We need to calculate the proper transformation to make the image upright.
//        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//        var transform = CGAffineTransformIdentity
//        
//        switch (self.imageOrientation) {
//        case .Down,
//             .DownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
//            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
//            
//        case .Left,
//             .LeftMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
//            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
//            
//            
//        case .Right,
//             .RightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
//            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
//        default:
//            print("TEST")
//        }
//        
//        switch (self.imageOrientation) {
//        case .UpMirrored,
//             .DownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0)
//            transform = CGAffineTransformScale(transform, -1, 1)
//            
//        case .LeftMirrored,
//             .RightMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//        default:
//            print("TEST")
//        }
//        
//        // Now we draw the underlying CGImage into a new context, applying the transform
//        // calculated above.
//        let ctx = CGBitmapContextCreate(nil, Int(self.size.width), Int(self.size.height), CGImageGetBitsPerComponent(self.CGImage!),0,CGImageGetColorSpace(self.CGImage!)!,CGImageGetBitmapInfo(self.CGImage!).rawValue)!
//        CGContextConcatCTM(ctx, transform);
//        
//        switch (self.imageOrientation) {
//        case .Left,
//             .LeftMirrored,
//             .Right,
//             .RightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage!)
//            
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage!)
//        }
//        
//        // And now we just create a new UIImage from the drawing context
//        let cgimg = CGBitmapContextCreateImage(ctx)
//        let img = UIImage(CGImage:cgimg!)
//        //CGContextRelease(ctx)
//        //CGImageRelease(cgimg)
//        return img;
//    }
//    
//    func fillImageWithColor(color1: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        
//        let context = UIGraphicsGetCurrentContext()! //as CGContextRef
//        CGContextTranslateCTM(context, 0, self.size.height)
//        CGContextScaleCTM(context, 1.0, -1.0);
//        CGContextSetBlendMode(context, CGBlendMode.Normal)
//        
//        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
//        CGContextClipToMask(context, rect, self.CGImage!)
//        color1.setFill()
//        CGContextFillRect(context, rect)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
//        UIGraphicsEndImageContext()
//        
//        return newImage
//    }
}
