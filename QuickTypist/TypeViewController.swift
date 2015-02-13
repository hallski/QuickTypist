import Foundation
import Cocoa

func collectAttributedStringFromCurrentTypeData(data: TypeData) -> NSAttributedString {
    var string = NSMutableAttributedString()
    let aStrings = data.finishedWords.map({ (doneWord: DoneWord) -> NSAttributedString in
        NSAttributedString(string: doneWord.word,
                attributes: [NSForegroundColorAttributeName : doneWord.state == .Success ? NSColor.greenColor() : NSColor.redColor()])
    })

    for s in aStrings {
        string.appendAttributedString(s)
        string.appendAttributedString(NSAttributedString(string: " "))
    }

    string.appendAttributedString(NSAttributedString(string: " ".join(data.comingWords)))

    return string
}

class TypeViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var timeLeftLabel: NSTextField!

    var currentTypeData: TypeData

    init?(_ words: [String]) {
        self.currentTypeData = TypeData(words: words)
        super.init(nibName: "TypeViewController", bundle: NSBundle.mainBundle())
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

    override func controlTextDidChange(obj: NSNotification) {
        currentTypeData = processInput(inputField.stringValue, currentTypeData)
        updateWithNewTypeData()
    }

    func updateWithNewTypeData() -> () {
        if (currentTypeData.isDone) {
            println("Done!")
        }

        inputField.textColor = currentTypeData.currentWordCorrect ? NSColor.blackColor() : NSColor.redColor()
        inputField.stringValue = currentTypeData.currentWord

        textView.textStorage?.setAttributedString(collectAttributedStringFromCurrentTypeData(currentTypeData))
    }
}