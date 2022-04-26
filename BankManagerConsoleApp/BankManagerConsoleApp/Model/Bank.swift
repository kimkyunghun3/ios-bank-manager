//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Eddy on 2022/04/26.
//

struct Bank {
    private let waitingQueue = Queue<Customer>()
    private let clerk = BankClerk()

    func makeCustomers() {
        let customerCount = Int.random(in: 10...30)
        for number in 0..<customerCount {
            waitingQueue.enqueue(Customer(waitingNumber: number))
        }
    }
}
