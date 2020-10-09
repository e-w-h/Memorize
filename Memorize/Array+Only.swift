//
//  Array+Only.swift
//  Memorize
//
//  Created by Eric Hou on 10/9/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
