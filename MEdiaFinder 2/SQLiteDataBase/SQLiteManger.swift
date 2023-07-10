//
//  SQLiteManger.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/28/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import SQLite

class SQLiteManger {
    //MARK - Propireties
    private static let sharedInstance = SQLiteManger()
    var database: Connection!
    //MARK - Table Propireties
    let userTable = Table("Users")
    let userData = Expression<Data>("UserData")
    
    let searchHistory = Table("search_history")
    let id = Expression<Int64>("id")
    let searchText = Expression<String>("search_text")
    let searchDate = Expression<Date>("search_date")
    let artist = Expression<[Artist]>("artist")
    //MARK - Methods
    class func shared() -> SQLiteManger {
        return SQLiteManger.sharedInstance
    }
    // Create a connection to the SQLite database
    //  let db = try! Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/mydb.sqlite3")
    // Create a connection to the SQLite database Another Way
    func setupConnection(){
        do{
            let decumentDirecry = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let filePath = decumentDirecry.appendingPathComponent("UsersDataBase").appendingPathExtension("sqlite3")
            let database = try Connection(filePath.path)
            self.database = database
        }catch{
            print(error.localizedDescription)
        }
    }
    func creatTables(){
        let creatTable = self.userTable.create{table in
            table.column(self.userData)
        }
        do{
            try self.database.run(creatTable)
        }catch{
            print(error.localizedDescription)
        }
    }

    func createSearchHistoryTable2(){
        let searchHistory = Table("search_history")
        let searchText = Expression<String>("search_text")
        let searchDate = Expression<Date>("search_date")
  
        do{
            try database.run(searchHistory.create(ifNotExists: true) { table in
                table.column(searchText)
                table.column(searchDate)
         
            
            })

        }catch{print(error.localizedDescription)}
    }
    
    func insertUserAsData(_ user: User){
        let encoder = JSONEncoder()
        if let encoderUser = try? encoder.encode(user){
            insertInUserData(user: encoderUser)
        }
    }
 
    func insertInUserData(user: Data) {
        let insertUser = self.userTable.insert(self.userData <- user)
        do {
            try self.database.run(insertUser)
            print("User Added Successfully")
        } catch {
            print(error.localizedDescription)
            
        }
    }
 

    func getsDataFromSqlDB(mail:String)->User?{
        let users = try! self.database.prepare(self.userTable)
        for user in users{
            let user1 = user[self.userData]
            let decoder = JSONDecoder()
            if let userDecoder = try? decoder.decode(User.self, from: user1){
                if mail == userDecoder.mail{
                    return userDecoder
                }
            }
        }
        return nil
    }
  
    

}
