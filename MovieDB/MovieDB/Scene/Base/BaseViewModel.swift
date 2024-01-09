//
//  BaseViewModel.swift
//  MovieDB
//
//  Created by MacBook on 19.07.2023.
//

import UIKit.UIAlert

class BaseViewModel {
    var errorHandler: ((String, AlertTitle ,ActionTitle) -> Void)?
    var errorHandlerCompletion: ((String, AlertTitle, ActionTitle, @escaping(UIAlertAction) -> Void) -> Void)?
    var gradientLoagingTabAnimation: CustomGradientLoadingAnimation?
}
