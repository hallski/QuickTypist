import Foundation

public struct DoneWord {
    enum State {
        case Success
        case Failure
    }

    let state: State
    let word: String

    init(_ string: String, correctString: String) {
        word = correctString
        state = checkSpelling(string, correctString) ? .Success : .Failure
    }
}

public struct TypeData {
    let finishedWords: [DoneWord] = []
    let comingWords: [String]
    let currentWord: String = ""
    let currentWordCorrect: Bool = false

    init (words: [String]) {
        self.comingWords = words
    }

    init (finishedWords: [DoneWord], comingWords: [String], currentWord: String, currentWordCorrect: Bool) {
        self.finishedWords = finishedWords
        self.comingWords = comingWords
        self.currentWord = currentWord
        self.currentWordCorrect = currentWordCorrect
    }

    var isDone: Bool {
        return comingWords == []
    }
}

public func processInput(input: String, data: TypeData) -> TypeData {
    if (data.comingWords == []) {
        return data;
    }

    if (input.hasSuffix(" ")) {
        var finishedWords = data.finishedWords
        var comingWords = data.comingWords

        finishedWords += [DoneWord(input.stringByReplacingOccurrencesOfString(" ", withString: ""), correctString: comingWords[0])]
        comingWords.removeAtIndex(0)

        return TypeData(finishedWords: finishedWords, comingWords: comingWords, currentWord: "", currentWordCorrect: false)
    } else {
        return TypeData(finishedWords: data.finishedWords, comingWords: data.comingWords, currentWord: input, currentWordCorrect: checkSpelling(input, data.comingWords[0]))
    }
}

func checkSpelling(input: String, word: String) -> Bool {
    return word.hasPrefix(input)
}