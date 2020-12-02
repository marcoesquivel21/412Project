//
//  AddViewController.swift
//  412Project
//
//  Created by Anthony Salaices on 12/1/20.
//

import UIKit

class AddViewController: UIViewController {
    var selectedVal:Int?
    
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var casesText: UITextField!
    @IBOutlet weak var posIncText: UITextField!
    @IBOutlet weak var negIncText: UITextField!
    @IBOutlet weak var deathsText: UITextField!
    @IBOutlet weak var testsText: UITextField!
    @IBOutlet weak var stateAdd: UIButton!
    
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var countryIDText: UITextField!
    @IBOutlet weak var countryTestsText: UITextField!
    @IBOutlet weak var countryDeathsText: UITextField!
    @IBOutlet weak var countryCasesPerMillionText: UITextField!
    @IBOutlet weak var countryCasesText: UITextField!
    @IBOutlet weak var countryActiveText: UITextField!
    @IBOutlet weak var countryCriticalText: UITextField!
    @IBOutlet weak var countryDeathsTodayText: UITextField!
    @IBOutlet weak var countryDeathsPerMillionText: UITextField!
    @IBOutlet weak var countryTestsPerMillionText: UITextField!
    @IBOutlet weak var countryCasesTodayText: UITextField!
    @IBOutlet weak var countryAdd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedVal == 0{
            headerLbl.text = "Insert a Country"
            idText.isHidden = true
            casesText.isHidden = true
            posIncText.isHidden = true
            negIncText.isHidden = true
            deathsText.isHidden = true
            testsText.isHidden = true
            stateAdd.isHidden = true
        }
        else{
            headerLbl.text = "Insert a State"
            countryIDText.isHidden = true
            countryTestsText.isHidden = true
            countryDeathsText.isHidden = true
            countryCasesPerMillionText.isHidden = true
            countryCasesText.isHidden = true
            countryActiveText.isHidden = true
            countryCriticalText.isHidden = true
            countryDeathsTodayText.isHidden = true
            countryDeathsPerMillionText.isHidden = true
            countryTestsPerMillionText.isHidden = true
            countryCasesTodayText.isHidden = true
            countryAdd.isHidden = true
        }
        
        //insertCountry()
        //insertState()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        insertState(id: idText.text!, cases: casesText.text ?? "0", posInc: posIncText.text ?? "0", negInc: negIncText.text ?? "0", deaths: deathsText.text ?? "0", tests: testsText.text ?? "0")
    }
    
    @IBAction func addCountry(_ sender: Any) {
        insertCountry(id: countryIDText.text!, tests: countryTestsText.text ?? "0", deaths: countryDeathsText.text ?? "0", casesMilli: countryCasesPerMillionText.text ?? "0", cases: countryCasesText.text ?? "0", active: countryActiveText.text ?? "0", critical: countryCriticalText.text ?? "0", deathsToday: countryDeathsTodayText.text ?? "0", deathsMilli: countryDeathsPerMillionText.text ?? "0", testsMilli: countryTestsPerMillionText.text ?? "0", casesToday: countryCasesTodayText.text ?? "0")
    }
    
    func insertCountry(id: String, tests: String, deaths: String, casesMilli: String, cases: String, active: String, critical: String, deathsToday: String, deathsMilli: String, testsMilli:String, casesToday: String){
        
        
        
        
        let url = URL(string: "http://127.0.0.1:8080/addCountry/\(id)/\(tests)/\(deaths)/\(casesMilli)/\(deathsMilli)/\(active)/\(critical)/\(deathsToday)/\(testsMilli)/\(casesToday)/\(cases)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            // print(data)
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshStatus"), object: nil)
        }
        task.resume()
    }
    
    func insertState(id: String, cases: String, posInc: String, negInc: String, deaths: String, tests: String){
        
        let url = URL(string: "http://127.0.0.1:8080/addState/\(id)/\(cases)/\(negInc)/\(posInc)/\(deaths)/\(tests)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            // print(data)
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RefreshStatus"), object: nil)
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
