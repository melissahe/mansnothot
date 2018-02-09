//
//  FullSizeVC.swift
//  mansnothot
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class FullSizeVC: UIViewController {

    let fullSizeView = FullSizeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpGestures()
    }
    
    public func configureWithImage(image: UIImage) {
        self.fullSizeView.profileImageView.image = image
        self.fullSizeView.scrollView.delegate = self
    }
    
    private func setUpViews() {
        self.view.backgroundColor = .black
        self.view.addSubview(fullSizeView)
        fullSizeView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        fullSizeView.profileImageView.addGestureRecognizer(tapGesture)
        fullSizeView.scrollContentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func screenTapped() {
        if fullSizeView.scrollView.zoomScale > 1.0 {
            UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                self.fullSizeView.scrollView.zoomScale = 1.0
            })
        } else if fullSizeView.scrollView.zoomScale == 1.0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension FullSizeVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullSizeView.profileImageView
    }
}
