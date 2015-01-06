//
//  TypeViewController.swift
//  QuickTypist
//
//  Created by Mikael Hallendal on 06/01/15.
//  Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Foundation
import Cocoa

class TypeViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var timeLeftLabel: NSTextField!

    let typeEngine: TypeEngine

    init?(typeEngine: TypeEngine) {
        self.typeEngine = typeEngine
        super.init(nibName: "TypeViewController", bundle: NSBundle.mainBundle())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        inputField.delegate = self
    }

    override func controlTextDidChange(obj: NSNotification) {
        let text = inputField.stringValue

        if (!typeEngine.checkSpellingOfInputText(text)) {
            inputField.textColor = NSColor.redColor()
        } else {
            inputField.textColor = NSColor.blackColor()
        }
        println("New text: \(inputField.stringValue)")
    }
}