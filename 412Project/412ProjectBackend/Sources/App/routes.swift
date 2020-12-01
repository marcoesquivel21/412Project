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
    
    app.post("addState") { req -> EventLoopFuture<state> in
        let stateIn = try req.content.decode(state.self)
        return stateIn.create(on: req.db).map {stateIn}
    }
    
    app.post("addCountry") { req -> EventLoopFuture<country> in
        let countryIn = try req.content.decode(country.self)
        return countryIn.create(on: req.db).map {countryIn}
    }
}
