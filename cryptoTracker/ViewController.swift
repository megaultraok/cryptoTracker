//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Jada White on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if let symbol = textField.text{
            getData(symbol: symbol)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
        
    func getData(symbol: String){
        
        url = "\(url)&fsym=\(symbol)"
        
        // Step 1: Initialize URL
        guard let url = URL(string: url) else { return }
        
        
        // Step 2: Initialize task and url session
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            // Checking optionals
            guard let data = data, error == nil else { return }
            
            print("Data received.")
            // Grand Central Dispatch
            
            do{
                let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                print(Result.USD)
                
                DispatchQueue.main.async {
                    self.outputLabel.text = "\(Result.USD)"
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        // Step 3: task.resume -> Initiates process
        task.resume()
    }
    
    struct APIResponse : Codable {
        let USD : Float
    }

}

