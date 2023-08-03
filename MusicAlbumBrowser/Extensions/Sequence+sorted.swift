//
//  Sequence+sorted.swift
//  MusicAlbumBrowser
//
//  Created by Daniel Fortes on 03/08/23.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, comparator: (T, T) -> Bool = (<)) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
