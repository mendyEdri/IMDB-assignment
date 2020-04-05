//
//  URL+QueryItem.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 02/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

/** Easy access to URL with components. taks items veridic as a parameter. */
extension URL {
    public func withItems(_ items: URLQueryItem...) -> URL? {
        var component = URLComponents(string: self.absoluteString)
        component?.queryItems = items
        return component?.url
    }
}
