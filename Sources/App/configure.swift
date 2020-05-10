import FluentMySQL
import Vapor
import Leaf
import Authentication
/// Called before your application initializes.


    public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
        // Register providers first
        try services.register(FluentMySQLProvider())
        try services.register(LeafProvider())
        try services.register(AuthenticationProvider())
        
        // Register routes to the router
        let router = EngineRouter.default()
        try routes(router)
        services.register(router, as: Router.self)
        
        // Register middleware
        var middlewares = MiddlewareConfig() // Create _empty_ middleware config
        // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
        middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
        services.register(middlewares)
        
        let databaseConfig = MySQLDatabaseConfig(hostname: "localhost",  username: "han", password: "password", database: "vapor")
        let database = MySQLDatabase(config: databaseConfig)
        
        // Register the configured SQLite database to the database config.
        var databases = DatabasesConfig()
        databases.add(database: database, as: .mysql)
        services.register(databases)
        
        // Configure migrations
        var migrations = MigrationConfig()
        migrations.add(model: AirPlane.self, database: .mysql)
        migrations.add(model: AirPort.self, database: .mysql)
        migrations.add(model: AirCompany.self, database: .mysql)
        migrations.add(model: City.self, database: .mysql)
        migrations.add(model: AirPortCityPivot.self, database: .mysql)
        migrations.add(model: Token.self, database: .mysql)
        services.register(migrations)
        
        
        config.prefer(LeafRenderer.self, for: ViewRenderer.self)
        config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
    }


