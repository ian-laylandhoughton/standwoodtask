//
//  RepositoriesViewModelImplTests.swift
//  StandwoodTaskTests
//
//  Created by Ian Layland-Houghton on 03/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import XCTest
@testable import StandwoodTask
import StanwoodCore

class RepositoriesViewModelImplTests: XCTestCase {
    
    let testRepo = GitHubRepo(owner: GithubOwner(username: "usernae", avatarURL: "avatarUrl"),
                              repoName: "repoName",
                              description: "description",
                              stars: 5,
                              language: "language",
                              forks: 5,
                              creationDate: "2020-05-26T07:26:02Z",
                              githubUrl: "url")
    var SUT = RepositoriesViewModelImpl()
    
    override func setUpWithError() throws {
        SUT.delegate = self
    }
    
    func testScreenTitleReturnsCorrectValue() {
        XCTAssertEqual(SUT.screenTitle, NSLocalizedString("repositories_title", comment: "Repositories title"))
    }
    
    func testCellSizeCorrectValue() {
        XCTAssertEqual(SUT.cellSize, CGSize(width: 600.0, height: 90.0))
    }
    
    func testHasMoreReposCorrectValue() {
        SUT.dataSource = []
        XCTAssertFalse(SUT.hasMoreRepos)
        SUT.dataSource = [self.testRepo, self.testRepo]
        XCTAssertTrue(SUT.hasMoreRepos)
    }
    
    func testSegmentedControlDidChange() {
        SUT.dataSource = [self.testRepo, self.testRepo]
        SUT.segmentedControlDidChange()
        XCTAssertEqual(SUT.dataSource.count, 0)
    }
}

extension RepositoriesViewModelImplTests: RepositoriesViewModelDelegate {
    func collectionViewSize() -> CGSize {
        return CGSize(width: 600, height: 900)
    }
    
    func getReposOnComplete() {
        
    }
    
    func getReposDidFail(error: String) {
        
    }
}
