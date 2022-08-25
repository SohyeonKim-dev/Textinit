//
//  MLKitManager.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//

import UIKit
import MLKitTranslate

class MLKitManager {
    
    public var resultKoreanText: String = ""
    public var resultEnglishText: String = ""
    
    private let koreanToEnglishTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .korean, targetLanguage: .english))
    
    private let englishToKoreanTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .english, targetLanguage: .korean))
    
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
            self.resultEnglishText = translatedText ?? ""
        }
    }
    
    func translatinEnglishToKorean(text: String, completion: @escaping () -> Void){
        englishToKoreanTranslator.translate(text) { [self] translatedText, error in
            self.resultKoreanText = translatedText ?? ""
            completion()
            
            // TODO: completion handler
        }
    }
}
