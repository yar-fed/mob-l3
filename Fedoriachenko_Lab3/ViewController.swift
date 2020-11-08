//
//  ViewController.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 01.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movies = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.setMovie(movie: movie)
        
        return cell
    }
}

