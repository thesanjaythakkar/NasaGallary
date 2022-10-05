//
//  ViewController.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 03/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import Kingfisher

/// Main Gallary View Controller
class GallaryVC: BaseVC {

    lazy var viewModel: GallaryVM = {
        return GallaryVM()
    }()
    
    private var disposeBag = DisposeBag()
    @IBOutlet var collectionView: UICollectionView!
    {
        didSet{
            let flowLayout = UICollectionViewFlowLayout()
            let squareSize = (UIScreen.main.bounds.size.width - 40)/3
            flowLayout.itemSize = CGSize(width: squareSize, height: squareSize)
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
            collectionView.setCollectionViewLayout(flowLayout, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCell(type: GallaryCell.self)
        setupBindings()
        // Do any additional setup after loading the view.
    }
    private func setupBindings() {
        viewModel.sortedPhotos
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] photos in
                self?.bindCollectionView()
            }.disposed(by: disposeBag)
    }
    private func bindCollectionView() {
        viewModel.sortedPhotos
            .bind(to:
                    collectionView.rx.items(
                        cellIdentifier: GallaryCell.identifier,
                        cellType: GallaryCell.self
                    )
            ) { indexPath, object, cell in
                cell.imgPhoto.kf.setImage(
                    with: URL(string: object.url),
                    placeholder: UIImage(named: "placeholder")
                )
                cell.imgPhoto.hero.id = object.url
            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(Photo.self).asDriver().drive { photo in
            self.performSegue(withIdentifier: "DetailsVC", sender: photo)
        }.disposed(by: disposeBag)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsVC" {
            let vc = segue.destination as! DetailsVC
            vc.viewModel.selectedPhoto.onNext(sender as! Photo)
            vc.viewModel.heroID.onNext((sender as! Photo).url)
        }
    }
}

