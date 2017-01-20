//
//  SelectionViewController.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 01.10.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var entries:[SelectableEntry] = []
    var selectedEntry:SelectableEntry? = nil
    
    var entrySelected:((SelectableEntry)->())? = nil
    
    static var helpersStoryboard:UIStoryboard = {
        return UIStoryboard(name: "Helpers", bundle: nil)
    }()

    static func create() -> SelectionViewController {
        return SelectionViewController.helpersStoryboard.instantiateViewController(withIdentifier: "SelectionViewController") as! SelectionViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entry-cell", for: indexPath) as! SelectionTableViewCell
        cell.checked = (entries[(indexPath as NSIndexPath).row].code == selectedEntry?.code)
        cell.titleLabel.text = entries[(indexPath as NSIndexPath).row].title
        
        if let entry = entries[(indexPath as NSIndexPath).row] as? ListingOptionValue , entry.isSoldOut {
            cell.soldOutLabel.isHidden = false
            cell.soldOutWidthConstraint.constant = 90
        } else {
            cell.soldOutLabel.isHidden = true
            cell.soldOutWidthConstraint.constant = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let entry = entries[(indexPath as NSIndexPath).row] as? ListingOptionValue , entry.isSoldOut {
            return
        }
        
        if let entrySelected = entrySelected {
            entrySelected(entries[(indexPath as NSIndexPath).row])
        }
    }

}
