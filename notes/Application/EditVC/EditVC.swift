//
//  EditVC.swift
//  notes
//
//  Created by Mobile Dev on 29/06/2023.
//

import UIKit

class EditVC: BaseVC<EditVM> {

    @IBOutlet weak var nameTaskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
//    let vm = ToDoViewModel.sharedInstance
    
    var task: Task?
    var index: Int?
    
    init(_ task: Task){
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func initViews() {
        super.initViews()
        
        //set default data
        //color, background, corner, border
    }
    
    override func configureListView() {
        super.configureListView()
        //tableView.delete = self
        
        //collectionView.dataSource = self
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.dataS
            .asObservable()
            .subscribe(onNext: {[weak self] task in
                guard let self = self else { return }
                self.nameTaskTextField.text =  task.name
                self.datePicker.date = task.time
            }).disposed(by: bag)
        
        viewModel.deleteSuccessS
            .asObservable()
            .subscribe(onNext: {[weak self] isSuccess in
                guard let self = self else { return }
                navigationController?.popViewController(animated: true)
            }).disposed(by: bag)
    }
    
    @IBAction func saveButton(_ sender: Any){
        
        let newTask = Task(name: nameTaskTextField.text ?? "", time: datePicker.date)
        
//        vm.editTask(task: self.task!, updatedTask: newTask) {
//            navigationController?.popViewController(animated: true)
//        }
    }
    
    @IBAction func deleteButton(_ sender: Any){
        viewModel.delete()
    }
}
