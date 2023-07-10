//
//  SearchResponse.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 6/6/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import Foundation

struct searchResponse: Decodable {
    let resultCount: Int
    let results: [Artist]
}
