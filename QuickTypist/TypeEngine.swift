import Foundation

protocol TypeEngineDelegate {
    func typeEngine(TypeEngine, currentWordIsValid: Bool);
    func typeEngine(TypeEngine, newWordStarted: String);
}

class TypeEngine {
    var delegate: TypeEngineDelegate?
    var words: [String]!
    var currentWordIndex: Int = 0
    var fullText: String {
        return "This is some text that we should show the user whatever that might be it should be typed fast"
    }

    init() {
        words = fullText.componentsSeparatedByString(" ")
    }

    func updateCurrentInput(newWord: String) {
        if (newWord.hasSuffix(" ")) {
            currentWordIndex++
            delegate?.typeEngine(self, newWordStarted: words[currentWordIndex])
        } else {
            delegate?.typeEngine(self, currentWordIsValid: checkSpellingOfInputText(newWord))
        }
    }

    func checkSpellingOfInputText(text: String) -> Bool {
        if (words[currentWordIndex].hasPrefix(text)) {
            return true
        }

        return false
    }
}