import Foundation

protocol TypeEngineDelegate {
    func typeEngine(TypeEngine, currentWordIsValid: Bool);
    func typeEngineStartedNewWord(TypeEngine)
    func typeEngineFinished(TypeEngine)
    func typeEngine(TypeEngine, missSpelledRange:Range<Int>)
}

class TypeEngine {
    var delegate: TypeEngineDelegate?
    var text = "This is some text that we should show the user whatever that might be it should be typed fast"
    var words: [String]!
    var currentWordIndex: Int = 0
    var currentWordStart: String.Index

    init() {
        currentWordStart = text.startIndex
        words = text.componentsSeparatedByString(" ")
    }

    func updateCurrentInput(newWord: String) {
        if (currentWordIndex == words.count) {
            return
        }

        if (newWord.hasSuffix(" ")) {
            handleFinishedWord(newWord.substringWithRange(Range<String.Index>(start: newWord.startIndex, end: advance(newWord.startIndex, countElements(newWord) - 1))))
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
        if (word != words[currentWordIndex]) {
            delegate?.typeEngine(self, missSpelledRange:rangeOfCurrentWord())
        }

        let d = distance(text.startIndex, currentWordStart)
        let lengthForWordAndSpace = countElements(words[currentWordIndex]) + 1

        if d + lengthForWordAndSpace >= countElements(text) {
            delegate?.typeEngineFinished(self)
            return
        }

        currentWordStart = advance(currentWordStart, lengthForWordAndSpace)
        currentWordIndex++
        delegate?.typeEngineStartedNewWord(self)
        if (currentWordIndex == words.count) {
            delegate?.typeEngineFinished(self)
        }
    }

    func rangeOfCurrentWord() -> Range<Int> {
        let startIndex = distance(text.startIndex, currentWordStart)

        return Range<Int>(start: startIndex, end: startIndex + countElements(words[currentWordIndex]))
    }
}