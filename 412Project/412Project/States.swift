//
//  States.swift
//  412Project
//
//  Created by Anthony Salaices on 11/22/20.
//

import Foundation
import UIKit

class States{
    var States:[State] = []
    init(){
        
    }
    
    func getCount() -> Int{
        return States.count
    }
    func addStateObj(name: String, c: Int, ni: Int, pi: Int, d: Int, t: Int) -> State{
        let s = State(a: name, c: c, ni: ni, pi: pi, d: d, t: t)
        States.append(s)
        return s
    }
    
}

struct State: Codable{
    // attributes
    var abbreviation:String?
    var cases:Int?
    var negativeIncrease:Int?
    var positiveIncrease:Int?
    var deaths:Int?
    var tests:Int?
    
    init(a:String, c:Int, ni:Int, pi:Int, d:Int, t:Int){
        abbreviation = a
        cases = c
        negativeIncrease = ni
        positiveIncrease = pi
        deaths = d
        tests = t
    }
}
