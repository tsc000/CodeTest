//
//  ViewController.swift
//  SwiftCalendar
//
//  Created by 童世超 on 2018/8/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TimeControlDelegate {

    private(set) var timeControl: TimeControl = TimeControl(frame: CGRect.null)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeControl.delegate = self
    }

    @IBAction func buttonDidClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            timeControl.type = .yearMonthDay
            timeControl.show()
        case 1:
            timeControl.type = .yearWeek
            timeControl.show()
        case 2:
            timeControl.type = .yearMonth
            timeControl.show()
        default:
            break
        }
    }
    
    @IBOutlet weak var buttonDidClick: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func cancel(year: String, month: String?, day: String?, week: String?) {
        timeControl.hide()
        print(year)
        print(month)
        print(day)
        print(week)
    }
    
    func confirm(year: String, month: String?, day: String?, week: String?) {
        timeControl.hide()
        print(year)
        print(month)
        print(day)
        print(week)
    }
}

