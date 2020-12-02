//
//  AddViewController.swift
//  412Project
//
//  Created by Anthony Salaices on 12/1/20.
//

import UIKit

class AddViewController: UIViewController {
    var selectedVal:Int?
    
    
    @IBOutlet weak var headerLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedVal == 0{
            headerLbl.text = "Insert a Country"
        }
        else{
            headerLbl.text = "Insert a State"
        }
        
        //insertCountry()
        insertState()
        // Do any additional setup after loading the view.
    }
    
    func insertCountry(){
        let json: [String: Any] = ["id": "HEEHAW",
                                    "tests": 0,
                                     "deaths": 0,
                                      "casesperonemillion": 0,
                                       "cases": 0,
                                        "active": 0,
                                         "critical": 0,
                                          "todaydeaths": 0,
                                           "deathsperonemillion": 0,
                                            "todaycases": 0]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "http://127.0.0.1:8080/addCountry")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    
    func insertState(){
        var id = "MM"
        var cases = 0
        var positiveincrease = 0
        var negativeincrease = 0
        var deaths: Optional<Int> = Int("0")
        var tests: Optional<Int> = Int("0")
        
        
        let parameters = "{\"id\":\"\(String(describing: id))\"," +
            "\"cases\":\"\(String(describing: cases))\"," +
            "\"positiveincrease\":\"\(String(describing: positiveincrease))\"," +
            "\"negativeincrease\":\"\(String(describing: negativeincrease))\","  +
            "\"deaths\":\"\(String(describing: deaths))\"," +
                "\"tests\":\"\(String(describing: tests))\"}"
        
        
        print(parameters)
        
        let url = URL(string: "http://127.0.0.1:8080/addState")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postParameters = parameters
        request.httpBody = postParameters.data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("*", forHTTPHeaderField: "Access-Control-Allow-Origin")

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
