//
//  EditVM.swift
//  notes
//
//  Created by Mobile Dev on 03/07/2023.
//

import RxSwift

class EditVM: BaseVM {
    
    let dataS: PublishSubject<Task> = PublishSubject()
    let deleteSuccessS: PublishSubject<Bool> = PublishSubject()
    
    var task: Task
    
    let respository = Repository.sharedInstance
    
    init(_ task: Task){
        self.task = task
        super.init()
    }
    
    func fetchData() {
        dataS.onNext(task)
    }
    
    func delete() {
        respository.deleteTask(task: task, taskIndex: 0)
            .subscribe(onNext: {[weak self] isSuccess in
                guard let self = self else { return }
                deleteSuccessS.onNext(isSuccess)
            }).disposed(by: bag)
    }
    
}
