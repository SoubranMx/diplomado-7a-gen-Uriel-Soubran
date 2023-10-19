//
//  InfoViewController.swift
//  SecondFinal_RockPaperScissors
//
//  Created by Diplomado on 14/10/23.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var introductionParagraph: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 12
        label.text = "Rock, Paper, Scissors is a simple game. \nThe game consists of 3 buttons to select at each round: a paper, a rock and a scissor. Paper beats rock, rock beats scissors and scissors beat paper.\n\nOnce you select one button, the machine will choose a button too, you will earn points or win the round if you beat the machine's selected option."
        label.textColor = .label
        return label
    }()
    
    lazy var byPointsExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⚪️ By Points:"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var byRoundsExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⚪️ By Rounds:"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var byRoundsExplanationParagraph: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.text = "Move the slider to set the number of rounds you will play.\nThe game will finish once that number of rounds are met."
        return label
    }()
    
    lazy var byPointsExplanationParagraph: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 6
        label.text = "Select the ammount of points you earn per round win, how many points are discounted when you lose and how many points you need to earn to declare the game set."
        return label
    }()
    
    lazy var finalExplanationParagraph: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        label.text = "Once you select your name and fill all the fields for \"byPoints\" mode or you just select \"byRounds\" mode, a Play Button will appear at the bottom.\nIt's game time!"
        return label
    }()
    
    lazy var modalTitle: UILabel = {
        let modalTitle = UILabel()
        modalTitle.translatesAutoresizingMaskIntoConstraints = false
        modalTitle.text = "Game Rules"
        modalTitle.font = .systemFont(ofSize: 24, weight: .semibold)
        modalTitle.textColor = .label
        return modalTitle
    }()
    
    var paddingTopSections:CGFloat = 20;
    var paddingY:CGFloat = 8;
    var paddingX:CGFloat = 12;

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        self.title = "Game Rules"
        view.backgroundColor = .white
        view.addSubview(modalTitle)
        view.addSubview(introductionParagraph)
        view.addSubview(byRoundsExplanationLabel)
        view.addSubview(byRoundsExplanationParagraph)
        view.addSubview(byPointsExplanationLabel)
        view.addSubview(byPointsExplanationParagraph)
        view.addSubview(finalExplanationParagraph)
        NSLayoutConstraint.activate([
            modalTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingTopSections),
            modalTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            modalTitle.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            introductionParagraph.topAnchor.constraint(equalTo: modalTitle.bottomAnchor, constant: paddingTopSections),
            introductionParagraph.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            introductionParagraph.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            byRoundsExplanationLabel.topAnchor.constraint(equalTo: introductionParagraph.bottomAnchor, constant: paddingTopSections),
            byRoundsExplanationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            byRoundsExplanationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            byRoundsExplanationParagraph.topAnchor.constraint(equalTo: byRoundsExplanationLabel.bottomAnchor, constant: paddingY),
            byRoundsExplanationParagraph.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            byRoundsExplanationParagraph.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            byPointsExplanationLabel.topAnchor.constraint(equalTo: byRoundsExplanationParagraph.bottomAnchor, constant: paddingTopSections),
            byPointsExplanationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            byPointsExplanationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            byPointsExplanationParagraph.topAnchor.constraint(equalTo: byPointsExplanationLabel.bottomAnchor, constant: paddingY),
            byPointsExplanationParagraph.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            byPointsExplanationParagraph.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX),
            finalExplanationParagraph.topAnchor.constraint(equalTo: byPointsExplanationParagraph.bottomAnchor, constant: paddingTopSections),
            finalExplanationParagraph.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: paddingX),
            finalExplanationParagraph.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -paddingX)
        ])
    }
}
