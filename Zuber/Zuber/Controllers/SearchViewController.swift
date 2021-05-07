//
//  SearchViewController.swift
//  Zuber
//
//  Created by Oguz Demırhan on 2.05.2021.
//

import UIKit
import MapKit


protocol SearchViewControllerDelegate: AnyObject{
    
    func didSelectNewCoordinates(coordinates: CLLocationCoordinate2D?, title: String?)
}

class SearchViewController: UIViewController, MKLocalSearchCompleterDelegate {


    
    var mapKitSearch = MKLocalSearchCompleter()
    
    var searchResults = [MKLocalSearchCompletion]()
    
    
 
    @IBOutlet weak var zuberSearchView: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    weak var delegate: SearchViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchResultsTableView.keyboardDismissMode = .onDrag
        zuberSearchView.delegate = self
        mapKitSearch.delegate = self
    }
    
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        searchResults = completer.results

        
        searchResultsTableView.reloadData()

    }
   


}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let searchResult = searchResults[indexPath.row]
        
        let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "zuberCell", for: indexPath)
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   tableView.deselectRow(at: indexPath, animated: true)

   let result = searchResults[indexPath.row]
   let searchRequest = MKLocalSearch.Request(completion: result)

   let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            print(coordinate)
            
            self.zuberSearchView.text = ""

            self.view.endEditing(true)
            self.delegate?.didSelectNewCoordinates(coordinates: coordinate,title: result.title)
                    
     }
  }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        mapKitSearch.queryFragment = searchText
    }
}


