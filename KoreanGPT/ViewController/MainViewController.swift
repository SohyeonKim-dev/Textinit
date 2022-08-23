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
    
    private var inputTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .gray
        return textField
    }()
    
    private var outputTextField: UITextField = {
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
                         action: #selector(sendingToOpenAIButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func sendingToOpenAIButtonTapped() {
        let jsonPayload = [
            "prompt": inputTextField.text ?? "",
            "max_tokens": 200
        ] as [String : Any]
        
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .darkGray
        view.alpha = 0.8
        self.view.addSubview(view)
        let spinner = UIActivityIndicatorView(frame: self.view.bounds)
        spinner.color = .lightGray
        self.view.addSubview(spinner)
        spinner.startAnimating()
        
        OpenAIManager.shared.makeRequest(json: jsonPayload) { [weak self] (str) in
            DispatchQueue.main.async {
                self?.outputTextField.text = str
                
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [guidingTextLabel, inputTextField,outputTextField, sendingToOpenAIButton].forEach {
            view.addSubview($0)
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        guidingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        outputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendingToOpenAIButton.translatesAutoresizingMaskIntoConstraints = false
        
        guidingTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guidingTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2).isActive = true
        
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: guidingTextLabel.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        
        outputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outputTextField.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        
        sendingToOpenAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendingToOpenAIButton.topAnchor.constraint(equalTo: outputTextField.bottomAnchor, constant: view.bounds.height * 0.55).isActive = true
    }
    
}
