//
//  MLKitManager.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//

import UIKit
import MLKitTranslate

class MLKitManager {
    
    private let koreanToEnglishTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .korean, targetLanguage: .english))
    
    private let englishToKoreanTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .english, targetLanguage: .korean))
    
    private var resultText: String = ""
    
    func modelDownload() {
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true)
        
        koreanToEnglishTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
        }
        
        englishToKoreanTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
        }
    }
    
    func translatingKoreanToEnglish(text: String) {
        koreanToEnglishTranslator.translate(text) { translatedText, error in
            guard error == nil, let resultText = translatedText else { return }
        }
    }
    
    func translatinEnglishToKorean(text: String){
        englishToKoreanTranslator.translate(text) { translatedText, error in
            guard error == nil, let resultText = translatedText else { return }
        }
    }
}
