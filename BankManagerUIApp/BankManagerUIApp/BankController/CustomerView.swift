//
//  CustomerView.swift
//  BankManagerUIApp
//
//  Created by Eddy on 2022/05/03.
//

import UIKit

class CustomerView: UIView {
    let customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customerLabel: UILabel = {
        let label = UILabel()
        
        if customer.workType == .loan {
            label.textColor = .systemPurple
        }

        label.text = "\(customer.waitingNumber) - \(customer.workType.name)"
        
        return label
    }()
}
