//
//  ViewController.swift
//  AttributedImageText
//
//  Created by MAC on 5/6/9.
//  Copyright © 209 MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    let fullString = "Your costs for covered services could include a deductible, plus copays or coinsurance "
    let stringToColor = "deductible, plus copays or coinsurance"
    var rangeColor:NSRange!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rangeColor = (fullString as NSString).range(of: stringToColor)
        textView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // create an NSMutableAttributedString that we'll append everything to
        
        
        let attributedString = NSMutableAttributedString(string: fullString)
        attributedString.addAttribute(NSAttributedString.Key.link, value: URL(string: "_") as Any , range: rangeColor)
        
        let imageAttachment = CustomTextAttachment()
        let image = UIImage(named: "cardiogram")
        imageAttachment.image = image
        
        // wrap the attachment in its own attributed string so we can append it
        let imageString = NSAttributedString(attachment: imageAttachment)
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        attributedString.append(imageString)
        
        // draw the result in a label
        textView.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if characterRange == rangeColor{
            print("Move to next VC")
        }
        return false
    }

}

class CustomTextAttachment:NSTextAttachment{
    @objc override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        return CGRect(x: 0.0, y: -5.0, width: self.image?.size.width ?? 0.0, height: self.image?.size.height ?? 0.0)
    }
}
