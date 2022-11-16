//
//  EquipmentViewController.swift
//  InvadersCountdown
//
//  Created by Julia Semyzhenko on 7/21/22.
//

import UIKit

class EquipmentViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var dayOfWarLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var aircraftLabel: UILabel!
    @IBOutlet weak var helicopterLabel: UILabel!
    @IBOutlet weak var tankLabel: UILabel!
    @IBOutlet weak var apcLabel: UILabel!
    @IBOutlet weak var fieldArtilleryLabel: UILabel!
    @IBOutlet weak var militaryAutoLabel: UILabel!
    @IBOutlet weak var cruiseMissilesLabel: UILabel!
    @IBOutlet weak var navalShipLabel: UILabel!
    @IBOutlet weak var antiAircraftWarfareLabel: UILabel!
    @IBOutlet weak var MRLLabel: UILabel!
    @IBOutlet weak var SRBMLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    let isoDate = "2022-02-23T10:44:00+0000"
    let dateFormatter2 = ISO8601DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.backgroundColor = UIColor(named: "ua_blue")
        datePicker.tintColor = UIColor(named: "dark_military")
        let date = dateFormatter2.date(from:isoDate)!
        dateFormatter.dateFormat = "YYYY-MM-dd"
        screenData.date = dateFormatter.string(from: datePicker.date)
        screenData.day = daysBetween(start: date, end: datePicker.date)
        
        dayOfWarLabel.text = "\(screenData.day)"
        
        JSONDownload.shared.getEquipmentData { [weak self]
            result in
            switch result {
            case .success( let data):
                for item in data {
                    if item.date == screenData.date {
                        self?.labelUpdate(
                            aircraft: "\(item.aircraft)",
                            helicopter: "\(item.helicopter)",
                            tank: "\(item.tank)",
                            apc: "\(item.apc)",
                            fieldArtillery: "\(item.fieldArtillery)",
                            militaryAuto: "\(item.militaryAuto ?? item.vehiclesAndFuelTanks ?? 0)",
                            cruiseMissiles: "\(item.cruiseMissiles ?? 0)",
                            navalShip: "\(item.navalShip)",
                            antiAircraftWarfare: "\(item.antiAircraftWarfare)",
                            MRL: "\(item.MRL)",
                            SRBM: "\(item.mobileSRBMSystem ?? 0)")
                        break
                    }
                    self?.labelUpdate(
                        aircraft: "\(data[data.count - 1].aircraft)",
                        helicopter: "\(data[data.count - 1].helicopter)",
                        tank: "\(data[data.count - 1].tank)",
                        apc: "\(data[data.count - 1].apc)",
                        fieldArtillery: "\(data[data.count - 1].fieldArtillery)",
                        militaryAuto: "\(data[data.count - 1].militaryAuto ?? data[data.count - 1].vehiclesAndFuelTanks ?? 0)",
                        cruiseMissiles: "\(data[data.count - 1].cruiseMissiles ?? 0)",
                        navalShip: "\(data[data.count - 1].navalShip)",
                        antiAircraftWarfare: "\(data[data.count - 1].antiAircraftWarfare)",
                        MRL: "\(data[data.count - 1].MRL)",
                        SRBM: "\(data[data.count - 1].mobileSRBMSystem ?? 0)" )
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        screenData.date = dateFormatter.string(from: datePicker.date)
        viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.delegate = self
        viewDidLoad()
    }
    
    func labelUpdate(aircraft: String, helicopter: String, tank:  String, apc: String, fieldArtillery: String, militaryAuto: String, cruiseMissiles: String, navalShip: String, antiAircraftWarfare: String, MRL: String, SRBM: String) {
        DispatchQueue.main.async {
            self.aircraftLabel.text = aircraft
            self.helicopterLabel.text = helicopter
            self.tankLabel.text = tank
            self.apcLabel.text = apc
            self.fieldArtilleryLabel.text = fieldArtillery
            self.militaryAutoLabel.text = militaryAuto
            self.cruiseMissilesLabel.text = cruiseMissiles
            self.navalShipLabel.text =  navalShip
            self.antiAircraftWarfareLabel.text = antiAircraftWarfare
            self.MRLLabel.text = MRL
            self.SRBMLabel.text = SRBM
            
        }
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: start)!
        let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: end)!
        return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
    }
    
}
