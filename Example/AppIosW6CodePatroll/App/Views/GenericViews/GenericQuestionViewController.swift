//
//  GenericQuestionViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class GenericQuestionViewController: UIViewController {
    
    private lazy var questionInput: AndesTextArea = .load() { element in
        element.label = "Escriba su pregunta"
        element.helper = "Su pregunta no puede contener informacion sensible"
        element.counter = 100
        element.placeholder = "¿Que medios de pago tiene?"
//        element.rightContent = AndesTextFieldComponentClear()
        view.addSubview(element)
    }
    
    private lazy var sendButton: AndesButton = {
        let btn = AndesButton(text: "Enviar pregunta", hierarchy: .loud, size: .large)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(sendQuestion), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    
    private lazy var message: AndesMessage = .load() { element in
        element.hierarchy = .loud
        element.isHidden = true
        element.isDismissable = true
        view.addSubview(element)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ml_meli_background()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            questionInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            sendButton.topAnchor.constraint(equalTo: questionInput.bottomAnchor, constant: 30),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            message.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            message.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            message.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func sendQuestion() {
        print(questionInput.text)
        message.type = .success
        message.title = "Su pregunta se envio al vendedor"
        message.isHidden = false
        questionInput.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.message.isHidden = true
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
