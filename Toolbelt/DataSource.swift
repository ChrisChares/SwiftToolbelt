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
    func bind(_ data: Data)
}

public enum ValidationError : Error {
    case invalidData(message: String)
}

public protocol Validatable {
    func validate() throws
}

public protocol Savable : Validatable {
    associatedtype Data
    func save() -> Data
}

open class DataSource<T, E: Bindable>: NSObject, UITableViewDataSource, UICollectionViewDataSource where E.Data == T {
    
    public override init() {
        super.init()
    }
    
    open var content: [T] = []
    
    open func loadData(_ fn: (Result<[T]>) -> Void ) -> Void {
        //default implementation just returns content
        fn(Result({self.content}))
    }
    
    open func dataForIndexPath(_ indexPath: IndexPath) -> T {
        return content[(indexPath as NSIndexPath).row]
    }
    
    open func cellIDForData(_ data: T) -> String {
        return "Cell"
    }
    
    /*:
        UITableViewDataSource
    */
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataForIndexPath(indexPath)
        let cellID = cellIDForData(data)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! E
        
        cell.bind(data)
        return cell as! UITableViewCell
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    /*
        UICollectionViewDataSource
    */
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = dataForIndexPath(indexPath)
        let cellID = cellIDForData(data)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! E
        cell.bind(data)
        return cell as! UICollectionViewCell
    }
}





open class SearchableDataSource<T, E: Bindable> : DataSource<T, E> where E.Data == T {
    
    open var filteredContent: [T] = []
    
    open override var content: [T] {
        didSet {
            filteredContent = content
        }
    }
    
    open func filter(_ query: String?) {
        filteredContent = content
    }
    
    open override func dataForIndexPath(_ indexPath: IndexPath) -> T {
        return filteredContent[(indexPath as NSIndexPath).row]
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContent.count
    }
}

