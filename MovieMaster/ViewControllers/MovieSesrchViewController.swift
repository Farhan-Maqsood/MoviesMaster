//
//  MovieSesrchViewController.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import UIKit

class MovieSesrchViewController: UIViewController {
    @IBOutlet weak var searchtextField: UITextField!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var moviesearchViewModel:MovieSesrchViewControllerViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchtextField.delegate = self
        self.title = "Search Movies"
        NotificationCenter.default.addObserver(self, selector: #selector(reloadtable), name: Notification.Name("ResultGenerated"), object: nil)
        registeCell()
        // Do any additional setup after loading the view.
    }
    
    @objc func reloadtable()
    {
        self.searchResultTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieSesrchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesearchViewModel?.numberOfRows() ?? 0 > 0
        {
            return moviesearchViewModel?.numberOfRows() ?? 0
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if moviesearchViewModel?.numberOfRows() ?? 0 > 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsTableViewCell", for: indexPath) as! SearchResultsTableViewCell
            cell.viewModel = moviesearchViewModel?.viewModel(for: indexPath)
            cell.config()
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.config()
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesearchViewModel?.didSelectRow(at: indexPath)
    }
    
    
    
    
}
extension MovieSesrchViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        moviesearchViewModel?.searchMovies(for: newText)
        
        return true
    }
}
extension MovieSesrchViewController {
    func registeCell()
    {
        searchResultTableView.register(UINib(nibName: "SearchResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultsTableViewCell")
        searchResultTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
    }
}
