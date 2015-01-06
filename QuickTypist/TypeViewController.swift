//
//  TypeViewController.swift
//  QuickTypist
//
//  Created by Mikael Hallendal on 06/01/15.
//  Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Foundation
import Cocoa

class TypeViewController: NSViewController, NSTextFieldDelegate, TypeEngineDelegate {
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var timeLeftLabel: NSTextField!

    let typeEngine: TypeEngine

    init?(typeEngine: TypeEngine) {
        self.typeEngine = typeEngine
        super.init(nibName: "TypeViewController", bundle: NSBundle.mainBundle())

        typeEngine.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        inputField.delegate = self
        textView.insertText(typeEngine.fullText)
    }

    override func controlTextDidChange(obj: NSNotification) {
        typeEngine.updateCurrentInput(inputField.stringValue)
    }

    func typeEngine(TypeEngine, currentWordIsValid: Bool) {
        inputField.textColor = currentWordIsValid ? NSColor.blackColor() : NSColor.redColor()
    }

    func typeEngine(TypeEngine, newWordStarted: String) {
        inputField.stringValue = ""
    }
}