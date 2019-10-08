//
//  MykiRouter.swift
//  MykiLite
//
//  Created by Miguel Bou Sleiman on 10/8/19.
//  Copyright © 2019 myki. All rights reserved.
//

import UIKit

protocol MykiRouter {
    func push(_ vc: MykiViewControllers, animated: Bool)
    func present(_ vc: MykiViewControllers, animated: Bool, completion: @escaping () -> Void)
    func popView(animated: Bool)
    func dismissView(animated: Bool, completion: @escaping () -> Void)
}

//MARK: Implemetation

extension MykiRouter where Self: UIViewController {
    
    func push(_ vc: MykiViewControllers, animated: Bool) {
        self.navigationController?.pushViewController(vc.getVC(), animated: animated)
    }
    
    func present(_ vc: MykiViewControllers, animated: Bool, completion: @escaping () -> Void) {
        self.present(vc.getVC(), animated: animated, completion: completion)
    }
    
    func popView(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func dismissView(animated: Bool, completion: @escaping () -> Void) {
        self.dismiss(animated: animated, completion: completion)
    }
    
}
