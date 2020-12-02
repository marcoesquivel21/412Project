import Vapor
import Fluent
import FluentPostgresDriver

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
    
    app.get("deleteCountry", ":name") {req -> String in country.query(on: req.db)
        .filter(\.$id == req.parameters.get("name") ?? "invalid")
        .delete()
        return req.parameters.get("name") ?? "invalid"
    }
    
    
    
    app.post("addState" , ":ab", ":cases", ":negInc", ":posInc", ":deaths", ":tests") { req -> EventLoopFuture<state> in
            let ab = req.parameters.get("ab") ?? "invalid"
            let cases = Int(req.parameters.get("cases") ?? "0")
            let negInc = Int(req.parameters.get("negInc") ?? "0")
            let posInc = Int(req.parameters.get("posInc") ?? "0")
            let deaths = Int(req.parameters.get("deaths") ?? "0")
            let tests = Int(req.parameters.get("tests") ?? "0")

            let tempState = state(abbreviation: ab, cases: cases, negativeIncrease: negInc, positiveIncrease: posInc, deaths: deaths, tests: tests)
            print(tempState)

            //return tempState

            return tempState.create(on: req.db).map {tempState}
        }
    
    app.post("addCountry" , ":name", ":tests", ":deaths", ":casesPerOneM", ":deathsPerOneM", ":active", ":critical", ":todayDeaths", ":testsPerOneM", ":todayCases", ":cases") { req -> EventLoopFuture<country> in
            let name = req.parameters.get("name") ?? "invalid"
            let tests = Int(req.parameters.get("tests") ?? "0")
            let deaths = Int(req.parameters.get("deaths") ?? "0")
            let casesPerOneM = Int(req.parameters.get("casesPerOneM") ?? "0")
            let deathsPerOneM = Int(req.parameters.get("deathsPerOneM") ?? "0")
            let active = Int(req.parameters.get("active") ?? "0")
            let critical = Int(req.parameters.get("critical") ?? "0")
            let todayDeaths = Int(req.parameters.get("todayDeaths") ?? "0")
            let testsPerOneM = Int(req.parameters.get("testsPerOneM") ?? "0")
            let todayCases = Int(req.parameters.get("todayCases") ?? "0")
            let cases = Int(req.parameters.get("cases") ?? "0")

            let tempCountry = country(name: name, tests: tests, deaths: deaths, casesPerOneMillion: casesPerOneM, cases: cases, active: active, critical: critical, todayDeaths: todayDeaths, deathsPerOneMillion: deathsPerOneM, testsPerOneMillion: testsPerOneM, todayCases: todayCases)
            print(tempCountry)

            //return tempState

            return tempCountry.create(on: req.db).map {tempCountry}
        }
    
    app.get("daystats", ":ab") { req -> EventLoopFuture<[daystats]> in
            let ab = req.parameters.get("ab") ?? "none"
            let stats = daystats.query(on: req.db).filter(\.$id == ab).all()
            return stats
        }
    
    app.get("updateCountry", ":name", ":tests", ":deaths", ":casesPerOneM", ":deathsPerOneM", ":active", ":critical", ":todayDeaths", ":testsPerOneM", ":todayCases", ":cases") { req -> EventLoopFuture<[country]> in
            let name = req.parameters.get("name") ?? "invalid"
            let tests = Int(req.parameters.get("tests") ?? "0")
            let deaths = Int(req.parameters.get("deaths") ?? "0")
            let casesPerOneM = Int(req.parameters.get("casesPerOneM") ?? "0")
            let deathsPerOneM = Int(req.parameters.get("deathsPerOneM") ?? "0")
            let active = Int(req.parameters.get("active") ?? "0")
            let critical = Int(req.parameters.get("critical") ?? "0")
            let todayDeaths = Int(req.parameters.get("todayDeaths") ?? "0")
            let testsPerOneM = Int(req.parameters.get("testsPerOneM") ?? "0")
            let todayCases = Int(req.parameters.get("todayCases") ?? "0")
            let cases = Int(req.parameters.get("cases") ?? "0")
            
            country.query(on: req.db)
                .set(\.$tests, to: tests)
                .set(\.$deaths, to: deaths)
                .set(\.$casesPerOneMillion, to: casesPerOneM)
                .set(\.$deathsPerOneMillion, to: deathsPerOneM)
                .set(\.$active, to: active)
                .set(\.$critical, to: critical)
                .set(\.$todayDeaths, to: todayDeaths)
                .set(\.$testsPerOneMillion, to: testsPerOneM)
                .set(\.$todayCases, to: todayCases)
                .set(\.$cases, to: cases)
                .filter(\.$id ~~ name)
                .update()
            
            let newCountry = country.query(on: req.db)
                .filter(\.$id == name).all()
            
            return newCountry
            
        }
    

}
