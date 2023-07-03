//
//  BaseVC.swift
//  course3
//
//  Created by Tam Le on 03/07/2023.
//

import UIKit
import RxSwift

class BaseVC<VM: BaseVM>: UIViewController {
    
    var viewModel: VM!
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        bindViewModel()
    }
    
    open func initViews() { }
    
    open func configureListView() { }
    
    open func addEventForViews() { }
    
    open func bindViewModel() { }
}

extension BaseVC {
    static func instantiate(viewModel: BaseVM) -> Self {
        let vc = self.init()
        if let viewModel = viewModel as? VM {
            vc.viewModel = viewModel
        } else {
            fatalError("View model wrong type or null")
        }
        return vc
    }
    
    static func instantiate(nibName: String) -> Self {
        func instantiateFromNib<T: UIViewController>(nibName: String) -> T {
            return T.init(nibName: String(describing: nibName), bundle: nil)
        }
        
        return instantiateFromNib(nibName: nibName)
    }
}
