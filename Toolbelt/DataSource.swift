//
//  DataSource.swift
//  HuntFish
//
//  Created by Chris Chares on 2/3/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

protocol Bindable {
    associatedtype Data
    func bind(data: Data)
}

protocol Validatable {
    func validate() -> Bool
}

protocol Savable : Validatable {
    associatedtype Data
    func save() -> Data
}

class DataSource<T, E: Bindable where E.Data == T>: NSObject, UITableViewDataSource {

    var content: [T] = []
    
    func loadData(fn: (Result<[T]>) -> Void ) -> Void {
        //default implementation just returns content
        fn(Result({self.content}))
    }
    
    func dataForIndexPath(indexPath: NSIndexPath) -> T {
        return content[indexPath.row]
    }
    
    func cellIDForData(data: T) -> String {
        return "Cell"
    }
    
    /*:
        UITableViewDataSource
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = dataForIndexPath(indexPath)
        let cellID = cellIDForData(data)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! E
        
        cell.bind(data)
        return cell as! UITableViewCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
}

class SearchableDataSource<T, E: Bindable where E.Data == T> : DataSource<T, E> {
    
    var filteredContent: [T] = []
    
    override var content: [T] {
        didSet {
            filteredContent = content
        }
    }
    
    func filter(query: String?) {
        filteredContent = content
    }
    
    override func dataForIndexPath(indexPath: NSIndexPath) -> T {
        return filteredContent[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContent.count
    }
}

