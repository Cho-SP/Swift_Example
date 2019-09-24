//
//  HistoryViewController.swift
//  dogInfo
//
//  Created by RIHOZ on 10/09/2019.
//  Copyright © 2019 RIHOZ. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataDelegate {
    
    //-------------------------------------------------|
    
    // MARK: - Outlets
    
    @IBOutlet weak var dogTableView: UITableView!
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Instance Properties
    
    var dog = [dogData]()
    var dogLoad = [Data]()
    var vc:ViewController!
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - ViewController Functions
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        loadDogs()
        prepareTableView()
        vc.delegate = self
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Custom Functions
    
    func loadDogs() {
        if((UserDefaults.standard.array(forKey: "DB")) != nil){
            dogLoad = UserDefaults.standard.array(forKey: "DB") as! [Data]
            for i in 0..<dogLoad.count{
                dog.append(try! decoder.decode(dogData.self, from: dogLoad[i]))
            }
        }
    }
    
    func prepareTableView() {
        dogTableView.dataSource = self
        dogTableView.delegate = self
        
        dogTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath)
        
        let dogs = dog[indexPath.row]
        cell.textLabel?.text = dogs.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(dog[indexPath.row]) is selected")
        let history = dog[indexPath.row]
        
        print(history.showDogDescription())
        sendData(textData: history.showDogDescription())
            
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Delegate Functions
    
    func sendData(textData: String) {
        print("sendField is running")
        print(textData)
        if let textViewResult = vc.dogResultView {
            textViewResult.text = textData
            print(textViewResult.text!)
        } else {
            print("dogResultView is nil")
        }
    }
    
    //-------------------------------------------------|
    
}
