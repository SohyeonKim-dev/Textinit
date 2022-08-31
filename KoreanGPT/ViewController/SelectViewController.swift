//
//  SelectViewController.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/28.
//

import UIKit

class SelectViewController: UIViewController {
    
    private let appImageView: UIImageView = {
          let theImageView = UIImageView()
          theImageView.image = UIImage(named: "AppImage")
          return theImageView
       }()
    
    private let appTiTleLabel: UILabel = {
        let label = UILabel()
        label.text = "Textinit"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var koreanSettingButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("한국어", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor(named: "CustomWhite")?.cgColor
        
        button.addTarget(self,
                         action: #selector(koreanSettingButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func koreanSettingButtonTapped() {
                
    }
    
    lazy var englishSettingButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("영어", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor(named: "CustomWhite")?.cgColor
        
        button.addTarget(self,
                         action: #selector(englishSettingButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func englishSettingButtonTapped() {
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBlue")
        
        [appImageView, appTiTleLabel, koreanSettingButton, englishSettingButton].forEach {
            view.addSubview($0)
        }
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        appTiTleLabel.translatesAutoresizingMaskIntoConstraints = false
        koreanSettingButton.translatesAutoresizingMaskIntoConstraints = false
        englishSettingButton.translatesAutoresizingMaskIntoConstraints = false
        
        appImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.3).isActive = true
        
        appTiTleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appTiTleLabel.topAnchor.constraint(equalTo: appImageView.bottomAnchor, constant: view.bounds.height * 0.05).isActive = true
        
        koreanSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        koreanSettingButton.topAnchor.constraint(equalTo: appTiTleLabel.bottomAnchor, constant: view.bounds.height * 0.18).isActive = true
        
        englishSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        englishSettingButton.topAnchor.constraint(equalTo: koreanSettingButton.bottomAnchor, constant: view.bounds.height * 0.03).isActive = true
    }
}

// TODO: 영어, 한국어 모드 선택
// 버튼이 눌리면, 함수 변경하는 동작 구현
// 네비게이션 연결
