//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Jose Martins on 30/10/20.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var switchAutoRefresh: UISwitch!
    @IBOutlet weak var sliderTimeInterval: UISlider!
    @IBOutlet weak var labelTimeInterval: UILabel!
    @IBOutlet weak var controlColorScheme: UISegmentedControl!
    
    let config = Configuration.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.loadConfigs()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadConfigs()
    }
    
    func loadConfigs() {
        switchAutoRefresh.setOn(config.autoRefresh, animated: false)
        sliderTimeInterval.setValue(Float(config.timeInterval), animated: false)
        controlColorScheme.selectedSegmentIndex = config.colorScheme
        changeTimeIntervalLabel(with: config.timeInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        labelTimeInterval.text = "Mudar após \(Int(value)) segundos"
    }

    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeIntervalLabel(with: value)
        config.timeInterval = value
    }
    
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
    
}
