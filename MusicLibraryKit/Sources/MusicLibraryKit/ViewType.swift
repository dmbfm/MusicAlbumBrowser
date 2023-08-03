//
//  File.swift
//  
//
//  Created by Daniel Fortes on 02/08/23.
//

import Foundation

public enum ViewType {
    case all
    case filtered(genres: [UUID], playlists: [UUID])
}
