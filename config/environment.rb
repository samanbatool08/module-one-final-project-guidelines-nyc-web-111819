require 'bundler'
Bundler.require # use bundler to requiew everything in the gemfile

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'app'