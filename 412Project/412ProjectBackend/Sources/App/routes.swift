import Vapor

func routes(_ app: Application) throws {
    
    app.get("state") { req in
        state.query(on: req.db).all()
    }

    app.get("country") { req in
        country.query(on: req.db).all()
    }

    app.get("daystats") { req in
        daystats.query(on: req.db).all()
    }
    
    
}
