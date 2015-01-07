import Foundation

protocol TypeEngineDelegate {
    func typeEngine(TypeEngine, currentWordIsValid: Bool);
    func typeEngineStartedNewWord(TypeEngine)
    func typeEngineFinished(TypeEngine)
}

class TypeEngine {
    var delegate: TypeEngineDelegate?
    var words: [String]!
    var currentWordIndex: Int = 0

    init() {
        words = "This is some text that we should show the user whatever that might be it should be typed fast".componentsSeparatedByString(" ")
    }

    func updateCurrentInput(newWord: String) {
        if (currentWordIndex == words.count) {
            return
        }

        if (newWord.hasSuffix(" ")) {
            handleFinishedWord(newWord)
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

    func handleFinishedWord(word: String) {
        currentWordIndex++
        delegate?.typeEngineStartedNewWord(self)
        if (currentWordIndex == words.count) {
            delegate?.typeEngineFinished(self)
        }
    }
}