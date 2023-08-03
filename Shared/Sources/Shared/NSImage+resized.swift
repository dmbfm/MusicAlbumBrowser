//
//  File.swift
//  
//
//  Created by Daniel Fortes on 03/08/23.
//

import Foundation
import AppKit
public struct SharedStruct{}
public extension NSImage {
    func resized(to newSize: NSSize) -> NSImage {
        let newImage = NSImage(size: newSize, flipped: false) { rect in
            self.draw(in: rect)
            return true
        }
        
        return newImage
    }
}
