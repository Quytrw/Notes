//
//  DetailVC.swift
//  notes
//
//  Created by Mobile Dev on 29/06/2023.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButton(_ sender: Any){
        
        let task = Task(name: taskNameTextField.text ?? "", time: datePicker.date)
        
        let vm = ToDoViewModel.sharedInstance
        vm.addTask(task: task) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
