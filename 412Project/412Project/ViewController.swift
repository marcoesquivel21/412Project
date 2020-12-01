//
//  ViewController.swift
//  412Project
//
//  Created by Marco Esquivel on 11/22/20.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//    struct StateStuffElement: Codable {
//        let state: String
//        let totalTestResults: Int
//        let death: Int
//        let positiveIncrease, negativeIncrease, total: Int
//    }
//
//    typealias StateStuff = [StateStuffElement]
    
    @IBOutlet weak var segmentedPick: UISegmentedControl!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var listOfStuffPicker: UIPickerView!
    
    @IBOutlet var descriptionlbls: [UILabel]!
    
    var curIndex:Int = 0
    
//    var countryList:Countries = Countries()
//    var stateList:States = States()
    
    var countryList:[Country] = [Country]()
    var stateList:[State] = [State]()
    var dayStatList:[DayStat] = [DayStat]()
    
    var displayList:[String] = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return displayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return displayList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //var tempObj = countryList.getCountryObject(item: row)
        var tempName = displayList[row]
        //curIndex = countryList.findIndex(name: tempName!)
        NameLabel.text = tempName
        for l in descriptionlbls{
            if segmentedPick.selectedSegmentIndex == 0{
                print(l.tag)
                switch l.tag {
                case 0:
                    l.text = "Cases:  \(countryList[row].cases!)"
                case 1:
                    l.text = "Active: \(countryList[row].active!)"
                case 2:
                    l.text = "Cases Per One Million: \(countryList[row].casesPerOneMillion!)"
                case 3:
                    l.text = "Critical: \(countryList[row].critical!)"
                case 4:
                    l.text = "Deaths: \(countryList[row].deaths!)"
                case 5:
                    l.text = "Deaths Per One Million: \(countryList[row].deathsPerOneMillion!)"
                case 6:
                    l.text = "Tests Per One Million: \(countryList[row].testsPerOneMillion!)"
                case 7:
                    l.text = "Today Cases: \(countryList[row].todayCases!)"
                case 8:
                    l.text = "Today Deaths: \(countryList[row].todayDeaths!)"
                case 9:
                    l.text = "Tests: \(countryList[row].tests!)"
                default:
                    print("error")
                }
            }
            else{
//                print(l.tag)
                switch l.tag {
                case 0:
                    l.text = "Cases:  \(stateList[row].cases ?? 0)"
                case 1:
                    l.text = "Negative Increase: \(stateList[row].negativeIncrease ?? 0)"
                case 2:
                    l.text = "Positive Increase: \(stateList[row].positiveIncrease ?? 0)"
                case 3:
                    l.text = "Deaths: \(stateList[row].deaths ?? 0)"
                case 4:
                    l.text = "Tests: \(stateList[row].tests ?? 0)"
                case 5:
                    l.isHidden = true
                case 6:
                    l.isHidden = true
                case 7:
                    l.isHidden = true
                case 8:
                    l.isHidden = true
                case 9:
                    l.isHidden = true
                default:
                    print("error")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listOfStuffPicker.delegate = self
        self.listOfStuffPicker.dataSource = self
        //self.countryList.addCountryObj(name: "USA BITCH")
        //print(countryList.getCount())
        reloadList()
        self.listOfStuffPicker.reloadAllComponents()
        //self.loadInAPI()
        //self.loadInAPI()
        self.loadDayStatsDB()
        self.loadCountryDB()
        self.loadStateDB()
        // Do any additional setup after loading the view.
    }
    
    func loadInAPI(){
        self.loadState()
        self.loadCountry()
    }
    
    func loadState(){
        let urlAsString = "https://api.covidtracking.com/v1/states/current.json"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(StateStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            let len = jsonResult.count
            for index in 0..<len{
                //var abr = jsonResult[index].state
                //print(abr)
                //self.loadDayStats(name: abr)
                var cases = jsonResult[index].total
                var negIn = jsonResult[index].negativeIncrease
                var posIn = jsonResult[index].positiveIncrease
                var deaths = jsonResult[index].death
                var tests = jsonResult[index].totalTestResults
                
                
                //self.stateList.append(State(a:abr, c:cases, ni:negIn, pi:posIn, d:deaths, t:tests))
                
            }
         
         
        })
        jsonQuery.resume()
    }
    
    func loadCountry(){
        let urlAsString = "https://coronavirus-19-api.herokuapp.com/countries"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(CountryStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            let len = jsonResult.count
            for index in 0..<len{
                //var country = jsonResult[index].country
                var tests = jsonResult[index].totalTests
                var deaths = jsonResult[index].deaths
                var cpom = jsonResult[index].casesPerOneMillion
                var dpom = jsonResult[index].deathsPerOneMillion
                var active = jsonResult[index].active
                var crit = jsonResult[index].critical
                var td = jsonResult[index].todayDeaths
                var tpom = jsonResult[index].testsPerOneMillion
                var tc = jsonResult[index].todayCases
                var cases = jsonResult[index].cases
                
                
                
                //self.countryList.append(Country(n:country, d:deaths ?? 0, cpom:cpom ?? 0, c:cases ?? 0, a:active ?? 0, crit:crit ?? 0, td: td ?? 0, dpom: dpom ?? 0, tpom:tpom ?? 0, tc:tc ?? 0))
            }
            
            DispatchQueue.main.async{
                self.reloadList()
                self.listOfStuffPicker.reloadAllComponents()
            }
            
         
         
        })
        jsonQuery.resume()
    }
    
    func loadDayStats(name: String){
        let urlAsString = "https://api.covidtracking.com/v1/states/" + name + "/daily.json"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(DayStatStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            for index in 0..<7{
                var d = jsonResult[index].date
                //var s = jsonResult[index].state
                //print(s)
                var h = jsonResult[index].hospitalized
                var icu = jsonResult[index].inIcuCumulative
                var pos = jsonResult[index].positive
                var neg = jsonResult[index].negative
                
                
                //self.dayStatList.append(DayStat(d: d ?? 0, a: s, h: h ?? 0, icu: icu ?? 0, p: pos ?? 0, n: neg ?? 0))
            }
            
            DispatchQueue.main.async{
                self.reloadList()
                self.listOfStuffPicker.reloadAllComponents()
                //print(self.dayStatList.getCount())
                print(self.dayStatList.count)
            }
         
        })
        jsonQuery.resume()
    }
    
    func loadDayStatsDB(){
        let urlAsString = "http://127.0.0.1:8080/daystats"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(DayStatStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            for index in 0..<jsonResult.count{
                var d = jsonResult[index].date
                var s = jsonResult[index].id
                //print(s)
                var h = jsonResult[index].hospitalized
                var icu = jsonResult[index].inIcuCumulative
                var pos = jsonResult[index].positive
                var neg = jsonResult[index].negative
                
                //self.dayStatList.addDayStatObj(d: d ?? 0, a: s, h: h ?? 0, icu: icu ?? 0, p: pos ?? 0, n: neg ?? 0)
                //var temp = DayStat()
                self.dayStatList.append(DayStat(d: d!, a: s, h: h ?? 0, icu: icu ?? 0, p: pos ?? 0, n: neg ?? 0))
            }
            
            DispatchQueue.main.async{
                self.reloadList()
                self.listOfStuffPicker.reloadAllComponents()
                //print(self.dayStatList.getCount())
                print(self.dayStatList.count)
            }
         
        })
        jsonQuery.resume()
    }
    
    func loadCountryDB(){
        let urlAsString = "http://127.0.0.1:8080/country"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(CountryStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            let len = jsonResult.count
            for index in 0..<len{
                var country = jsonResult[index].id
                var tests = jsonResult[index].totalTests
                var deaths = jsonResult[index].deaths
                var cpom = jsonResult[index].casesPerOneMillion
                var dpom = jsonResult[index].deathsPerOneMillion
                var active = jsonResult[index].active
                var crit = jsonResult[index].critical
                var td = jsonResult[index].todayDeaths
                var tpom = jsonResult[index].testsPerOneMillion
                var tc = jsonResult[index].todayCases
                var cases = jsonResult[index].cases
                
                
                //self.countryList.addCountryObj(name: country, d: deaths ?? 0, cpom: cpom ?? 0, c: cases ?? 0, a: active ?? 0, crit: crit ?? 0, td: td ?? 0, dpom: dpom ?? 0, tpom: tpom ?? 0, tc: tc ?? 0)
                self.countryList.append(Country(n:country, t: tests ?? 0, d:deaths ?? 0, cpom:cpom ?? 0, c:cases ?? 0, a:active ?? 0, crit:crit ?? 0, td: td ?? 0, dpom: dpom ?? 0, tpom:tpom ?? 0, tc:tc ?? 0))
            }
            
            DispatchQueue.main.async{
                self.reloadList()
                self.listOfStuffPicker.reloadAllComponents()
            }
            
         
         
        })
        jsonQuery.resume()
    }
    
    func loadStateDB(){
        let urlAsString = "http://127.0.0.1:8080/state"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                           if (error != nil) {
                       print(error!.localizedDescription)
                           }
            var err: NSError?
            let decoder = JSONDecoder()
            if data == nil{
            }
            let jsonResult = try! decoder.decode(StateStuff.self, from: data!)
            if (err != nil)
            {
                print("Error JS\(err!.localizedDescription)")
            }
            let len = jsonResult.count
            for index in 0..<len{
                var abr = jsonResult[index].id
                print(abr)
                //self.loadDayStats(name: abr)
                var cases = jsonResult[index].total
                var negIn = jsonResult[index].negativeIncrease
                var posIn = jsonResult[index].positiveIncrease
                var deaths = jsonResult[index].death
                var tests = jsonResult[index].totalTestResults
                
                //self.stateList.addStateObj(name: abr, c: cases, ni: negIn, pi: posIn, d: deaths, t: tests)
                self.stateList.append(State(a:abr, c:cases ?? 0, ni:negIn ?? 0, pi:posIn ?? 0, d:deaths ?? 0, t:tests ?? 0))
                
            }
         
         
        })
        jsonQuery.resume()
    }
    
    
    
    
    
    func reloadList(){
        displayList.removeAll()
        
        if segmentedPick.selectedSegmentIndex == 0{
            if countryList.count != 0{
                var total = countryList.count - 1
                for index in 0...total{
                    //var curObj = countryList.getCountryObject(item: index)
                    var curObj = countryList[index]
                    var curStr = curObj.name
                    //print(curStr)
                    displayList.append(curStr!)
                }
                listOfStuffPicker.selectRow(0, inComponent: 0, animated: true)
                NameLabel.text = displayList[0]
                
            }
        }
        else{
            if stateList.count != 0{
                var total = stateList.count - 1
                for index in 0...total{
                    //var curObj = countryList.getCountryObject(item: index)
                    var curObj = stateList[index]
                    var curStr = curObj.abbreviation
                    //print(curStr)
                    displayList.append(curStr!)
                }
                listOfStuffPicker.selectRow(0, inComponent: 0, animated: true)
                NameLabel.text = displayList[0]
            }
        }
        
        self.listOfStuffPicker.reloadAllComponents()
        
        
        
        /*
         if country is active display country
         else display states
         */
    }
    
    @IBAction func segDidChange(_ sender: Any) {
        reloadList()
    }
    
}

