require './config/environment'

if ActiveRecord::Migrator.needs_migration?

end

use UsersController
run ApplicationController
