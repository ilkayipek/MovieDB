//
//  TrailerWebViewViewController.swift
//  MovieDB
//
//  Created by MacBook on 23.08.2023.
//

import UIKit
import WebKit

class TrailerWebViewViewController: BaseViewController<TrailerWebViewViewModel> {
    
    var videoKey: String?
    @IBOutlet weak private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TrailerWebViewViewModel()
        loadYoutubePage()
    }
    
    //MARK: Redirect to web page with video key
    private func loadYoutubePage() {
        if let videoKey {
            let urlString = Constant.RequestPathMovie.trailerVideoUrlWeb(key: videoKey)
            if let url = URL(string: urlString) {
                let requestUrl = URLRequest(url: url)
                self.webView.load(requestUrl)
            } else {
                error()
            }
            
        } else {
           error()
        }
    }
    
    private func error() {
        let errorMessage = NSLocalizedString("A technical problem has occurred!", comment: "")
        viewModel?.errorHandlerCompletion?(errorMessage,.error,.okey) {[weak self] _ in
            guard let self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }

}
