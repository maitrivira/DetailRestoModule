//
//  File.swift
//  
//
//  Created by Maitri Vira on 29/05/22.
//

import Core
import RxSwift
import RealmSwift
import Foundation

public struct GetDetailRestaurantsLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    public typealias Response = DetailRestaurantModuleEntity
    
    private let _realm: Realm?
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func list(request: String?) -> Observable<[DetailRestaurantModuleEntity]> {
        
        return Observable<[DetailRestaurantModuleEntity]>.create { observer in
            if let realm = self._realm {
                let detail: Results<DetailRestaurantModuleEntity> = {
                    realm.objects(DetailRestaurantModuleEntity.self).sorted(byKeyPath: "id", ascending: true)
                }()
                observer.onNext(detail.toArray(ofType: DetailRestaurantModuleEntity.self))
                observer.onCompleted()
            }else{
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
        
    }
    
    public func add(entities: DetailRestaurantModuleEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        realm.add(entities, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    public func get(request id: String) -> Observable<DetailRestaurantModuleEntity> {
        fatalError()
    }
    
    public func delete(request data: DetailRestaurantModuleEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        realm.delete(realm.objects(DetailRestaurantModuleEntity.self).filter("id=%@", data.id))
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
}
