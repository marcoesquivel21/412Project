//
//  File.swift
//  
//
//  Created by Anthony Salaices on 11/30/20.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class state: Model, Content {
    
    static let schema = "state"
    
    @ID(custom: "abbreviation", generatedBy: .user)
    var id: String?

    @Field(key: "cases")
    var cases: Int?

    @Field(key: "negativeincrease")
    var negativeIncrease: Int?

    @Field(key: "positiveincrease")
    var positiveIncrease: Int?

    @Field(key: "deaths")
    var deaths: Int?

    @Field(key: "tests")
    var tests: Int?
    
    
    init() {}
    
    init(abbreviation: String?, cases: Int?, negativeIncrease: Int?, positiveIncrease: Int?, deaths: Int?, tests: Int?){
        self.id = abbreviation
        self.cases = cases
        self.negativeIncrease = negativeIncrease
        self.positiveIncrease = positiveIncrease
        self.deaths = deaths
        self.tests = tests
    }
}
