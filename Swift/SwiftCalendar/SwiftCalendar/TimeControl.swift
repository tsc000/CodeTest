//
//  TimeControl.swift
//  Driver
//
//  Created by 童世超 on 2018/8/13.
//  Copyright © 2018年 Aerozhonghuan. All rights reserved.
//

import UIKit

enum DateDisplay: Int {
    case yearMonthDay = 0
    case yearWeek = 1
    case yearMonth = 2
}


class TimeControl: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //年(供外部参考)
    private(set) var year: String = ""
    
    //weak或月
    private(set) var other: String = ""
    
    //日，周，月
    var type: DateDisplay = .yearMonthDay {
        didSet {
            if type == .yearMonthDay {
                textField.inputView = datePicker
            } else {
                textField.inputView = yearPickerView
            }
        }
    }
    
    private var textField: UITextField = UITextField(frame: CGRect.null)
    
    weak var delegate: TimeControlDelegate?
    
    var yearDataSource: [String] = [] {
        didSet {
            yearPickerView.reloadComponent(0)
        }
    }
    
    private var otherDataSource: [String] = [] {
        didSet {
            yearPickerView.reloadComponent(1)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return type == .yearMonthDay ? 3 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return yearDataSource.count
        }
        return otherDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return yearDataSource[row]
        }
        return otherDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            year = yearDataSource[row]
            if type == .yearWeek {
                let intYear: NSInteger = NSInteger(year.dropLast())!
                otherDataSource = CaculateWeeks.weeks(of:intYear)
            }
            return
        }
        other = otherDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        let width = UIScreen.main.bounds.width
        if type == .yearWeek {
            return component == 0 ? 0.3 * width : 0.7 * width
        } else {
            return 0.5 * width
        }
    }
    
    lazy var cancelItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel(BarButtonItem:)))
    lazy var confirmItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(confirm(BarButtonItem:)))
    private lazy var flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    let yearPickerView = UIPickerView(frame: CGRect.null)
    lazy var datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(textField)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.items = [cancelItem, flexibleItem, confirmItem]
        textField.inputAccessoryView = toolBar
        textField.inputView = yearPickerView
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        
        datePicker.date = Date()
        datePicker.datePickerMode = .date
        datePicker.locale = NSLocale(localeIdentifier: "zh-Hans") as Locale
        
        if type == .yearMonthDay {
            textField.inputView = datePicker
        } else {
            textField.inputView = yearPickerView
        }

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
    }
    
    func show() {
        datePicker.date = Date()
        
        //展示前后20年
        let year = CaculateWeeks.invokeYearDayMonth(date: datePicker.date, dateFormat: "yyyy")
        let intYear: NSInteger = NSInteger(year)!
        
        let preYear = (intYear ..< intYear + 20).map { (num) in
            return "\(num)年"
        }
        
        let lastYear = (intYear - 20 ..< intYear).map { (num) in
            return "\(num)年"
        }

        yearDataSource = lastYear + preYear
        
        if type == .yearWeek { //周
            otherDataSource = CaculateWeeks.weeks(of: intYear)
            self.yearPickerView.selectRow(20, inComponent: 0, animated: true)
            self.year = yearDataSource[20]
            self.other = otherDataSource[CaculateWeeks.currentWeekPostition]
            self.yearPickerView.selectRow(CaculateWeeks.currentWeekPostition, inComponent: 1, animated: true)
            
        } else if type == .yearMonth { //月
            otherDataSource = (1 ... 12).map{ "\($0)月" }
        
            self.yearPickerView.selectRow(20, inComponent: 0, animated: true)
            let month = CaculateWeeks.invokeYearDayMonth(date: datePicker.date, dateFormat: "M")
            let index = otherDataSource.index(of: month + "月")!
            self.yearPickerView.selectRow(index, inComponent: 1, animated: true)
            
            self.year = yearDataSource[20]
            self.other = otherDataSource[index]
        }
        
        self.frame = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        textField.becomeFirstResponder()
    }
    
    @objc func hide() {
        removeFromSuperview()
        textField.resignFirstResponder()
    }
    
    @objc func confirm(BarButtonItem:UIBarButtonItem) {
        performDelegate()
    }
    @objc func cancel(BarButtonItem:UIBarButtonItem) {
        performDelegate()
    }
    
    private func performDelegate() {
        //日
        if type == .yearMonthDay {
            let year = CaculateWeeks.invokeYearDayMonth(date: datePicker.date, dateFormat: "yyyy")
            let month = CaculateWeeks.invokeYearDayMonth(date: datePicker.date, dateFormat: "MM")
            let day = CaculateWeeks.invokeYearDayMonth(date: datePicker.date, dateFormat: "dd")
            self.delegate?.confirm(year: year, month: month, day: day, week: nil)
        } else if type == .yearMonth { //月
            self.delegate?.confirm(year: year, month: other, day: nil, week: nil)
        } else { //周
            self.delegate?.confirm(year: year, month: nil, day: nil, week: other)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

protocol TimeControlDelegate: NSObjectProtocol {
    func confirm(year: String, month: String?, day: String?, week: String?)
    func cancel(year: String, month: String?, day: String?, week: String?)
}
