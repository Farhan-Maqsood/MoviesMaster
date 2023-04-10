//
//  FavMoviesViewController.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import UIKit

class FavMoviesViewController: UIViewController {

    @IBOutlet weak var favMoviesTableView: UITableView!
    var viewModdel:FavMoviesViewControllerViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        favMoviesTableView.delegate = self
        favMoviesTableView.dataSource = self
        self.title = "Favourite Movies"
        registerCell()
        NotificationCenter.default.addObserver(self, selector: #selector(FavMovieRemoved), name: Notification.Name("FavMovieRemoved"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func FavMovieRemoved()
    {
        viewModdel?.generateViewModels()
        self.favMoviesTableView.reloadData()
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

extension FavMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModdel?.numberofRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavMoviesTableViewCell", for: indexPath) as! FavMoviesTableViewCell
        cell.viewModel = viewModdel?.viewModel(for: indexPath)
        cell.config()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModdel?.didSeletFavMovie(for: indexPath)
    }
    
    
    
}
extension FavMoviesViewController {
    func registerCell()
    {
        self.favMoviesTableView.register(UINib(nibName: "FavMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavMoviesTableViewCell")
    }
}
