//
//  NotificationKitTests.swift
//  NotificationKitTests
//
//  Created by Nobuo Saito on 2015/08/04.
//  Copyright © 2015年 tarunon. All rights reserved.
//

import XCTest
@testable import NotificationKit

class SampleNotification: Notification<NSObject, String> {
    override var name: String {
        return "SampleNotification"
    }
}

class SampleNotification2: SimpleNotification<Int> {
    override var name: String {
        return "SampleNotification2"
    }
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
    
    func testPostNotification2() {
        let sampleNotification = SampleNotification2()
        let notificationValue = 1984
        
        sampleNotification.addObserver(nil) { value in
            XCTAssertEqual(value, notificationValue)
        }
        
        sampleNotification.postNotification(notificationValue)
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
    
    func testRemoveNotification2() {
        var sampleNotification: SampleNotification2!
        
        autoreleasepool {
            sampleNotification = SampleNotification2()
            
            let observer = sampleNotification.addObserver(nil, handler: { value in
                XCTFail()
            })
            
            sampleNotification.removeObserver(observer)
        }
        
        sampleNotification.postNotification(1984)
    }
}
