//
//  EnglishTextViewController.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/31.
//

import UIKit
import MLKitTranslate

class EnglishTextViewController: UIViewController, UITextViewDelegate {
    
    private var mlKit = MLKitManager()
    @Published var inputKoreanWord: String = ""
    @Published var outputKoreanWord: String = ""

    private let guidingTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a word"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 18, weight: .regular)
    
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "CustomBlue")?.cgColor
        return textField
    }()
    
    private var outputTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor(named: "CustomBlue")?.cgColor
        return textView
    }()
    
    lazy var outputCopyButton: UIButton = {

        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .medium)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.baseForegroundColor = .black
        buttonConfiguration.imagePadding = 3
        
        let button: UIButton = UIButton()
        button.alpha = 0.85
        button.configuration = buttonConfiguration
        button.setImage(UIImage(systemName: "rectangle.portrait.on.rectangle.portrait", withConfiguration: imageConfiguration), for: .normal)
        
        button.addTarget(self,
                         action: #selector(outputCopyButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func outputCopyButtonTapped() {
        UIPasteboard.general.string = outputTextView.text
        
        let alertController = UIAlertController(title: "",
                                                message: "Copy to clipboard!",
                                                preferredStyle: .actionSheet)
        present(alertController, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    lazy var sendingToOpenAIButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("OpenAI", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor(named: "CustomBlue")?.cgColor
        
        button.addTarget(self,
                         action: #selector(englishGPTButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func englishGPTButtonTapped() {
        
        let inputEnglishWord = inputTextField.text as String? ?? ""
        
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
                self?.outputTextView.text = str
                spinner.stopAnimating()
                spinner.removeFromSuperview()
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mlKit.modelDownload()
        view.backgroundColor = UIColor(named: "CustomWhite")
        
        [guidingTextLabel, inputTextField, outputTextView, outputCopyButton, sendingToOpenAIButton].forEach {
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
        outputCopyButton.translatesAutoresizingMaskIntoConstraints = false
        sendingToOpenAIButton.translatesAutoresizingMaskIntoConstraints = false
        
        guidingTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guidingTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.18).isActive = true
        
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: guidingTextLabel.bottomAnchor, constant: view.bounds.height * 0.04).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.80).isActive = true
        
        outputTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: view.bounds.height * 0.03).isActive = true
        outputTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.80).isActive = true
        outputTextView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        
        outputCopyButton.centerXAnchor.constraint(equalTo: outputTextView.rightAnchor, constant: -40).isActive = true
        outputCopyButton.topAnchor.constraint(equalTo: outputTextView.bottomAnchor, constant: -60).isActive = true
        
        sendingToOpenAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendingToOpenAIButton.topAnchor.constraint(equalTo: outputTextView.bottomAnchor, constant: view.bounds.height * 0.03).isActive = true
        
        // TODO: 비율로 조정
    }
}

extension EnglishTextViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
         return false
     }
 }

