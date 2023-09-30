//
//  ShareModalViewController.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 29/09/23.
//

import UIKit

class ShareModalViewController: UIViewController {
    
    @IBOutlet weak var textViewField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSendButtonClicked(_ sender: UIButton) {
        guard let textBox = textViewField.text else {return}
        print(textBox)
    }
}
