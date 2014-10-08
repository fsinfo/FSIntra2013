Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")

Rails.application.config.assets.precompile += %w( gumby/fonts/icons/entypo.eot )
Rails.application.config.assets.precompile += %w( gumby/fonts/icons/entypo.woff )
Rails.application.config.assets.precompile += %w( gumby/fonts/icons/entypo.ttf )
