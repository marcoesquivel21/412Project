//
//  DayStats.swift
//  412Project
//
//  Created by Anthony Salaices on 11/22/20.
//

import Foundation
import UIKit

class DayStats{
    var dayStats:[DayStat] = []
    init(){
        
    }
    func getCount() -> Int{
        return dayStats.count
    }
//    func addDayStatObj(d: Int, a: String, h: Int, icu: Int, p: Int, n: Int) -> DayStat{
//        let ds = DayStat(d:d, a:a, h:h, icu:icu, p:p, n:n)
//        dayStats.append(ds)
//        return ds
//    }
}

struct DayStat: Codable{
    // attributes
    var date:String?
    var abbreviation:String?
    var hospitalized:Int?
    var inICU:Int?
    var positive:Int?
    var negative:Int?
    
    init(d:String, a:String, h:Int, icu:Int, p:Int, n:Int){
        date = d
        abbreviation = a
        hospitalized = h
        inICU = icu
        positive = p
        negative = n
    }
    
}

