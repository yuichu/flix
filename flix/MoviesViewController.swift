//
//  MoviesViewController.swift
//  flix
//
//  Created by Yujin Chung on 2/23/22.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // properties
    var movies = [[String:Any]]()   // array of dictionaries

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // network request snippet to get new movies
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    // access key results from API and store to movies property
                    self.movies = dataDictionary["results"] as! [[String:Any]]
             }
        }
        task.resume()
        // end network request snippet
    }
    
    // protocol stub - number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    // protocol stub - display the rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell for particular row
        let cell = UITableViewCell()
        
        // get current movie per API results index
        let movie = movies[indexPath.row]
        // get title of movie (cast to string)
        let title = movie["title"] as! String
        
        // display title in cell
        cell.textLabel!.text = title
        
        return cell
    }

}

