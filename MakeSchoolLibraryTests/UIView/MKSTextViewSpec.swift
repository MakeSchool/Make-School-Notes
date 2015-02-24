//
//  MKSTextViewSpec.swift
//  MakeSchoolNotes
//
//  Created by Benjamin Encz on 2/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Quick
import Nimble
import MakeSchoolLibrary

class MKSTextViewSpec: QuickSpec {
  override func spec() {
    var textView: MKSTextView!
    
    beforeEach {
    }
    
    describe("Provides text value") {
      it ("Returns empty text value when dislaying placeholder text") {
        textView = MKSTextView(frame: CGRectZero, textContainer: nil)
        textView.text = ""
        expect(textView.textValue).to(equal(""))
      }
    }
  }
}
