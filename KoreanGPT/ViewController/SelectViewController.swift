//
//  SelectViewController.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/28.
//

import UIKit

class SelectViewController: UIViewController {
    
    let appImage : UIImage = {
        let image = UIImage(named: "appImage")
        // image file 넣기
        return image ?? UIImage()
    }()
    
    lazy var koreanSettingButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("한국어", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor(named: "CustomWhite")?.cgColor
        
//        button.addTarget(self,
//                         action: #selector(sendingToOpenAIButtonTapped),
//                         for: .touchUpInside)
        return button
    }()
    
    lazy var englishSettingButton: UIButtonExtension = {
        let button = UIButtonExtension()
        button.setTitle("영어", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor(named: "CustomWhite")?.cgColor
        
//        button.addTarget(self,
//                         action: #selector(sendingToOpenAIButtonTapped),
//                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBlue")
        
        [koreanSettingButton, englishSettingButton].forEach {
            view.addSubview($0)
        }
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        koreanSettingButton.translatesAutoresizingMaskIntoConstraints = false
        englishSettingButton.translatesAutoresizingMaskIntoConstraints = false
        
        koreanSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        koreanSettingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.65).isActive = true
        
        englishSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        englishSettingButton.topAnchor.constraint(equalTo: koreanSettingButton.bottomAnchor, constant: view.bounds.height * 0.03).isActive = true
    }
}

// TODO: 영어, 한국어 모드 선택
// 버튼이 눌리면, 함수 변경하는 동작 구현
