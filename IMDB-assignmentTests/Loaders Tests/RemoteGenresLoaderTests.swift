//
//  RemoteGenresLoaderTests.swift
//  IMDB-assignmentTests
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import XCTest
@testable import IMDBAssignment
import lit_network

class RemoteGenresLoaderTests: XCTestCase {
 
    private var statusOK: Int {
        return 200
    }
    private var statusNotFound: Int {
        return 404
    }
    
    func test_deliverGenreListOnValidData() {
        let (sut, http) = makeSUT()
        
        expect(sut, toComplete: .success(JSONMockData.list.genres), when: {
            /** Mock HTTPClient complete the passed data so the `sut.load` function will be completed */
            http.complete(withSatus: statusOK, data: JSONMockData.genresData())
        })
    }
        
    func test_deliverErrorOnStatusOKAndInvalidData() {
        let (sut, http) = makeSUT()
        
        expect(sut, toComplete: .failure(.invalidData), when: {
            http.complete(withSatus: statusNotFound, data: JSONMockData.genresData())
        })
    }
    
    func test_deliverErrorOnErrorData() {
        let (sut, http) = makeSUT()
        
        expect(sut, toComplete: .failure(.connectivity), when: {
            http.complete(with: NSError())
        })
    }
    
    // MARK: Helpers
    
    /** Creatign mock implentation of HTTPClient */
    private func makeSUT() -> (RemoteGenresLoader, HTTPClientMock) {
        let http = HTTPClientMock()
        
        /** Constructor injection of http client to fake the request */
        return (RemoteGenresLoader(http: http), http)
    }
    
    private func expect(_ sut: RemoteGenresLoader, toComplete result: RemoteGenresLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        /** It's an array since we want to make sure it's not completed a few times */
        var capturedResult = [RemoteGenresLoader.Result]()
        
        sut.load(with: URLS.env.genres) { result in
            capturedResult.append(result)
        }
        
        action()
        
        XCTAssertEqual(capturedResult, [result], file: file, line: line)
    }
}

struct JSONMockData {
    static let genre1 = Genre(id: 192, name: "Action")
    static let genre2 = Genre(id: 192, name: "Action")
    
    static var list = GenresList(genres:  [JSONMockData.genre1, JSONMockData.genre2])
    
    static func genresData(list: GenresList = GenresList(genres:  [JSONMockData.genre1, JSONMockData.genre2])) -> Data {
        return try! JSONEncoder().encode(list)
    }
}
