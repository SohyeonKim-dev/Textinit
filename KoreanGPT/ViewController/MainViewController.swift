//
//  MainViewController.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private let guidingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "입력해주세요"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private var inputText: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .gray
        return textField
    }()
    
    private var outputText: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .gray
        return textField
    }()
    
    lazy var sendingToOpenAIButton: UIButton = {
        let button = UIButton()
        button.setTitle("OpenAI", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .yellow
        
        button.addTarget(self,
                         action: #selector(nextButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func nextButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [guidingTextLabel, inputText,outputText, sendingToOpenAIButton].forEach {
            view.addSubview($0)
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        guidingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        inputText.translatesAutoresizingMaskIntoConstraints = false
        outputText.translatesAutoresizingMaskIntoConstraints = false
        sendingToOpenAIButton.translatesAutoresizingMaskIntoConstraints = false
        
        guidingTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guidingTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2).isActive = true
        
        inputText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputText.topAnchor.constraint(equalTo: guidingTextLabel.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        
        outputText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outputText.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        
        sendingToOpenAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendingToOpenAIButton.topAnchor.constraint(equalTo: outputText.bottomAnchor, constant: view.bounds.height * 0.55).isActive = true
    }
    
}
