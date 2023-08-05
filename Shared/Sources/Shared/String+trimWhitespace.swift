//
//  String+trimWhitespaces.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 04/08/23.
//

import Foundation

public extension String {
    func trimWhitespacePrefix() ->  String {

        var index = self.startIndex
        
        while true {
            
            if index >= self.endIndex {
                break
            }
            
            let current = self[index]
            
            if current != " " {
                break
            }
            
            index = self.index(index, offsetBy: 1)
            
            if index >= self.endIndex {
                break
            }
            
        }
        
        return String(self[index..<self.endIndex])
    }
    
    func trimWhitespaceSuffix() -> String {
        return String(String(self.reversed()).trimWhitespacePrefix().reversed())
    }
    
    func trimWhitespaces() -> String {
        return self.trimWhitespacePrefix().trimWhitespaceSuffix()
    }
}
