//
//  ViewController.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 01.11.2020.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    var newMovie: Movie?
    
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    let alert = UIAlertController(title: "No movies found", message: "Let's go and add a new one by pressing the add button below", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        movies = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.text = ""
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
//        if (newMovie != nil) {
//            print(newMovie!)
//            addMovie(movie: newMovie!)
//        }
        
    }
    
    func createArray() -> [Movie] {
        var movies: [Movie] = []
        
        struct Root: Codable {
            let Search: [MovieJSON]
        }

        struct MovieJSON: Codable {
            let Title: String
            let Year: String
            let Poster: String
        }
        
        let path = Bundle.main.url(forResource: "MoviesList", withExtension: "txt")
        let data = try? Data(contentsOf: path!)
        let result = try? JSONDecoder().decode(Root.self, from: data!)
        
        
        result?.Search.forEach {
            let image = UIImage(named: "\(($0.Poster.dropLast(4).count != 0) ? $0.Poster.dropLast(4) : "Poster_01")")
            let movie = Movie(image: image!, title: $0.Title, year: $0.Year, type: "movie")
            movies.append(movie)
        }
        
        return movies
    }
    
    func filterContentForSearchText(_ searchText: String, category: Movie.Type? = nil) {
        filteredMovies = movies.filter { (movie: Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        if filteredMovies.count == 0 && isFiltering {
            self.present(alert, animated: true)
        }
        
      
        tableView.reloadData()
    }
    
    func addMovie(movie: Movie) -> Void {
        movies.append(movie)

        tableView.reloadData()
    }
    
    @IBAction func unwindToTable(_ sender: UIStoryboardSegue) {
        addMovie(movie: newMovie!)
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovies.count
        }
            
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie: Movie
        if isFiltering {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.setMovie(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showSegue" else { return }
        guard let destination = segue.destination as? MovieInfoViewController else { return }

        let movie = movies[(tableView.indexPathForSelectedRow?.row)!]

        destination.movieName = movie.title
        destination.movieYear = movie.year
        destination.movieType = movie.type
        destination.moviePoster = movie.image
    }
}
