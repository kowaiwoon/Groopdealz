//
//  TextEditViewController.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 21.10.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

class TextEditViewController: UIViewController {
    
    static var helpersStoryboard:UIStoryboard = {
        return UIStoryboard(name: "Helpers", bundle: nil)
        }()
    
    static func create() -> TextEditViewController {
        return SelectionViewController.helpersStoryboard.instantiateViewController(withIdentifier: "TextEditViewController") as! TextEditViewController
    }
    
    var text:String? {
        didSet {
            if let textView = textView {
                textView.text = text
            }
        }
    }
    
    var textSaved:((String?)->())? = nil
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        text = textView.text
        if let textSaved = textSaved {
            textSaved(text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
        navigationItem.title = title
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}
