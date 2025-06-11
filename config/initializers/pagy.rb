# Require Pagy
require "pagy"
require "pagy/backend"
require "pagy/frontend"

# Pagy initializer file (6.0+)
# Customize only what you really need and notice that the core Pagy works also without any of the following lines.
# Should you just cherry pick part of this file, please maintain the require-order of the extras

# Pagy DEFAULT Variables
# See https://ddnexus.github.io/pagy/docs/api/pagy#variables
# All the Pagy::DEFAULT are set for all the Pagy instances but can be overridden per instance by just passing them to
# Pagy.new(count:..., items:...) or the #pagy controller method

# Instance variables
# See https://ddnexus.github.io/pagy/docs/api/pagy#instance-variables
Pagy::DEFAULT[:items] = 12        # items per page
Pagy::DEFAULT[:size]  = [ 1, 4, 4, 1 ] # nav bar links
# Pagy::DEFAULT[:page_param] = :page    # page param name
# Pagy::DEFAULT[:params] = {}           # params for links
# Pagy::DEFAULT[:fragment] = '#fragment' # final fragment string
# Pagy::DEFAULT[:link_extra] = 'data-remote="true"' # extra attributes for links
# Pagy::DEFAULT[:i18n_key] = 'pagy.item_name'       # i18n key
# Pagy::DEFAULT[:cycle] = true                      # cycle on/off

# Extras
# See https://ddnexus.github.io/pagy/docs/extras

# Backend Extras

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/docs/extras/array
# require 'pagy/extras/array'

# Countless extra: Paginate without any count, saving one query per rendering
# See https://ddnexus.github.io/pagy/docs/extras/countless
# require 'pagy/extras/countless'
# Pagy::DEFAULT[:countless_minimal] = false   # default (eager-loading)

# Elasticsearch Rails extra: Paginate `ElasticsearchRails::Results` objects
# See https://ddnexus.github.io/pagy/docs/extras/elasticsearch_rails
# require 'pagy/extras/elasticsearch_rails'

# Searchkick extra: Paginate `Searchkick::Results` objects
# See https://ddnexus.github.io/pagy/docs/extras/searchkick
# require 'pagy/extras/searchkick'
# Pagy::DEFAULT[:searchkick_pagy_search] = :pagy_search

# Frontend Extras

# Bootstrap extra: Add nav, nav_js and combo_nav_js helpers and templates for Bootstrap pagination
# See https://ddnexus.github.io/pagy/docs/extras/bootstrap
require "pagy/extras/bootstrap"

# Bulma extra: Add nav, nav_js and combo_nav_js helpers and templates for Bulma pagination
# See https://ddnexus.github.io/pagy/docs/extras/bulma
# require 'pagy/extras/bulma'

# Foundation extra: Add nav, nav_js and combo_nav_js helpers and templates for Foundation pagination
# See https://ddnexus.github.io/pagy/docs/extras/foundation
# require 'pagy/extras/foundation'

# Materialize extra: Add nav, nav_js and combo_nav_js helpers and templates for Materialize pagination
# See https://ddnexus.github.io/pagy/docs/extras/materialize
# require 'pagy/extras/materialize'

# Navs extra: Add nav_js and combo_nav_js javascript helpers
# Notice: the other frontend extras add their own framework-styled versions,
# so require this extra only if you need the unstyled version
# See https://ddnexus.github.io/pagy/docs/extras/navs
# require 'pagy/extras/navs'

# Semantic extra: Add nav, nav_js and combo_nav_js helpers and templates for Semantic UI pagination
# See https://ddnexus.github.io/pagy/docs/extras/semantic
# require 'pagy/extras/semantic'

# UIkit extra: Add nav, nav_js and combo_nav_js helpers and templates for UIkit pagination
# See https://ddnexus.github.io/pagy/docs/extras/uikit
# require 'pagy/extras/uikit'

# Multi size var used by the *_nav_js helpers
# See https://ddnexus.github.io/pagy/docs/extras/navs#steps
# Pagy::DEFAULT[:steps] = { 0 => [2,3,3,2], 540 => [3,5,5,3], 720 => [5,7,7,5] }

