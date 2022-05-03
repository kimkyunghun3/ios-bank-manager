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
}


