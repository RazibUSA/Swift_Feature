//
//  Validator.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 4/11/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import Foundation

protocol InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool
}

struct TextField {
    var text: String
    var displayMessage: String = ""
    var validator: InputValidator
    
    init(text: String, validator: InputValidator) {
        self.text = text
        self.validator = validator
    }
    
    
    mutating func validate() -> Bool {
        
       return  validator.validateInput(with: text, message: &displayMessage)
       
    }
}

enum ValidationType {
    case passwordValidation
    case emailValidation
    
    var instance: InputValidator {
        switch self {
        case .passwordValidation: return PasswordInputValidator()
        case .emailValidation: return emailInputValidator()
        }
    }
}

struct PasswordInputValidator:  InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        var lowerCaseLetter: Bool = false
        var upperCaseLetter: Bool = false
        var digit: Bool = false
        var specialCharacter: Bool = false
        
        if text.count  >= 8 {
            for char in text.unicodeScalars {
                if !lowerCaseLetter {
                    lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
                }
                if !upperCaseLetter {
                    upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
                }
                if !digit {
                    digit = CharacterSet.decimalDigits.contains(char)
                }
                if !specialCharacter {
                    specialCharacter = CharacterSet.punctuationCharacters.contains(char)
                }
            }
            
            let checkList = [digit, upperCaseLetter, specialCharacter, lowerCaseLetter]
            if let index = checkList.index(where: { !$0 }) {
                print("\(index) is false")
                switch index {
                case 0:
                     message = ValidationMessage.noDigitFound.rawValue
                case 1:
                    message = ValidationMessage.atleastOneUpperCaseLetter.rawValue
                case 2:
                    message = ValidationMessage.atleastOneSpecialCaseLetter.rawValue
                case 3:
                    message = ValidationMessage.atleastOneLowerCaseLetter.rawValue
                default:
                    message = ValidationMessage.correct.rawValue
                }
                return false
            } else {
                 message = ValidationMessage.correct.rawValue
                 return true
            }
        } else {
            message = ValidationMessage.atleastEightChars.rawValue
            return false
        }
       
    }
}

struct emailInputValidator:  InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        if regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) != nil {
            
            return true
        } else {
            return false
        }
        
    }
    
}

struct matchInputValidator:  InputValidator {
    func validateInput(with text: String, message: inout String) -> Bool {
        return true
    }
}

enum ValidationMessage : String {
    case emptyField = "Fields cannot be empty"
    case invalidEmail = "Invalid email addresses"
    case atleastEightChars = "Atleast 8 Characters Lenght"
    case atleastOneUpperCaseLetter = "Atleast 1 uppercase letter"
    case atleastOneLowerCaseLetter = "Atleast 1 lowercase letter"
    case atleastOneSpecialCaseLetter = "Atleast 1 special character[Valid: !@#$%^&*]"
    case invalidPassword = "Minimum 8 - 255 Characters with 1 upper, lower, digit & special symbol"
    case noDigitFound = "Must have 1 digit"
    case correct = "Correct"
}
