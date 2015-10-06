//
//  NotificationKit.swift
//  NotificationKit
//
//  Created by Nobuo Saito on 2015/08/04.
//  Copyright © 2015年 tarunon. All rights reserved.
//

import Foundation

private class NotificationBox<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

private let keyName = "NotificationUserInfoKey"

public class Notification<O: AnyObject, V> {
    public var name: String {
        get {
            return ""
        }
    }
    
    private var observers = Set<Observer>()
    
    public init() {}
    
    public func postNotification(object: O?, value: V) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: [keyName: Box(value)])
    }
    
    public func addObserver(object: O?, queue: NSOperationQueue?, handler: (O?, V) -> ()) -> Observer {
        let observer = Observer(NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: queue) { notification in
            handler(notification.object as? O, (notification.userInfo?[keyName] as! Box<V>).value)
        })
        observers.insert(observer)
        return observer
    }
    
    public func removeObserver(observer: Observer) {
        observers.remove(observer)
    }
}

public final class Observer: Hashable {
    
    let value: AnyObject
    init(_ value: AnyObject) {
        self.value = value
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(value)
    }
    
    public var hashValue: Int {
        return value.hashValue ?? 0
    }
}

public func ==(lhs: Observer, rhs: Observer) -> Bool {
    return lhs.value === rhs.value
}
