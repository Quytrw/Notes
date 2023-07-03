//
//  MainVC.swift
//  notes
//
//  Created by Mobile Dev on 29/06/2023.
//

import UIKit

class MainVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    let vm = ToDoViewModel.sharedInstance
    
    @IBAction func addButton(_ sender: Any){
        let vc = DetailVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    var data: [Task] = [
//        Task(name: "Task 1", time: Date()),
//        Task(name: "Task 2", time: Date()),
//        Task(name: "Task 3", time: Date()),
//        Task(name: "Task 4", time: Date()),
//        Task(name: "Task 5", time: Date()),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: TableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.data.removeAll()
        vm.loadTasks {
            tableView.reloadData()
        }
    }
    
    
    
    
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        let data = vm.tasks[indexPath.row]
        cell.titleLabel?.text = data.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        let timeString = dateFormatter.string(from: data.time)
        cell.timeLabel?.text = timeString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditVC.instantiate(viewModel: EditVM(vm.tasks[indexPath.row]))
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
