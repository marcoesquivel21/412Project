//
//  UpdateViewController.swift
//  412Project
//
//  Created by Carter Liu on 12/1/20.
//

import UIKit

class UpdateViewController: UIViewController {

    var selectedVal:Int?
    var id:String?
    
    @IBOutlet weak var currentId: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
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
        currentId.text = id
        currentId.sizeToFit()
        if selectedVal == 1{
            errorLabel.text = "Please go back and select a country"
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
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func updateCountry(_ sender: Any) {
        update(tests: countryTestsText.text!, deaths: countryDeathsText.text!, casesMilli: countryCasesPerMillionText.text!, cases: countryCasesText.text!, active: countryActiveText.text!, critical: countryCriticalText.text!, deathsToday: countryDeathsTodayText.text!, deathsMilli: countryDeathsPerMillionText.text!, testsMilli: countryTestsPerMillionText.text!, casesToday: countryCasesTodayText.text!)
    }
    
    func update(tests: String, deaths: String, casesMilli: String, cases: String, active: String, critical: String, deathsToday: String, deathsMilli: String, testsMilli:String, casesToday: String){
        self.id = id?.trimmingCharacters(in: .whitespaces)
        
        let url = URL(string: "http://127.0.0.1:8080/updateCountry/\(String(describing: id!))/\(tests)/\(deaths)/\(casesMilli)/\(deathsMilli)/\(active)/\(critical)/\(deathsToday)/\(testsMilli)/\(casesToday)/\(cases)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"

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
