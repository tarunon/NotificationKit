//
//  NotificationKit.swift
//  NotificationKit
//
//  Created by Nobuo Saito on 2015/08/04.
//  Copyright © 2015年 tarunon. All rights reserved.
//

import Foundation

private class Box<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

private let keyName = "NotificationUserInfoKey"

public final class NotificationCore<O: AnyObject, V> {
    
    let name: String
    private var observers = Set<Observer>()
    public init(_ name: String) {
        self.name = name
    }
    
    private func postNotification(object: O?, value: V) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: object, userInfo: [keyName: Box(value)])
    }
    
    private func addObserver(object: O?, queue: NSOperationQueue?, handler: (O?, V) -> ()) -> Observer {
        let observer = Observer(NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: queue) { notification in
            handler(notification.object as? O, (notification.userInfo?[keyName] as! Box<V>).value)
        })
        observers.insert(observer)
        return observer
    }
    
    private func removeObserver(observer: Observer) {
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

protocol NotificationType {
    
    typealias ObjectType: AnyObject
    typealias ValueType
    var core: NotificationCore<ObjectType, ValueType> { get }
}

extension NotificationType {
    
    func postNotification(object: ObjectType?, value: ValueType) {
        core.postNotification(object, value: value)
    }
    
    func addObserver(object: ObjectType?, queue: NSOperationQueue?, handler: (ObjectType?, ValueType) -> ()) -> Observer {
        return core.addObserver(object, queue: queue, handler: handler)
    }
    
    func removeObserver(observer: Observer) {
        core.removeObserver(observer)
    }
}
