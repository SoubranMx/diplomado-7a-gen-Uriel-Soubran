//
//  ShareModalViewController.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 29/09/23.
//

import UIKit

class ShareModalViewController: UIViewController {
    
    @IBOutlet weak var textViewField: UITextView! {
        didSet {
            textViewField.delegate = self
        }
    }
    @IBOutlet weak var wordCountLabel: UILabel!
    
    let maxWordCount = 150
    
    //Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // create a border for a view (TextView in this case)
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        textViewField.layer.borderWidth = 0.5
        textViewField.layer.borderColor = borderColor.cgColor
        textViewField.layer.cornerRadius = 5.0
        
        //set wordCountLabel first state
        wordCountLabel.text = "0 / 150"
    }

//    Aplicar una acción cuando el botón de share se oprime.
    @IBAction func onSendButtonClicked(_ sender: UIButton) {
        guard let textBox = textViewField.text else {return}
        print(textBox)
    }
}

//delegates
extension ShareModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        wordCountLabel.text = "\(textView.text.count) / \(maxWordCount)"
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "" {return true}
        return (textView.text?.count ?? 0) + text.count - range.length <= maxWordCount
    }
}
