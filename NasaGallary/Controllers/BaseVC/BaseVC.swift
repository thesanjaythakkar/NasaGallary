//
//  BaseVC.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBar(title: self.navigationItem.title ?? "")
        // Do any additional setup after loading the view.
    }
    
    func setBar(title:String) {
        let navLabel = AppLabel()
        navLabel.text = title
        navLabel.configureLabel()
        self.navigationItem.titleView = navLabel
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
