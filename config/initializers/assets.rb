# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap-typehead.js )
# Rails.application.config.assets.precompile += %w( mention.js )
Rails.application.config.assets.precompile += %w( progressbar.js )

Rails.application.config.assets.precompile += %w( writing_manifest.js )

Rails.application.config.assets.precompile += %w( statistics_manifest.js )

Rails.application.config.assets.precompile += %w( landing.js )

Rails.application.config.assets.precompile += %w( typer.js )

Rails.application.config.assets.precompile += %w( rankings.js )

Rails.application.config.assets.precompile += %w( profile_page.js )

Rails.application.config.assets.precompile += %w( progressbar.js )
