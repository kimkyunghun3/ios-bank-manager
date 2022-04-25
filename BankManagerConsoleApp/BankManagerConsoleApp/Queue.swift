//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by Eddy on 2022/04/25.
//

import Foundation

final class Queue<Element> {
    let list: LinkedList<Element>

    init(list: LinkedList<Element>) {
        self.list = list
    }

    var isEmpty: Bool {
        return list.isEmpty
    }