//
//  MykiRouter.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/8/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

protocol MykiRouter {
    func push(_ vc: MykiViewControllers)
    func present(_ vc: MykiViewControllers)
    func popView()
    func dismissView()
}

//MARK: Implemetation

extension MykiRouter where Self: UIViewController {
    
    func push(_ vc: MykiViewControllers) {
        self.navigationController?.pushViewController(vc.getVC(), animated: true)
    }
    
    func present(_ vc: MykiViewControllers) {
        self.present(vc.getVC(), animated: true, completion: nil)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
