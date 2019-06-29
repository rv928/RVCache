//
//  UserListViewControllerTests.swift
//  MVRCacheTests
//
//  Created by Admin on 1226/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import MVRCache

class UserListViewControllerTests: XCTestCase,NSCacheDelegate {

    var controller: UserListViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!
    var userListArray:Array<UserList> = Array()
    var cacheManager:CacheManager!
    var evicted:Bool!
    var currentCache:CacheManager!
    
    override func setUp() {
        guard let nav = UIStoryboard(name: "UserList", bundle: Bundle(for: UserListViewController.self)).instantiateInitialViewController() as? UINavigationController
            else {
                return XCTFail("Could not instantiate UserListViewController from UserList storyboard")
        }
        controller = nav.topViewController as? UserListViewController
        controller.loadViewIfNeeded()
        tableView = controller.userListTableView
        delegate = tableView.delegate
        
        evicted = false
        CacheManager.manage.initWithNameSpace(specifiedSpace: "testcase", shouldEvict: true, delegate: controller)
        CacheManager.manage.setMaxCountLimit(count: 2)

    }

    func testTableViewHasUserCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'UserCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }
    
    func testForWSToGetUserList() {
        XCTAssertNoThrow(UserManager.manage.fetchUsers(vc: nil, completion: { (nil) in
            
        }))
    }
    
    func testForImageCachePerformance() {
       
        let cacheImageView = UIImageView()
        let testURL:String = "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"
        
        CacheManager.manage.cacheResponseFromURL(sourceURL: testURL, shouldStoreInCache: true, cacheType:.Image) { (outputObject, error, CurrentCacheType) in
            
            switch CurrentCacheType {
            case .Image:
                DispatchQueue.main.async {
                    cacheImageView.image = outputObject as? UIImage
                }
                break
            case .JSON:
                break
            case .Zip:
                break
            }
        }
    }
    
    func testForOtherObjectCache() {
       
        let testURL:String = "http://www.africau.edu/images/default/sample.pdf"
        CacheManager.manage.cacheResponseFromURL(sourceURL: testURL, shouldStoreInCache: true, cacheType:.Zip) { (outputObject, error, CurrentCacheType) in
            XCTAssertTrue(CurrentCacheType == .Zip, "true")
            XCTAssertNotNil(outputObject, "Not nil")
        }
    }
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        evicted = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
