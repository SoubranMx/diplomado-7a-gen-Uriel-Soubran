//
//  CaptionedImage.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 13/10/23.
//

import UIKit

class CaptionedImage: UIView {
    //esto define que es lo que tiene el XID
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //con xids, necesitamos inicializar los elementos o crashea cuando intentas acceder a los outlets
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //este es unico para interface builder
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        //las vistas en xid se cargan lazy
        
        //second way: programaticamente
        guard let contentView = Bundle.main.loadNibNamed("CaptionedImage", owner: self)?.first as? UIView else {return}
        
//        First way: con iboutlet contentView
//        Bundle.main.loadNibNamed("CaptionedImage", owner: self)
        addSubview(contentView)
        //para hacerle saber al compilador que nosotros ponemos los constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }

}
