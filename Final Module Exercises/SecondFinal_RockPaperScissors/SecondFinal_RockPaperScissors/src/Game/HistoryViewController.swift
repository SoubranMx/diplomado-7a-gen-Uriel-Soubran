//
//  HistoryViewController.swift
//  SecondFinal_RockPaperScissors
//
//  Created by Uriel Soubran on 19/10/23.
//

import UIKit

class HistoryViewController: UIViewController {

    var outsideHistoryText = String();
    var outsideModalTitle = String();
    @IBOutlet weak var modalTitle: UILabel!
    @IBOutlet weak var historyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTitle.text = outsideModalTitle;
        historyTextView.text = outsideHistoryText;
    }
}
