//
//  TestViewController.swift
//  dogInfo
//
//  Created by RIHOZ on 20/09/2019.
//  Copyright © 2019 RIHOZ. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    //-------------------------------------------------|
    
    // MARK: - Instance Properties
    
    // MARK: - IB Properties
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareToShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(YES)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Custom Functions
    func prepareToShow() {
        
    }
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - Delegate Functions
    
    //-------------------------------------------------|
    
    //-------------------------------------------------|
    
    // MARK: - IB Functions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: YES);
    }
    
    //-------------------------------------------------|
    
}
