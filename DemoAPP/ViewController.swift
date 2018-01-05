//
//  ViewController.swift
//  DemoAPP
//
//  Created by apple on 04/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet var dynamicTableView: UITableView!
    @IBOutlet var headerViewHeight: NSLayoutConstraint!
    @IBOutlet var headerView: UIView!
    @IBOutlet var baseViewHeightCons: NSLayoutConstraint!
    @IBOutlet var baseView: UIView!
    
    // MARK:- Variables
    var namesArray = ["Name --1","Name --2","Name --3","Name --4","Name --5"]
    var dynamicHeight = CGFloat()
    var defaultHeaderViewHeight = CGFloat()
    var defaultBaseViewHeight = CGFloat()
    
    // MARK:- View LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultHeaderViewHeight = self.headerViewHeight.constant
        defaultBaseViewHeight = self.baseViewHeightCons.constant
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK:- Button Actions
    @IBAction func addName(_ sender: Any) {
        showAddOrEditNameAlert(false, 0)

    }
    @IBAction func trash(_ sender: Any) {
    
        if namesArray.count > 1 {
            namesArray.removeLast()
            dynamicTableView.reloadData()
        }
    }
  
    // MARK:- Private Methods
    func updateBaseViewHeight() {
        // change the view height if tableview content height less than actual height
        
        if defaultBaseViewHeight > dynamicHeight {
            self.baseViewHeightCons.constant = dynamicHeight
        } else {
            self.baseViewHeightCons.constant = defaultBaseViewHeight
        }
    }
    func showAddOrEditNameAlert(_ isEdit: Bool, _ rowIndex: Int) {
        var titleString = "Enter Any name"
        if isEdit {
            titleString = "Edit Name"
        }
        let alertController = UIAlertController(title: titleString, message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            (_) in
            let textField = alertController.textFields![0] as UITextField

            if textField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
                if isEdit {
                    self.namesArray[rowIndex] = textField.text!
                } else {
                    self.namesArray.append(textField.text!)
                }
                self.dynamicTableView.reloadData()
            } else {
                return
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: { (textField : UITextField) in
            if isEdit {
                textField.text = self.namesArray[rowIndex]
            } else {
                textField.placeholder = "Enter Any Name"
            }
        })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: false, completion: nil)
    }
}
// MARK:- TableView Datasource methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleLbl?.text = namesArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (dynamicTableView.indexPathsForVisibleRows?.last)?.row {
            dynamicHeight = dynamicTableView.contentSize.height + defaultHeaderViewHeight
            updateBaseViewHeight()
        }
    }
}
// MARK:- TableView Delegate methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let alertController = UIAlertController(title: "Are you sure you want to delete name", message: "", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Yes", style: .default, handler: {
                (_) in
                self.namesArray.remove(at: indexPath.row)
                self.dynamicTableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: false, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAddOrEditNameAlert(true, indexPath.row)
    }
}
