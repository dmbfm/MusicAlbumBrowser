//
//  NSImage+Resize.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit

extension NSImage {
    func resized(to newSize: NSSize) -> NSImage {
        let newImage = NSImage(size: newSize, flipped: false) { rect in
            self.draw(in: rect)
            return true
        }
        
        return newImage
    }
}
