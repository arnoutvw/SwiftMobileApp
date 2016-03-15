//
//  AbstractService.swift
//  My_Devoxx
//
//  Created by Maxime on 12/03/16.
//  Copyright © 2016 maximedavid. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AbstractService  {
    
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext

   
    
    var currentCfp:Cfp?
  
    init() {
       
        mainManagedObjectContext = MainManager.sharedInstance.mainManagedObjectContext

        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateManagedObjectContext.parentContext = mainManagedObjectContext
    }
    
    func invertFavorite(id : NSManagedObjectID) -> Bool {
        if let cellData:FavoriteProtocol = APIDataManager.findEntityFromId(id, inContext: self.privateManagedObjectContext) {
            cellData.invertFavorite()
            //TODO
            self.realSave(nil)
            return cellData.isFav()
        }
        return false
    }
    
    
    func realSave(completionHandler : ((msg: CallbackProtocol) -> Void)?) {
        return realSave(completionHandler, obj : nil, img : nil)
    }
    
    func realSave(completionHandler : ((msg: CallbackProtocol) -> Void)?, obj : NSManagedObject?) {
        return realSave(completionHandler, obj : obj, img : nil)
    }
    
    func realSave(completionHandler : ((msg: CallbackProtocol) -> Void)?, img : NSData?) {
        return realSave(completionHandler, obj : nil, img : img)
    }
    
    func realSave(completionHandler : ((msg: CallbackProtocol) -> Void)?, obj :NSManagedObject?, img : NSData?) {
        do {
            try privateManagedObjectContext.save()
            mainManagedObjectContext.performBlock {
                do {
                    try self.mainManagedObjectContext.save()
                    dispatch_async(dispatch_get_main_queue(),{
                        print(obj)
                        
                        if let objHelperable = obj as? HelperableProtocol {
                            completionHandler?(msg: CompletionMessage(obj : objHelperable.toHelper()))
                        }
                        else if img != nil {
                            completionHandler?(msg: CompletionMessage(img : img))
                        }
                        else {
                            completionHandler?(msg: CompletionMessage(msg: "OK"))
                            
                        }
                        
                    })
                } catch let err as NSError {
                    print("Could not save main context: \(err.localizedDescription)")
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler?(msg: CompletionMessage(msg: "KO"))
                    })
                }
            }
        } catch let err as NSError {
            print("Could not save private context: \(err.localizedDescription)")
            dispatch_async(dispatch_get_main_queue(),{
                completionHandler?(msg: CompletionMessage(msg: "KO"))
            })
        }
    }

    func saveImage(completionHandler : ((data: NSData?) -> NSData)?) {
        do {
            try privateManagedObjectContext.save()
            mainManagedObjectContext.performBlock {
                do {
                    try self.mainManagedObjectContext.save()
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler?(data: nil)
                    })
                } catch let err as NSError {
                    print("Could not save main context: \(err.localizedDescription)")
                    dispatch_async(dispatch_get_main_queue(),{
                        completionHandler
                    })
                }
            }
        } catch let err as NSError {
            print("Could not save private context: \(err.localizedDescription)")
            dispatch_async(dispatch_get_main_queue(),{
                completionHandler
            })
        }
    }

    
    func getHelper() -> DataHelperProtocol {
        return SpeakerHelper()
    }
    
    func updateWithHelper(helper : [DataHelperProtocol], completionHandler : (msg: CallbackProtocol) -> Void) {
        
    }
    
    func getCfpId() -> String{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let currentEventStr = defaults.objectForKey("currentEvent") as? String {
            print("READIND 0 \(currentEventStr)")
            return currentEventStr
        }
        return ""
    }
    
    
    func isEmpty() -> Bool {
        return true
    }
    
    
        
   

}
