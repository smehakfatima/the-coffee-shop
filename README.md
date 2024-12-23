# The Coffee Shop Online

## Prerequisites

1. Install rvm and nvm
2. Ruby installed (version 3.2.2)
3. Node v16.20.2

## Installing required dependencies

1. Use rvm gemset `rvm use ruby-3.2.2@coffee-shop --create`
2. Use node by using nvm `nvm use v16.20.2`
3. Install backend dependencies `bundle install`
4. Run `yarn`

## Setting up the app

1. run `rails db:setup`

## Start the Rails server

1. `rails server` to run rails server
2. The application should now be accessible at `http://localhost:3000`
3. Navigate to  `http://localhost:3000/admin` for admin panel
4. Use admin@gmail.com password as password to login to admin panel
