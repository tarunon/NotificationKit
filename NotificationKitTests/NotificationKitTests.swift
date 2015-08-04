//
//  NotificationKitTests.swift
//  NotificationKitTests
//
//  Created by Nobuo Saito on 2015/08/04.
//  Copyright © 2015年 tarunon. All rights reserved.
//

import XCTest
@testable import NotificationKit

class SampleNotification: NotificationType {
    typealias ObjectType = NSObject
    typealias ValueType = String
    let core = NotificationCore<NSObject, String>("SampleNotification")
}

class NotificationKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPostNotification() {
        let sampleNotification = SampleNotification()
        
        let notificationObject = NSObject()
        let notificationValue = "It is SampleNotification"
        
        let observer = sampleNotification.addObserver(notificationObject, queue: nil) { object, value in
            XCTAssertNotNil(object)
            XCTAssertEqual(object!, notificationObject)
            XCTAssertEqual(value, notificationValue)
        }
        
        sampleNotification.postNotification(notificationObject, value: notificationValue)
        sampleNotification.postNotification(nil, value: "It is not observed at \(observer)")
    }
    
    func testRemoveNotification() {
        var sampleNotification: SampleNotification!
        
        autoreleasepool {
            sampleNotification = SampleNotification()
            
            let observer = sampleNotification.addObserver(nil, queue: nil) { object, value in
                XCTFail()
            }
            
            sampleNotification.removeObserver(observer)
        }
        
        sampleNotification.postNotification(nil, value: "It is not observed.")
    }
}
