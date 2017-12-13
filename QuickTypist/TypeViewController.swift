import Foundation
import Cocoa

func collectAttributedStringFromCurrentTypeData(_ data: TypeData) -> NSAttributedString {
    let string = NSMutableAttributedString()
    let aStrings = data.finishedWords.map({ (doneWord: DoneWord) -> NSAttributedString in
        NSAttributedString(string: doneWord.word,
                attributes: [NSForegroundColorAttributeName : doneWord.state == .Success ? NSColor.green : NSColor.red])
    })

    for s in aStrings {
        string.append(s)
        string.append(NSAttributedString(string: " "))
    }

    string.append(NSAttributedString(string: data.comingWords.joined(separator: " ")))

    return string
}

class TypeViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var timeLeftLabel: NSTextField!

    var currentTypeData: TypeData

    init?(_ words: [String]) {
        self.currentTypeData = TypeData(words: words)
        super.init(nibName: "TypeViewController", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        inputField.delegate = self
        updateWithNewTypeData()
    }

    override func viewDidAppear() {
        inputField.becomeFirstResponder()
    }

    override func controlTextDidChange(_ obj: Notification) {
        currentTypeData = processInput(inputField.stringValue, data: currentTypeData)
        updateWithNewTypeData()
    }

    func updateWithNewTypeData() -> () {
        if (currentTypeData.isDone) {
            print("Done!")
        }

        inputField.textColor = currentTypeData.currentWordCorrect ? NSColor.black : NSColor.red
        inputField.stringValue = currentTypeData.currentWord

        textView.textStorage?.setAttributedString(collectAttributedStringFromCurrentTypeData(currentTypeData))
    }
}
