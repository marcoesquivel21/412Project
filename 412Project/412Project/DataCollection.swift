//
//  DataCollection.swift
//  412Project
//
//  Created by Anthony Salaices on 11/30/20.
//

import Foundation

struct StateStuffElement: Codable {
    public let id: String
    public let tests: Int?
    public let deaths: Int?
    public let positiveIncrease, negativeIncrease, cases: Int?
}

//testsefdsfadsfasdfashdflasjkhflasdhflsjdhflkjsdhflasdhfk

struct CountryStuffElement: Codable{
    public let id: String
    public let tests: Int?
    public let deaths: Int?
    public let casesPerOneMillion: Int?
    public let deathsPerOneMillion: Int?
    public let active: Int?
    public let critical: Int?
    public let todayDeaths: Int?
    public let testsPerOneMillion: Int?
    public let todayCases: Int?
    public let cases: Int?
}

struct DayStatStuffElement: Codable{
    public let date: String?
    public let id: String
    public let hospitalized: Int?
    public let inicu: Int?
    public let positive: Int?
    public let negative: Int?
}

typealias DayStatStuff = [DayStatStuffElement]
typealias CountryStuff = [CountryStuffElement]
typealias StateStuff = [StateStuffElement]
