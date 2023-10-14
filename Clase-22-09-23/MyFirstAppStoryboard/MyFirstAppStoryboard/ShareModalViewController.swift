//
//  ShareModalViewController.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 29/09/23.
//

import UIKit

class ShareModalViewController: UIViewController {
    
//    @IBOutlet weak var wordCountLabel: UILabel!
    
//    private lazy var wordCountLabel: UILabel = {
//        let labelView = UILabel()
//        labelView.delegate = self
//        return labelView
//    }
    
    private lazy var textViewField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var shareButton: UIButton = {
//        previo a ios 14.0
//        let button  = UIButton()
//        button.setTitle("Share", for: .normal)
//        button.addTarget(self, action: #selector(onSendButtonClicked), for: .touchUpInside)
//        after ios 14.0
        let action = UIAction(title: "Share") { [weak self] _ in
            self?.onSendButtonClicked() //es opcional por el weak
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let maxWordCount = 150
    
    private func setElements(){
        view.addSubview(textViewField)
        view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            textViewField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textViewField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            textViewField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20), //-20 porque textViewField, con respecto a view, esta a 20 ... pero de la vista se mueve hacia la izquierda, negativo.
            textViewField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            shareButton.topAnchor.constraint(equalTo: textViewField.bottomAnchor, constant: 20),
            shareButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
     @objc func onSendButtonClicked() {
//         guard let textBox = textViewField.text else {return}
         print(textViewField.text ?? "")
     }
    //Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // create a border for a view (TextView in this case)
        view.backgroundColor = .systemMint
        setElements()
//        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
//        textViewField.layer.borderWidth = 0.5
//        textViewField.layer.borderColor = borderColor.cgColor
//        textViewField.layer.cornerRadius = 5.0
        
        //set wordCountLabel first state
//        wordCountLabel.text = "0 / 150"
    }

//    Aplicar una acción cuando el botón de share se oprime.
//    @IBAction func onSendButtonClicked(_ sender: UIButton) {
//        guard let textBox = textViewField.text else {return}
//        print(textBox)
//    }
}

//delegates
extension ShareModalViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        wordCountLabel.text = "\(textView.text.count) / \(maxWordCount)"
//    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "" {return true}
        return (textView.text?.count ?? 0) + text.count - range.length <= maxWordCount
    }
}
