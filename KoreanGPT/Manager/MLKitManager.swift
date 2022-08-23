//
//  MLKitManager.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//

import UIKit
import MLKit
import MLKitTranslate

class MLKitManager {

    let englishToKoreanTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .english, targetLanguage: .korean))

    let koreanToEnglishTranslator = Translator.translator(options: TranslatorOptions(sourceLanguage: .korean, targetLanguage: .english))
    
    func download() {
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        englishToKoreanTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
        }
        koreanToEnglishTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
        }
        
        englishToKoreanTranslator.translate("text") { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }

            // Translation succeeded.
        }
    }
}
