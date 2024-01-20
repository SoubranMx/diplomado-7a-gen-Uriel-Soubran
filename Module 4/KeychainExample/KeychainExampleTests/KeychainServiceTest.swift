//
//  KeychainServiceTest.swift
//  KeychainExampleTests
//
//  Created by Diplomado on 19/01/24.
//

import XCTest
@testable import KeychainExample //se necesita hacer esto para traer todo el proyecto y acceder a sus clases y archivos

final class KeychainServiceTest: XCTestCase {

    let service = KeychainService()
//    let testKey = "testkey12345"
    let testKey = UUID().uuidString
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service.delete(key: testKey)
    }

    func testSaveKeyWithoutError() throws {
        try! service.save(key: testKey, value: "IAmVengeance!🦇")
        XCTAssert(true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSaveAndLoadKey() throws{
        try! service.save(key: testKey, value: "IAmVengeance!🦇")
        let result = try! service.load(key: testKey)
        XCTAssertNotNil(result)
    }
    
    func testDeleteKey() throws {
        let key = "NaNaNaNaNaNa"
        try! service.save(key: key, value: "IAmVengeance!🦇")
        service.delete(key: key)
        let result = try? service.load(key: key)
        
        XCTAssert(true)
        XCTAssertNil(result)
    }
    
    func testQueuedSaveWithoutError() throws {
//        para probar cosas asincronas
        let expectation = XCTestExpectation(description: "Save in queue")
        service.save(key: testKey, value: "IAmVengeance!🦇") { err in
            XCTAssertNil(err)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
