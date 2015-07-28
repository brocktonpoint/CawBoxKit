//
//  CoreData.swift
//  CawBoxKit
//
//  Created by Aethus Northcott on 2015-07-27.
//  Copyright (c) 2015 CawBox. All rights reserved.
//

import Foundation
import CoreData

protocol Fetchable {
    static var entity: String { get }
    
    func fetch (
        context: NSManagedObjectContext,
        predicate: NSPredicate?,
        sort: NSSortDescriptor?,
        limit: Int?) throws -> [Fetchable]
}

extension Fetchable {
    func fetch (
        context: NSManagedObjectContext,
        predicate: NSPredicate? = nil,
        sort: NSSortDescriptor? = nil,
        limit: Int? = nil) throws -> [Fetchable] {
        
        return []
    }
}
