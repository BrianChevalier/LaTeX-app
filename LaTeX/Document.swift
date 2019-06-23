//
//  Document.swift
//  LaTeX
//
//  Created by Brian Chevalier on 6/11/19.
//  Copyright © 2019 Brian Chevalier. All rights reserved.
//

import UIKit

enum DocumentError: Error {
    case saveError
    case loadError
}

class Document: UIDocument {
    
    var text: String?
    
    var encodingUsed: String.Encoding?
    
    override func contents(forType typeName: String) throws -> Any {
        
        guard let data = text?.data(using: .utf8) else {
            throw DocumentError.saveError
        }
        
        return data
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        
        guard let data = contents as? Data else {
            throw DocumentError.loadError
        }
        
        guard let utf8 = String(data: data, encoding: .utf8) else {
            throw DocumentError.loadError
        }
        
        self.text = utf8
        
    }
}


