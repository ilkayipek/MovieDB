//
//  BaseViewController.swift
//  MovieDB
//
//  Created by MacBook on 19.07.2023.
//

import UIKit

class BaseViewController<V: BaseViewModel>: UIViewController {
    var gradientLoagingTabAnimation: CustomGradientLoadingAnimation?

    var viewModel: V? {
        didSet {
            setViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gradientLoagingTabAnimation?.stopAnimations()
    }
    
    func alertMessageDefault(alertTitle: AlertTitle, alertMessage: String, actionTitle: ActionTitle) {
        let alertTitle = NSLocalizedString(alertTitle.rawValue, comment: "")
        let alertMessage = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionTitle = NSLocalizedString(actionTitle.rawValue, comment: "")
        let action = UIAlertAction(title: actionTitle, style:.default)
        alertMessage.addAction(action)
        present(alertMessage, animated: true)
    }
    
    func alertMessageDefaultCompletion(alertTitle: AlertTitle, alertMessage: String, actionTitle: ActionTitle, closure: @escaping(UIAlertAction) -> Void) {
        let alertTitle = NSLocalizedString(alertTitle.rawValue, comment: "")
        let alertMessage = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionTitle = NSLocalizedString(actionTitle.rawValue, comment: "")
        let action = UIAlertAction(title: actionTitle, style:.default, handler: closure)
        alertMessage.addAction(action)
        present(alertMessage, animated: true)
    }
    
    func setViewModel() {
        viewModel?.errorHandler = { [weak self] (alertMessage, alertTitle, actionTitle) in
            guard let self else {return}
            self.alertMessageDefault(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle)
        }
        viewModel?.errorHandlerCompletion = { [weak self] (alertMessage, alertTitle, actionTitle, closure) in
            guard let self else {return}
            self.alertMessageDefaultCompletion(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: actionTitle, closure: closure)
        }
        
        self.gradientLoagingTabAnimation = CustomGradientLoadingAnimation(x: 0, y: 0, width: view.frame.width*0.8, height: 5, color: UIColor(named: "DetailButtonBackgroundColor") ?? .white)
        viewModel?.gradientLoagingTabAnimation = self.gradientLoagingTabAnimation
        self.navigationController?.navigationBar.addSubview(gradientLoagingTabAnimation!)
    }
    
}
