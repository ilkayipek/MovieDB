//
//  DetailMovieContentTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 26.08.2023.
//

import UIKit

class DetailMovieContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overViewArrowButon: UIButton!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var overViewContainerHeightConstraint: NSLayoutConstraint!
    
    var isExpanded = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setOverView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setOverView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        overViewTextView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        overViewTextView.becomeFirstResponder()
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        if !isExpanded {
            let fixedWidth = overViewTextView.frame.size.width
            let newSize = overViewTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            if overViewContainerHeightConstraint.constant < newSize.height + 40 {
                overViewContainerHeightConstraint.constant = newSize.height + 40
                overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
                if let tableView = self.superview as? UITableView {
                        tableView.beginUpdates()
                        tableView.endUpdates()
                    }
                
            }
        } else {
            overViewContainerHeightConstraint.constant = 100
            overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronDown.rawValue,withConfiguration: symbolConfiguration), for: .normal)
            if let tableView = self.superview as? UITableView {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
        }
        isExpanded = !isExpanded
    }
    
}
