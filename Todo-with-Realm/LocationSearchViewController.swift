//
//  LocationSearchViewController.swift
//  Todo-with-Realm
//
//  Created by NishiokaKohei on 2017/08/20.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit
import Foundation
import MapKit

final class LocationSearchViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Public properties

    var region: MKCoordinateRegion? = nil

    var adopt: ((_ completion: MKLocalSearchCompletion) -> Void)? = nil

    // MARK: - private properties

    fileprivate var completer = MKLocalSearchCompleter()

    fileprivate var source = [MKLocalSearchCompletion]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegateSearceBar(false)
        delegateTableView(false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
    }

    override func viewWillLayoutSubviews() { }

    // MARK: - Private methods

    fileprivate func delegateTableView(_ updating: Bool) {
        if updating {
            tableView.dataSource = nil
            tableView.delegate = nil
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    fileprivate func delegateSearceBar(_ updating: Bool) {
        if updating {
            searchBar.delegate = nil
        }
        searchBar.delegate = self
    }

    fileprivate func onEnd() {
        dismiss(animated: true, completion: nil)
    }

    fileprivate func start() {
        completer.delegate = self
        completer.filterType = .locationsAndQueries
        completer.queryFragment = ""
    }

}

// MARK: - Storyboardable

extension LocationSearchViewController: Storyboardable {}

// MARK: - UISearchBarDelegate

extension LocationSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(searchBar.text ?? "failed")
        if let text = searchBar.text {
            if text.isEmpty {
                // 文字が0文字になったとき
                completer.cancel()
            } else {
                // 検索開始
                completer.queryFragment = text
            }
        } else {
            return false
        }
        if completer.isSearching { print("start searching") }
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセル押下後の処理
        completer.cancel()
        dismiss(animated: true, completion: nil)
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarResults of ListButton was Clicked")
    }

}

// MARK: - UITableViewDataSource

extension LocationSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if source.isEmpty {
            return 1
        }
        return source.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LocationSearchResultCell")
        if source.isEmpty {
            cell?.textLabel?.text = "No candidate."
        } else {
            cell?.textLabel?.text = source[indexPath.row].title
        }
        return cell!
    }

}

// MARK: - UITableViewDelegate

extension LocationSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 検索結果をタップすると, MKLocalSearchが実行される. 地図画面上にピンを立てる
        if source.isEmpty { return }
        adopt?(source[indexPath.row])
        onEnd()
    }

}

// MARK: - MKLocalSearchCompleterko
extension LocationSearchViewController: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let set = Set(completer.results)
        self.source = Array(set)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
        source = []
    }

}
