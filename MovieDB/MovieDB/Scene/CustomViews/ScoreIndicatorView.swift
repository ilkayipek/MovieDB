//
//  ScoreIndicatorView.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit

class ScoreIndicatorView: UIView {
    private var score: CGFloat = 0.0
    private let trackLayer = CAShapeLayer()
    private let scoreLayer = CAShapeLayer()
    private let scoreLabel = UILabel()

    private let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupLayers()
        setupScoreLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContainerView()
        setupLayers()
        setupScoreLabel()
    }

    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        containerView.backgroundColor = UIColor.black
        containerView.layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    private func setupLayers() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 5

        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(trackLayer)

        let scorePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 2 + 2 * CGFloat.pi * score / 10, clockwise: true)
        scoreLayer.path = scorePath.cgPath
        scoreLayer.strokeColor = UIColor.white.cgColor
        scoreLayer.lineWidth = 5
        scoreLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(scoreLayer)
    }

    private func setupScoreLabel() {
        scoreLabel.frame = bounds
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreLabel.textColor = UIColor.white
        addSubview(scoreLabel)
        updateScoreLabel()
    }

    private func updateScoreLabel() {
        scoreLabel.text = String(format: "%.1f", score)
    }

    func setScore(_ score: CGFloat) {
        self.score = max(0.0, min(10.0, score))
        updateScoreLayer()
        updateScoreLabel()
    }

    private func updateScoreLayer() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - 5

        let scorePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 2 + 2 * CGFloat.pi * score / 10, clockwise: true)
        scoreLayer.path = scorePath.cgPath

        if score < 5.0 {
            scoreLayer.strokeColor = UIColor.red.cgColor
        } else if score < 7.5 {
            scoreLayer.strokeColor = UIColor.orange.cgColor
        } else {
            scoreLayer.strokeColor = UIColor.green.cgColor
        }
    }
}
