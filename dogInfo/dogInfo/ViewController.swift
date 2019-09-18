//
//  ViewController.swift
//  dogInfo
//
//  Created by RIHOZ on 09/09/2019.
//  Copyright © 2019 RIHOZ. All rights reserved.
//

import UIKit
/*
protocol SendDataDelegate{
    func sendData(data: String)
}
 */
class ViewController: UIViewController{
    struct dogSend :DataForm {
        var dName: String
        var dYear: String
        var dMonth: String
        var dDay: String
        var dAge: String
        var dDogAge: String
        var dDogMonth: String
        init(){
            dName = "X"
            dYear = "X"
            dMonth = "X"
            dDay = "X"
            dAge = "X"
            dDogMonth = "X"
            dDogAge = "X"
        }
    }
    var dog = dogSend() // 데이터 저장 시 사용
    var counter:Int = 1
    var dogCounter:Int?
    let cal = Calendar.current
    
    @IBOutlet weak var dogName: UITextField!
    
    @IBOutlet weak var dogResult: UITextView!

    @IBOutlet weak var testField: UITextField!
    
    @IBOutlet weak var dogBirth: UITextField!
    
    var datePicker:UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(_sender:)), for: .valueChanged)
        return picker
    }
    
    var dateFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    @objc func datePickerChanged(_sender:UIDatePicker){
        dogBirth.text = dateFormatter.string(from: _sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogBirth.inputView = datePicker
        dogCounter = UserDefaults.standard.object(forKey: "dCount") as? Int
        if(dogCounter != nil){
            counter = dogCounter!
        }
    }
    
    @IBAction func dogConfirm(_ sender: Any) {
        let name = dogName.text
        var k = 1
        while(k<=dogCounter!) // 중복 체크
        {
            if(name == UserDefaults.standard.string(forKey: "dName_"+String(k))){
                break
            }
            k += 1
        }
        print ("dogCounter is \(dogCounter!) and k is \(k)") // 중복이 아닐 경우 k는 dogCounter+1 중복이면 그 이하
        if(k<=dogCounter!){ // 중복일 경우 공백으로 변경
            dogName.text = ""
            dogBirth.text = ""
        }
        if (name != "" && dogBirth.text != "") {
            let stringDate:String? = dogBirth.text
            let dateDate:Date? = dateFormatter.date(from: stringDate!)
            let nowDate = Date()
            let nowYear = cal.component(.year, from: nowDate)
            let nowMonth = cal.component(.month, from: nowDate)
            let calYear = cal.component(.year, from: dateDate!)
            let calMonth = cal.component(.month, from: dateDate!)
            let calDay = cal.component(.day, from: dateDate!)
            
            let age:Int = nowYear-calYear+1
            let dogAge:Int
            var dogHumanAge:Int
            
            if(calYear==nowYear){
                dogAge = nowMonth-calMonth
                dogHumanAge = dogAge/12
            } else {
                dogAge = (nowMonth-calMonth+((nowYear-calYear)*12))*7
                dogHumanAge = dogAge/12+1
            }
            dogResult.text = """
            이름 : \(String(describing: name!))\n
            생일 : \(calYear)년 \(calMonth)월 \(calDay)일\n
            한국 나이 : \(age)세\n
            강아지 나이 : \(dogAge)개월 (\(dogHumanAge)세)\n
            ※ 강아지 나이는 개월수x7을 기준으로 합니다.
            """
            dog.dName = name!
            dog.dYear = String(calYear)
            dog.dMonth = String(calMonth)
            dog.dDay = String(calDay)
            dog.dAge = String(age)
            dog.dDogMonth = String(dogAge)
            dog.dDogAge = String(dogHumanAge)
            
            UserDefaults.standard.set(dog.dName, forKey: "dName_"+String(counter))
            UserDefaults.standard.set(dog.dYear, forKey: "dYear_"+String(counter))
            UserDefaults.standard.set(dog.dMonth, forKey: "dMonth_"+String(counter))
            UserDefaults.standard.set(dog.dDay, forKey: "dDay_"+String(counter))
            UserDefaults.standard.set(dog.dAge, forKey: "dAge_"+String(counter))
            UserDefaults.standard.set(dog.dDogMonth, forKey: "dDogMonth_"+String(counter))
            UserDefaults.standard.set(dog.dDogAge, forKey: "dDogAge_"+String(counter))
            counter += 1
            UserDefaults.standard.set(counter, forKey:"dCount")
            
            dogName.text = ""
            dogBirth.text = ""
        } else if (k<=dogCounter!) {
            dogResult.text = "\"\(name!)\"은(는) 중복되는 이름입니다."
        } else {
            dogResult.text = "이름과 생일을 입력하시고 Confirm을 눌러주세요"
        }
    }
    
    @IBAction func dogHistory(_ sender: Any) {
        /*
        let data = "aaaa"
        delegate?.sendData(data: data)
        dismiss(animated:true, completion: nil)
 */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! HistoryViewController
        view.dog = dog.dName
        /*
        view.dog.dYear = dog.dYear
        view.dog.dMonth = dog.dMonth
        view.dog.dDay = dog.dDay
        view.dog.dAge = dog.dAge
        view.dog.dDogAge = dog.dDogAge
        view.dog.dDogMonth = dog.dDogMonth
 */
    }
}

