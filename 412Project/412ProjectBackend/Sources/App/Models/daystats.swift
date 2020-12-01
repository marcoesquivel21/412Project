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

final class daystats: Model, Content {
    
    
    static let schema = "daystats"
    
    @ID(custom: "abbreviation", generatedBy: .database)
    var id: String?
    
    @ID(custom: "date", generatedBy: .database)
    var date: Date?
    
    @Field(key: "positive")
    var positive: Int?
    
    @Field(key: "negative")
    var negative: Int?
    
    @Field(key: "hospitalized")
    var hospitalized: Int?
    
    @Field(key: "inicu")
    var inicu: Int?
    
    init() {}
    
    init(abbreviation: String?, date: Date?, positive: Int?, negative: Int?, hospitalized: Int?, inicu: Int?){
        self.id = abbreviation
        self.date = date
        self.positive = positive
        self.negative = negative
        self.hospitalized = hospitalized
        self.inicu = inicu
    }
    
}