# Feature Extras

# Headers extra: http response headers (and other helpers) useful for API pagination
# See http://ddnexus.github.io/pagy/extras/headers
# require 'pagy/extras/headers'
# Pagy::DEFAULT[:headers] = { page: 'Current-Page',
#                            items: 'Page-Items',
#                            count: 'Total-Count',
#                            pages: 'Total-Pages' }

# Support extra: Extra support for features like: incremental, infinite, auto-scroll pagination
# See https://ddnexus.github.io/pagy/docs/extras/support
# require 'pagy/extras/support'

# Items extra: Allow the client to request a custom number of items per page with an optional selector UI
# See https://ddnexus.github.io/pagy/docs/extras/items
# require 'pagy/extras/items'
# set to false only if you want to make :enable_items_extra an opt-in variable
# Pagy::DEFAULT[:enable_items_extra] = false    # default true
# Pagy::DEFAULT[:max_items] = 100               # default

# Overflow extra: Allow for easy handling of overflowing pages
# See https://ddnexus.github.io/pagy/docs/extras/overflow
# require 'pagy/extras/overflow'
# Pagy::DEFAULT[:overflow] = :empty_page    # (other options: :last_page and :exception)

# Metadata extra: Provides the pagination metadata to Javascript frameworks like Vue.js, react.js, etc.
# See https://ddnexus.github.io/pagy/docs/extras/metadata
# require 'pagy/extras/metadata'
# For performance reasons, you should explicitly set ONLY the metadata you use in the frontend
# Pagy::DEFAULT[:metadata] = [:scaffold_url, :count, :page, :prev, :next, :last]    # example

# Trim extra: Remove the page=1 param from links
# See https://ddnexus.github.io/pagy/docs/extras/trim
require "pagy/extras/trim"

# Standalone extra: Use pagy in non Rack environment/gem
# See https://ddnexus.github.io/pagy/docs/extras/standalone
# require 'pagy/extras/standalone'
# Pagy::DEFAULT[:url] = 'http://www.example.com/subdir'  # optional default

# Rails
# Enable the .js file required by the helpers that use javascript
# (pagy*_nav_js, pagy*_combo_nav_js, and pagy_items_selector_js)
# See https://ddnexus.github.io/pagy/docs/api/javascript

# With the asset pipeline
# Sprockets need to look into the pagy gem folder in order to find the javascript file to serve
# Rails.application.config.assets.paths << Pagy.root.join('javascripts')

# I18n

# Pagy internal I18n: ~18x faster using ~10x less memory than the i18n gem
# See https://ddnexus.github.io/pagy/docs/api/i18n
# Notice: No need to configure anything in this section if your app uses only "en"
# or if you use the i18n extra below

# Examples:
# load the "de" built-in locale:
# Pagy::I18n.load(locale: 'de')
#
# load the "de" locale defined in the custom file at :filepath:
# Pagy::I18n.load(locale: 'de', filepath: 'path/to/pagy-de.yml')
#
# load the "de", "en" and "es" built-in locales:
# (the first passed :locale will be used also as the default_locale)
# Pagy::I18n.load({ locale: 'de' },
#                 { locale: 'en' },
#                 { locale: 'es' })
#
# load the "en" built-in locale, a custom "es" locale,
# and a totally custom locale complete with a custom :pluralize proc:
# (the first passed :locale will be used also as the default_locale)
# Pagy::I18n.load({ locale: 'en' },
#                 { locale: 'es', filepath: 'path/to/pagy-es.yml' },
#                 { locale: 'xyz',  # not built-in
#                   filepath: 'path/to/pagy-xyz.yml',
#                   pluralize: lambda{ |count| ... } )

# I18n extra: uses the standard i18n gem which is ~18x slower using ~10x more memory
# than the default pagy internal i18n (see above)
# See https://ddnexus.github.io/pagy/docs/extras/i18n
# require 'pagy/extras/i18n'

# Default i18n key
# Pagy::DEFAULT[:i18n_key] = 'pagy.item_name'   # default
