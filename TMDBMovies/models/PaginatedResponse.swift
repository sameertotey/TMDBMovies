//
//  PaginatedResponse.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

struct PaginatedResponse<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}
