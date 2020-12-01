//
//  Countries.swift
//  412Project
//
//  Created by Anthony Salaices on 11/22/20.
//

import Foundation
import UIKit

class Countries{
    var Countries:[Country] = []
    init(){
        
    }
    
//    func getCount() -> Int{
//        return Countries.count
//    }
//    
//    func findIndex(name:String) -> Int{
//        var count = 0
//        var index = 0
//        for Country in Countries{
//            if Country.name == name{
//                index = count
//            }
//            count += 1
//        }
//        return index
//    }
//    
//    func addCountryObj(name: String, d: Int, cpom: Int, c: Int, a: Int, crit: Int, td: Int, dpom: Int, tpom: Int, tc: Int) -> Country{
//        let c = Country(n: name, d: d, cpom: cpom, c: c, a: a, crit: crit, td: td, dpom: dpom, tpom: tpom, tc: tc)
//        Countries.append(c)
//        return c
//    }
//    
//    func getCountryObject(item:Int) -> Country{
//        return Countries[item]
//    }
    
}

struct Country: Codable{
    // attributes
    var name:String?
    var tests:Int?
    var deaths:Int?
    var casesPerOneMillion:Int?
    var cases:Int?
    var active:Int?
    var critical:Int?
    var todayDeaths:Int?
    var deathsPerOneMillion:Int?
    var testsPerOneMillion:Int?
    var todayCases:Int?
    
    init(n:String, t: Int,d:Int, cpom:Int, c:Int, a:Int, crit:Int, td: Int, dpom: Int, tpom:Int, tc:Int){
        name = n
        tests = t
        deaths = d
        casesPerOneMillion = cpom
        cases = c
        active = a
        critical = crit
        todayDeaths = td
        deathsPerOneMillion = dpom
        testsPerOneMillion = tpom
        todayCases = tc
    }
}
