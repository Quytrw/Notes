//
//  TodoViewModel.swift
//  notes
//
//  Created by Mobile Dev on 29/06/2023.
//

import UIKit
import RealmSwift
import RxSwift

class Repository: NSObject{
    
    static var sharedInstance = Repository()
    
    var tasks = [Task]()
    
    typealias completionHandler = () -> Void
    
    let realm = try! Realm()
    
    func addTask(task: Task, completion: completionHandler){
        self.realm.beginWrite()
        
        self.realm.add(task)
        
        try! self.realm.commitWrite()
        
        completion()
        
    }
    
    func loadTasks(completion: completionHandler){
        self.realm.beginWrite()
        
        let savedTasks = self.realm.objects(Task.self)
        self.tasks.removeAll()
        self.tasks.append(contentsOf: savedTasks)
        
        try! self.realm.commitWrite()
        
        completion()
    }
    
    func editTask(task: Task, updatedTask: Task, completion: completionHandler){
        self.realm.beginWrite()
        
        self.realm.delete(task)
        self.realm.add(updatedTask)
        
        try! self.realm.commitWrite()
        completion()
    }
    
    func deleteTask(task: Task, taskIndex: Int) -> Observable<Bool> {
        self.realm.beginWrite()
        
        self.realm.delete(task)
        
        do {
            try self.realm.commitWrite()
            
            tasks.remove(at: taskIndex)
            
            return Observable.just(true)
        } catch {
            return Observable.just(false)
        }
    }
}
