//
//  Buttons.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI
import MLCrossAppLinks

protocol ButtonsContainerDelegate {
    func questionAction()
}

class Buttons: UIView {

    var delegate: ButtonsContainerDelegate?
    
    private lazy var questionButton: AndesButton = {
        let btn = AndesButton(text: "Preguntar", hierarchy: .loud, size: .large)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(questionAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var wappButton: AndesButton = {
        let btn = AndesButton(text: "Comprar ahora", hierarchy: .loud, size: .large)
//        btn.icon = AndesButtonIcon(icon: UIImage(systemName: "paperclip")!, orientation: .left)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(goToMP), for: .touchUpInside)
        return btn
    }()
    
    private lazy var buttonStack: UIStackView = .load() { element in
        element.axis = .horizontal
        element.spacing = 9
        element.alignment = .center
        element.distribution = .fillEqually
    }
    
    private lazy var favButton: AndesButton = {
        let btn = AndesButton(text: "Agregar a favoritos", hierarchy: .transparent, size: .medium)
        btn.icon = AndesButtonIcon(icon: UIImage(systemName: "heart")!, orientation: .left)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var shareButton: AndesButton = {
        let btn = AndesButton(text: "Compartir", hierarchy: .transparent, size: .medium)
        btn.icon = AndesButtonIcon(icon: UIImage(systemName: "square.and.arrow.up")!, orientation: .left)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var linkStack: UIStackView = .load() { element in
        element.axis = .horizontal
        element.spacing = 0
        element.alignment = .center
        element.distribution = .equalCentering
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(questionButton)
        buttonStack.addArrangedSubview(wappButton)
        addSubview(linkStack)
        linkStack.addArrangedSubview(favButton)
        linkStack.addArrangedSubview(shareButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            linkStack.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            linkStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            linkStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -43)
        ])
    }
    
    @objc func questionAction() {
        delegate?.questionAction()
    }
    
    @objc func goToMP() {
        let link = Link(deeplink: "mercadopago://home", minAppTargetVersion: nil)
        DispatchLinkFactory.create().dispatch(link: link)
    }
}
