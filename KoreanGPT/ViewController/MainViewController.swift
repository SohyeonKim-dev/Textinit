//
//  MainViewController.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//

import UIKit
import MLKitTranslate

class MainViewController: UIViewController, UITextViewDelegate {
    
    private var mlKit = MLKitManager()
    @Published var inputKoreanWord: String = ""
    @Published var outputKoreanWord: String = ""
    
    private let guidingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "🪴 단어를 입력해주세요"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private var inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 18, weight: .regular)
    
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        return textField
    }()
    
    private var outputTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.darkGray.cgColor
        return textView
    }()
    
    lazy var sendingToOpenAIButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("OpenAI", for: .normal)
        button.layer.borderColor = UIColor.systemYellow.cgColor
        
        button.addTarget(self,
                         action: #selector(sendingToOpenAIButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func sendingToOpenAIButtonTapped() {
        
        self.inputKoreanWord = inputTextField.text as String? ?? ""
        mlKit.translatingKoreanToEnglish(text: inputKoreanWord)
        
        let inputEnglishWord = mlKit.resultEnglishText
        
        let jsonPayload = [
            "prompt": inputEnglishWord,
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
                self?.mlKit.translatinEnglishToKorean(text: str) {
                    self?.outputKoreanWord = self?.mlKit.resultKoreanText ?? ""
                    self?.outputTextView.text = self?.outputKoreanWord
                }
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mlKit.modelDownload()
        view.backgroundColor = .white
        
        [guidingTextLabel, inputTextField,outputTextView, sendingToOpenAIButton].forEach {
            view.addSubview($0)
        }
        
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        inputTextField.delegate = self
        outputTextView.delegate = self
    }
    
    private func configureConstraints() {
        guidingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        sendingToOpenAIButton.translatesAutoresizingMaskIntoConstraints = false
        
        guidingTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guidingTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.15).isActive = true
        
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: guidingTextLabel.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 330).isActive = true
        
        outputTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: view.bounds.height * 0.03).isActive = true
        outputTextView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        outputTextView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        
        // 복붙 버튼
        
        sendingToOpenAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendingToOpenAIButton.topAnchor.constraint(equalTo: outputTextView.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
    }
}

extension MainViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
         return false
     }
 }
