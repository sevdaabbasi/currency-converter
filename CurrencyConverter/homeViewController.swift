//
//  homeViewController.swift
//  CurrencyConverter
//
//  Created by Sevda Abbasi on 25.05.2023.
//
/*
import UIKit

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let currency = Currency(name: "aaa", values: )
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=ecf7e2e1c75311ded2c90276f9571ad4")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) {  (data, response, error) in
            
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
                
            }
            else {
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print (rates)
                                if let cad = rates["CAD"] as? Double{
                                    print(cad)
                                }
                            }
                        }
                        
                    }catch{
                        print ("error")}
                }
                
               
            }
            
           
            
            
            
            
            
            
            
        }
        task.resume()
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 35
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()//içerik = content
            content.text = "Tableview"
            content.secondaryText = "test"
            cell.contentConfiguration = content
            return cell
        }
        
        
        
        
        
        @IBAction func buttonClicked(_ sender: Any) {
            
        }
    }
    
    
    */
    
import UIKit

class homeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var currencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        let url = URL(string: "http://data.fixer.io/api/latest?access_key=ecf7e2e1c75311ded2c90276f9571ad4")
        let session = URLSession.shared

        let task = session.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let rates = jsonResponse["rates"] as? [String: Double] {
                            for (name, value) in rates {
                                let currency = Currency(name: name, values: value)
                                self.currencies.append(currency)
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    } catch {
                        print("JSON parsing error: \(error)")
                    }
                }
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let currency = currencies[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = currency.name
        content.secondaryText = "\(currency.values)"
        cell.contentConfiguration = content
        return cell
    }

}

/*struct Currency {
    let name: String
    let value: Double
}*/

    
    
    

