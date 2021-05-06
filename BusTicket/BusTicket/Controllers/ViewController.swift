//
//  ViewController.swift
//  BusTicket
//
//  Created by Oguz Demırhan on 3.05.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //MARK:-IBOutlets
    @IBOutlet weak var firstSearchBar: UISearchBar!
    @IBOutlet weak var secondSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sessionDatePicker: UIDatePicker!
    @IBOutlet weak var sessionTimePicker: UIDatePicker!
    
    
    var activeTag = 0
    var mapKitSearch = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var passenger = Passenger.shared
    
    let dateFormatter = DateFormatter()
    
    
    //MARK:-viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        passenger.printThePassenger()
    }
    
    
    
    //MARK:-Configure
    
    private func configure(){
        dateFormatter.dateFormat = "dd-MM-yyyy"
        firstSearchBar.searchTextField.textColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        secondSearchBar.searchTextField.textColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        tableView.keyboardDismissMode = .onDrag
        firstSearchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        secondSearchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        mapKitSearch.delegate = self
        firstSearchBar.delegate = self
        secondSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        self.getBusButtonSetup()
        sessionTimePicker.datePickerMode = .time
        print(sessionTimePicker.date)
        view.backgroundColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
    }
    
    //MARK:-ButtonSetup
    private func getBusButtonSetup() {
        let listItButton = UIButton()
        listItButton.backgroundColor = #colorLiteral(red: 0.08500792831, green: 0.6792595983, blue: 0.7107330561, alpha: 1)
        listItButton.setTitle("List It", for: .normal)
        listItButton.setTitleColor(#colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1), for: .normal)
        listItButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 16.0)
        listItButton.addTarget(self, action: #selector(listItButtonAction), for: .touchUpInside)
        listItButton.layer.cornerRadius = 12
        listItButton.layer.shadowColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        listItButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        listItButton.layer.shadowRadius = 2.1
        listItButton.layer.shadowOpacity = 0.6
        tableView.addSubview(listItButton)
        
        
        NSLayoutConstraint.activate([
            listItButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor,constant: 40),
            listItButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor,constant: -40),
            listItButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            listItButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        listItButton.translatesAutoresizingMaskIntoConstraints = false

    }
    
    @objc func listItButtonAction() {
        
        
        let busVC = storyboard?.instantiateViewController(identifier: "ticketVC") as! TicketsViewController
        
        if ((firstSearchBar.text?.contains(", ")) != nil) {
            let str = firstSearchBar.text
            let destination = str!.components(separatedBy: ", ")
            busVC.activePickupLocation = destination[0]
        }
        else{
            busVC.activePickupLocation = secondSearchBar.text!
        }
        
        if ((secondSearchBar.text?.contains(", ")) != nil) {
            let str = secondSearchBar.text
            let destination = str!.components(separatedBy: ", ")
            busVC.activeDestLocation = destination[0]
        }
        else{
            busVC.activeDestLocation = firstSearchBar.text!
        }
        

            let timeZonedTime = sessionTimePicker.date.toCurrentTimezone()
            let destCalculatedTime = timeZonedTime.addingTimeInterval(3600)
            let destTime = destCalculatedTime.description.split(separator: " ")
            let time = timeZonedTime.description.split(separator: " ")
            let formattedDestTime = destTime[1].description.components(separatedBy: ":")
            let formattedTime = time[1].description.components(separatedBy: ":")
            let stringDate = dateFormatter.string(from: sessionDatePicker.date)
            let seperatedDate = stringDate.components(separatedBy: "-")
            let timeInstance = TimeClass(hour: Int(formattedTime[0])!, min: Int(formattedTime[1])!)
            let dateInstance = DateClass(dd: Int(seperatedDate[0])!, MM: Int(seperatedDate[1])!, YYYY: Int(seperatedDate[2])!)
            busVC.activeDate = "\(Int(dateInstance.day!))-\(Int(dateInstance.month!))-\(Int(dateInstance.year!))"
            busVC.activeTime = "\(Int(timeInstance.hour!)):\(Int(timeInstance.minute!))"
            busVC.activeDestTime = formattedDestTime[0] + ":" + formattedDestTime[1]
           
            firstSearchBar.text = ""
            secondSearchBar.text = ""
        

        
        present(busVC, animated: true, completion: nil)
        
        
    }


}

//MARK:- UISearchBarDelegate
extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mapKitSearch.queryFragment = searchText
        
        activeTag = searchBar.tag
    }
    
}


//MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.93323493, green: 0.9333916306, blue: 0.9332129359, alpha: 1)
        
        cell.textLabel?.text = searchResult.title
        cell.textLabel?.textColor = #colorLiteral(red: 0.1965712365, green: 0.2446304262, blue: 0.2757096887, alpha: 1)
        
        return cell
    }
    
    
}

//MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchResult = searchResults[indexPath.row]
        
        if activeTag == 0 {
            
            firstSearchBar.text = searchResult.title
        }
        
        else if activeTag == 1 {
            
            secondSearchBar.text = searchResult.title
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        searchResults.removeAll()
        tableView.reloadData()
        
    }
}


//MARK:-MKLocalSearchCompleterDelegate
extension ViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    
}


extension Date {

      func toCurrentTimezone() -> Date {

          let timeZoneDifference = TimeInterval(TimeZone.current.secondsFromGMT())

          return self.addingTimeInterval(timeZoneDifference)

      }

 }



