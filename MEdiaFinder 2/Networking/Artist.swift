//
//  Artist.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 6/6/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import Foundation

struct Artist:Decodable {
    let artworkUrl100: String?
    let artistName: String?
    let trackName: String?
    let previewUrl: String?
    let longDescription: String?
}
