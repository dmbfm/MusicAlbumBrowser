//
//  NSImage+pngData.swift
//  musicshit
//
//  Created by Daniel Fortes on 01/08/23.
//

import Foundation
import AppKit

extension NSImage {
    func pngData() -> Data? {
        guard let tiffData = self.tiffRepresentation else {
            return nil
        }
        
        guard let bmp = NSBitmapImageRep(data: tiffData) else {
            return nil
        }
        
        return bmp.representation(using: .png, properties: [:])
    }
}
