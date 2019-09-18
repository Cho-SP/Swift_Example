//
//  HistoryViewController.swift
//  dogInfo
//
//  Created by RIHOZ on 10/09/2019.
//  Copyright © 2019 RIHOZ. All rights reserved.
//

import Foundation
import UIKit

protocol DataForm {
    var dName:String { get set }
    var dYear:String { get set }
    var dMonth:String { get set }
    var dDay:String { get set }
    var dAge:String { get set }
    var dDogAge:String{ get set }
    var dDogMonth:String { get set }
}
struct dogData: DataForm, Codable{
    var dName:String
    var dYear:String
    var dMonth:String
    var dDay:String
    var dAge:String
    var dDogAge:String
    var dDogMonth:String
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
class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var dogTableView: UITableView!
    
    var history = dogData() // history를 출력할 때 사용하는 인스턴스
    var dog:String = "Error" // 배열에 저장하기 전 잠깐 거치는 변수
    var dogs = [String]() // 반려견의 이름을 저장하는 배열
    var counter:Int = 0
    let cellId = "FirstCell"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dogSet()
        dogTableView.dataSource = self
        dogTableView.delegate = self
        dogTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dogs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPath = indexPath.row
        guard let vc = self.navigationController?.viewControllers[0] as? ViewController else{
            return
        }
        print("\(dogs[selectedPath]) is selected")
        var j = 1
        while(j<=UserDefaults.standard.object(forKey:"dCount") as? Int ?? 1){
            if(dogs[selectedPath] == UserDefaults.standard.string(forKey: "dName_"+String(j))){
                history.dName = UserDefaults.standard.string(forKey: "dName_"+String(j)) ?? "Error"
                history.dYear = UserDefaults.standard.string(forKey: "dYear_"+String(j)) ?? "Error"
                history.dMonth = UserDefaults.standard.string(forKey: "dMonth_"+String(j)) ?? "Error"
                history.dDay = UserDefaults.standard.string(forKey: "dDay_"+String(j)) ?? "Error"
                history.dAge = UserDefaults.standard.string(forKey: "dAge_"+String(j)) ?? "Error"
                history.dDogMonth = UserDefaults.standard.string(forKey: "dDogMonth_"+String(j)) ?? "Error"
                history.dDogAge = UserDefaults.standard.string(forKey: "dDogAge_"+String(j)) ?? "Error"
            }
            j += 1
        }
        vc.dogResult.text = """
        이름 : \(history.dName)\n
        생일 : \(history.dYear)년 \(history.dMonth)월 \(history.dDay)일\n
        한국 나이 : \(history.dAge)세\n
        강아지 나이 : \(history.dDogMonth)개월 (\(history.dDogAge)세)\n
        ※ 강아지 나이는 개월수x7을 기준으로 합니다.
        """
        self.navigationController?.popViewController(animated: true)
    }

    func dogSet(){ // dog에 반려견의 이름을 넣고 dogs 배열에 반려견의 이름을 저장
        counter = UserDefaults.standard.object(forKey: "dCount") as? Int ?? 1
        var i = 1
        while(i<counter+1){
            dog = UserDefaults.standard.string(forKey: "dName_"+String(i)) ?? "Error"
            /*
            dog.dYear = UserDefaults.standard.string(forKey: "dYear_"+String(i)) ?? "Error"
            dog.dMonth = UserDefaults.standard.string(forKey: "dMonth_"+String(i)) ?? "Error"
            dog.dDay = UserDefaults.standard.string(forKey: "dDay_"+String(i)) ?? "Error"
            dog.dAge = UserDefaults.standard.string(forKey: "dAge_"+String(i)) ?? "Error"
            dog.dDogMonth = UserDefaults.standard.string(forKey: "dDogMonth_"+String(i)) ?? "Error"
            dog.dDogAge = UserDefaults.standard.string(forKey: "dDogAge_"+String(i)) ?? "Error"
 */
            if(dog != "Error"){
                dogs.append(dog)
            }
            i += 1
        }
    }
}
