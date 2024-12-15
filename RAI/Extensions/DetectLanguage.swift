//
//  DetectLanguage.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 15/12/2024.
//

import Foundation
import NaturalLanguage

func detectLanguage(for text: String) -> Language? {
    let recognizer = NLLanguageRecognizer()
    recognizer.processString(text)
    if let language = recognizer.dominantLanguage {
        if(language.rawValue == "en") {
            return .english
        } else {
            return .albanian
        }
    }
    return nil
}
