//
//  DataSource.swift
//  HuntFish
//
//  Created by Chris Chares on 2/3/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import UIKit

public protocol Bindable {
    associatedtype Data
    func bind(data: Data)
}

public protocol Validatable {
    func validate() -> Bool
}

public protocol Savable : Validatable {
    associatedtype Data
    func save() -> Data
}

public class DataSource<T, E: Bindable where E.Data == T>: NSObject, UITableViewDataSource, UICollectionViewDataSource {
    
    public override init() {
        super.init()
    }
    
    public var content: [T] = []
    
    public func loadData(fn: (Result<[T]>) -> Void ) -> Void {
        //default implementation just returns content
        fn(Result({self.content}))
    }
    
    public func dataForIndexPath(indexPath: NSIndexPath) -> T {
        return content[indexPath.row]
    }
    
    public func cellIDForData(data: T) -> String {
        return "Cell"
    }
    
    /*:
        UITableViewDataSource
    */
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = dataForIndexPath(indexPath)
        let cellID = cellIDForData(data)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! E
        
        cell.bind(data)
        return cell as! UITableViewCell
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    /*
        UICollectionViewDataSource
    */
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let data = dataForIndexPath(indexPath)
        let cellID = cellIDForData(data)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! E
        cell.bind(data)
        return cell as! UICollectionViewCell
    }
}





public class SearchableDataSource<T, E: Bindable where E.Data == T> : DataSource<T, E> {
    
    public var filteredContent: [T] = []
    
    public override var content: [T] {
        didSet {
            filteredContent = content
        }
    }
    
    public func filter(query: String?) {
        filteredContent = content
    }
    
    public override func dataForIndexPath(indexPath: NSIndexPath) -> T {
        return filteredContent[indexPath.row]
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContent.count
    }
}

