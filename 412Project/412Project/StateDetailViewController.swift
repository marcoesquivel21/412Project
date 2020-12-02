//
//  StateDetailViewController.swift
//  412Project
//
//  Created by Marco Esquivel on 12/1/20.
//

import UIKit

class StateDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayStatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StatTableViewCell = statTable.dequeueReusableCell(withIdentifier: "cell") as! StatTableViewCell
        
        cell.dateLabel.text = "Date and Time: \(dayStatList[indexPath.row].date ?? "0")"
        cell.postiveLabel.text = "Postive Cases: \(String(dayStatList[indexPath.row].positive ?? 0))"
        cell.negativeLabel.text = "Negative Cases: \(String(dayStatList[indexPath.row].negative ?? 0))"
        cell.hospitalLabel.text = "Hospitlizations: \(String(dayStatList[indexPath.row].hospitalized ?? 0))"
        cell.IcuLabel.text = "In ICU: \(String(dayStatList[indexPath.row].inICU!))"
        
        return cell
                
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    
    @IBOutlet weak var statTable: UITableView!
    var state:String?
    var dayStatList:[DayStat] = [DayStat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.topItem?.title = state ?? "Error"
        loadDayStatsDB()
        statTable.delegate = self
        statTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func loadDayStatsDB(){
        let urlAsString = "http://127.0.0.1:8080/daystats/\(state!)"

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
                var icu = jsonResult[index].inicu
                var pos = jsonResult[index].positive
                var neg = jsonResult[index].negative
                
                print(icu)

                //self.dayStatList.addDayStatObj(d: d ?? 0, a: s, h: h ?? 0, icu: icu ?? 0, p: pos ?? 0, n: neg ?? 0)
                //var temp = DayStat()
                self.dayStatList.append(DayStat(d: d!, a: s, h: h ?? 0, icu: icu ?? 0, p: pos ?? 0, n: neg ?? 0))
            }

            DispatchQueue.main.async{
                //print(self.dayStatList.getCount())
                self.statTable.reloadData()
                print(self.dayStatList.count)
            }

        })
        jsonQuery.resume()
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
