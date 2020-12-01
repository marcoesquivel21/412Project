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

final class country: Model, Content {
    
    static let schema = "country"
    
    @ID(custom: "name", generatedBy: .database)
    var id: String?
    
    @Field(key: "tests")
    var tests: Int?
    
    @Field(key: "deaths")
    var deaths: Int?
    
    @Field(key: "casesperonemillion")
    var casesPerOneMillion: Int?
    
    @Field(key: "cases")
    var cases: Int?
    
    @Field(key: "active")
    var active: Int?
    
    @Field(key: "critical")
    var critical: Int?
    
    @Field(key: "todaydeaths")
    var todayDeaths: Int?
    
    @Field(key: "deathsperonemillion")
    var deathsPerOneMillion: Int?
    
    @Field(key: "testsperonemillion")
    var testsPerOneMillion: Int?
    
    @Field(key: "todaycases")
    var todayCases: Int?
    
    init() {}
    
    init(name: String?, tests: Int?, deaths: Int?, casesPerOneMillion: Int?, cases: Int?, active: Int?, critical: Int?, todayDeaths: Int?, deathsPerOneMillion: Int?, testsPerOneMillion: Int?, todayCases: Int?){
        self.id = name
        self.tests = tests
        self.deaths = deaths
        self.casesPerOneMillion = casesPerOneMillion
        self.cases = cases
        self.active = active
        self.critical = critical
        self.todayDeaths = todayDeaths
        self.deathsPerOneMillion = deathsPerOneMillion
        self.testsPerOneMillion = testsPerOneMillion
        self.todayCases = todayCases
    }
    
}
