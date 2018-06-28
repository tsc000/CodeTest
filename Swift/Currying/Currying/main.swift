//
//  main.swift
//  Currying
//
//  Created by 童世超 on 2018/2/10.
//  Copyright © 2018年 童世超. All rights reserved.
//

import Foundation

//“柯里化是一种量产相似方法的好办法，可以通过柯里化一个方法模板来避免写出很多重复代码，也方便了今后维护。

//基本的柯里化函数
func addTo(_ adder: Int) -> (Int) -> Int {
    return { num in
        return num + adder
    }
}

let addTwo = addTo(2)   //产生一个以2为被加数的闭包
var result6 = addTwo(6) // 2 + 6
var result7 = addTwo(7) // 2 + 7



//比较大小
func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    return {
        $0 > comparer
    }
}

let greaterThan10 = greaterThan(10)
print(greaterThan10(13)) // 13 > 10 true
print(greaterThan10(9))  // 9 < 10 false


class BankAccount {
    var balance: Double = 0.0
    
    //实例方法
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    //有参类方法  利息计算
    class func interest(_ money: Double) -> Double {
        return money * 0.01
    }
    
    //无参类方法  开户人数
    class func bankAccountNO() -> Double {
        return 100
    }
}

//实例化一个对象
let account = BankAccount()
//正常方式调用实例方法
account.deposit(100)

//获取柯里化方法
let depositor = BankAccount.deposit(_:)
//通过柯里化方法进行调用
depositor(account)(100)


//有参类方法部分柯里化
let interest = BankAccount.interest(_:)
//类方法柯里化调用
let money = interest(100)

//无参方法没有柯里化 方法敲出来的时候就是直接调用了
let number = BankAccount.bankAccountNO()




print(interest(100))
print(account.balance)

