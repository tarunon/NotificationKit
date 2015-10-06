# NotificationKit
A simple type-safe NSNotificationCenter library

## Installation

### CocoaPods
```ruby
platform :ios, "8.0"
use_frameworks!

pod 'NotificationKit', :git => 'https://github.com/tarunon/NotificationKit.git', :branch => 'master'
```

### Carthage
```ogdl
github "tarunon/NotificationKit"
```


## Usage
Create class extend NotificationType and defined typealias, and initialize core object.
```swift
class SampleNotification: Notification<NSObject, String> {
    override var name: String {
        return "SampleNotification"
    }
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
class TupleNotification: Notification<NSObject, (String, Int)> {
    override var name: String {
        get {
            return "SampleNotification"
        }
    }
}

class EnumNotification: Notification<NSObject, Optional<String>> {
    override var name: String {
        return "SampleNotification"
    }
}
```

If you don't need Object filter, you use SimpleNotification class instead of Notification class.

```swift
class Notification: SimpleNotification<Int> {
    override var name: String {
        return "Notification"
    }
}
```

## Memory management
You must memory management when using NSNotificationCenter, and you must call removeObserver method by every observer object.

In NotificationKit, you manage only one NotificationType object.

When NotificationType object deinit, remove all generated observer object.
