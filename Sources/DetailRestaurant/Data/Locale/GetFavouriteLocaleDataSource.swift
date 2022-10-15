//
//  File.swift
//  
//
//  Created by Maitri Vira on 18/09/22.
//

import Core
import RxSwift
import RealmSwift
import Foundation

public struct GetFavouriteLocaleDataSource<Transformer: Mapper>: LocaleDataSource
where
    Transformer.Request == DetailRestaurantDomainModel,
    Transformer.Response == Bool,
    Transformer.Entity == DetailRestaurantModuleEntity{
    
    public typealias Request = DetailRestaurantDomainModel
    public typealias Response = Bool
    
    private let _realm: Realm?
    private let _mapper: Transformer
        
    public init(realm: Realm, mapper: Transformer) {
        _realm = realm
        _mapper = mapper
    }
    
    public func getRestaurants() -> Observable<[Bool]> {
        observer.onCompleted()
        return Disposables.create()
    }
    
    public func getRestaurant(request id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let realm = self._realm {
            do {
              let getObjectById = realm.objects(DetailRestaurantModuleEntity.self).filter("id == %@", id)

                if !getObjectById.isEmpty {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }

                observer.onCompleted()
            }
          } else {
            observer.onError(DatabaseError.requestFailed)
            print(DatabaseError.requestFailed)
          }
          return Disposables.create()
        }
    }
    
    public func addRestaurant(entities: DetailRestaurantDomainModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    let realmData = realm.objects(DetailRestaurantModuleEntity.self).filter("id=%@", entities.id)
                    let data = _mapper.transformModelToEntity(request: entities)
                    if realmData.isEmpty {
                        try realm.write {
                            realm.add(data)
                            observer.onNext(true)
                            observer.onCompleted()
                            print("berhasil simpan")
                        }
                    } else {
                        try realm.write {
                            realm.delete(realm.objects(DetailRestaurantModuleEntity.self).filter("id=%@", entities.id))
                            observer.onNext(true)
                            observer.onCompleted()
                            print("berhasil hapus")
                        }
                    }
                        
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                    print(DatabaseError.requestFailed)
                }
            }else{
                observer.onError(DatabaseError.requestFailed)
                print(DatabaseError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
    
    public func removeRestaurant(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        realm.delete(realm.objects(DetailRestaurantModuleEntity.self).filter("id=%@", id))
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

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0..<count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
