# NotificationKit
A simple type-safe NSNotificationCenter library

## Usage
Create class extend NotificationType and defined typealias, and initialize core object.
```swift
class SampleNotification: NotificationType {
    typealias ObjectType = NSObject
    typealias ValueType = String
    let core = NotificationCore<NSObject, String>("SampleNotification")
}
```

You will use in the same way NSNotificationCenter
```swift
let notification = SampleNotification()
let observer = notification.addObserver(nil, queue: NSOperationQueue.mainQueue()) { object, value in
  ...
}
notification.postNotification(nil, value: "Write message here")
notification.removeObserver(observer)
```

Of course, ValueType accept out of NSObject subclass types.
```swift
class TupleNotification: NotificationType {
    typealias ObjectType = NSObject
    typealias ValueType = (String, Int)
    let core = NotificationCore<NSObject, (String, Int)>("TupleNotification")
}

class EnumNotification: NotificationType {
    typealias ObjectType = NSObject
    typealias ValueType = Optional<String>
    let core = NotificationCore<NSObject, Optional<String>>("EnumNotification")
}
```

## Memory management
You must memory management when using NSNotificationCenter, and you must call removeObserver method by every observer object.

In NotificationKit, you manage only one NotificationType object.

When NotificationType object deinit, remove all generated observer object.
