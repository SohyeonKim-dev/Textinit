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
    
    private var outputTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = .gray
        return textView
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
                self?.outputTextView.text = str
                
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [guidingTextLabel, inputTextField,outputTextView, sendingToOpenAIButton].forEach {
            view.addSubview($0)
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        guidingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        sendingToOpenAIButton.translatesAutoresizingMaskIntoConstraints = false
        
        guidingTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guidingTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2).isActive = true
        
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: guidingTextLabel.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 340).isActive = true
        
        outputTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        outputTextView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        outputTextView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        
        sendingToOpenAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendingToOpenAIButton.topAnchor.constraint(equalTo: outputTextView.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
    }
    
}
