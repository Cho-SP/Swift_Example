//
//  ViewController.swift
//  dogInfo
//
//  Created by RIHOZ on 09/09/2019.
//  Copyright © 2019 RIHOZ. All rights reserved.
//

import UIKit

let YES: Bool = true
let NO: Bool = false
let encoder = JSONEncoder()
let decoder = JSONDecoder()
let cal = Calendar.current
//-------------------------------------------------|

// MARK: - Protocols

protocol DataForm: Codable{
    var name: String { get set }
    var birth: String { get set }
}
protocol DataDelegate{
    func sendData(textData: String)
}
//-------------------------------------------------|

//-------------------------------------------------|

// MARK: - Structres

struct dogData: DataForm{
    
    var name: String
    var birth: String
    
    init(name: String, birth: String){
        self.name = name
        self.birth = birth
    }
    func showDogDescription() -> String {
        let birthDate = dateFormatter.date(from:birth)
        let nowDate = Date()
        let nowYear = cal.component(.year, from: nowDate)
        let nowMonth = cal.component(.month, from: nowDate)
        let calYear = cal.component(.year, from: birthDate!)
        let calMonth = cal.component(.month, from: birthDate!)
        let calDay = cal.component(.day, from: birthDate!)
        
        let age = nowYear - calYear + 1
        let dogMonth = calYear == nowYear ? nowMonth-calMonth : (nowMonth - calMonth+((nowYear - calYear)*12))*7
        let dogAge = calYear == nowYear ? dogMonth/12 : dogMonth/12+1
        
        
        return """
        이름 : \(name)\n
        생일 : \(calYear)년 \(calMonth)월 \(calDay)일\n
        한국 나이 : \(age)세\n
        강아지 나이 : \(dogMonth)개월 (\(dogAge)세)\n
        ※ 강아지 나이는 개월수x7을 기준으로 합니다.
        """
    }
    
}

//-------------------------------------------------|
 
var dateFormatter: DateFormatter{
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}

class ViewController: UIViewController, UITextViewDelegate {
    
    var delegate:DataDelegate?
    
    //-------------------------------------------------|
    
    // MARK: - Outlets
    
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var dogBirthField: UITextField!
    @IBOutlet weak var dogResultView: UITextView!

    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = YES
        dogBirthField.inputView = datePicker
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Custom Functions
    
    var datePicker: UIDatePicker {
        let picker = UIDatePicker()
        picker.maximumDate = Date()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(_sender:)), for: .valueChanged)
        return picker
    }
    
    @objc func datePickerChanged(_sender: UIDatePicker){
        dogBirthField.text = dateFormatter.string(from: _sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(YES)
    }
    
    func saveDogData(dog: dogData) {
        var dogs = [dogData]()
        var encoded = [Data]()
        if let dogArray = UserDefaults.standard.array(forKey: "DB") {
            for i in 0..<(dogArray.count ){
                dogs.append(try! decoder.decode(dogData.self, from: dogArray[i] as! Data))
            }
        }
        dogs.append(dog)
        print(dog)
        print(dogs)
        for i in 0..<(dogs.count){
            encoded.append(try! encoder.encode(dogs[i]))
        }
        UserDefaults.standard.set(encoded, forKey: "DB")
    }
    
    func textFieldInit(){
        dogNameField.text = ""
        dogBirthField.text = ""
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - IB Functions
    
    @IBAction func dogConfirm(_ sender: Any) {
        if dogNameField.text != "" && dogBirthField.text != "" {
            let dog = dogData(name: dogNameField.text!, birth: dogBirthField.text!)
            dogResultView!.text = dog.showDogDescription()
            saveDogData(dog: dog)
            textFieldInit()
        } else {
            dogResultView!.text = "이름과 생일을 입력하시고 Confirm을 눌러주세요"
        }
        print("confirm button pressed")
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        print("history button pressed")
        print(UserDefaults.standard.array(forKey:"DB")!)
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "historyVC") as! HistoryViewController
        destination.vc = self
        self.navigationController?.pushViewController(destination, animated: YES)
    }
    
    //-------------------------------------------------|
    
}
