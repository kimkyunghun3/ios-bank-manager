//
//  BankView.swift
//  BankManagerUIApp
//
//  Created by Eddy, dudu.
//

import UIKit

class BankView: UIView {
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addCustomerbutton, resetButton])
        return stackView
    }()
    
    private lazy var addCustomerbutton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    private lazy var businessHoursLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 - 00:00:000"
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private lazy var workStateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [waitLabel, workLabel])
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var waitLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title1)
        label.backgroundColor = .systemGreen
        
        return label
    }()
    
    private lazy var workLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title1)
        label.backgroundColor = .systemPurple
        
        return label
    }()
}


