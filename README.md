# swapp

## Project Overview
swapp is a web application that helps SWAP (Severe Weather Action Plan) caseworkers perform intake for people experiencing homelessness, so that they can find shelter during periods of inclement weather.

## Setup Instructions

### Environment Setup
First, install the following:

1. [Ruby](https://www.ruby-lang.org/en/documentation/installation) - This project uses version `2.7.2`. You can use [rbenv](https://github.com/rbenv/rbenv) to easily manage your local ruby version: `rbenv install 2.7.2` 
1. [Ruby on Rails](https://guides.rubyonrails.org/v5.0/getting_started.html#installing-rails)
1. [Node.JS and npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#checking-your-version-of-npm-and-node-js)
1. [postgres](https://www.postgresql.org/download/)

### Set up the repo
1. Within your terminal, clone this repo to your local machine: `git clone git@github.com:mostlyerror/swapp.git`
1. `cd swapp`
1. Install Ruby gems: `bundle install`

### Install Tailwind CSS v2.0
1. Install some node packages to provide the best CSS compatibility possible. Run `npm install tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9`

### Set up the database
1. Run the following:
    - `rails db:create`
    - `rails db:migrate` - this runs all of the migrations listed in `db/migrate`
    - `rails db:seed` - this runs the seed script (`db/seeds.rb`), which loads the app's seed data


### API Keys

In order to send vouchers electronically, obtain credentials by creating accounts with [Twilio](https://www.twilio.com/) and [SendGrid](https://sendgrid.com/)


Once you have those set up: 
- Create a `.env` file in the project's root directory (if not already present).
- Then open your `.gitignore` file and add `.env`. 
- Open your `.env` file and add the following:
```
TWILIO_SID=YOUR_TWILIO_SID
TWILIO_TOKEN=YOUR_TWILIO_TOKEN
TWILIO_NUMBER=YOUR_TWILIO_NUMBER
SENDGRID_API_KEY=YOUR_API_KEY
```

> :warning: :warning: ***Double check that `.env` has been added to your .gitignore file to avoid uploading sensitive data. DO NOT UPLOAD YOUR .ENV FILE TO GITHUB*** :warning: :warning:

### Development Credentials

You can read more about them [here](https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336).

Essentially, you can run `EDITOR=vim rails credentials:edit` to open your encrypted credentials file. Once you save it, a `config/master.key` file will be available, which is the file you will need to modify your credentials in the future. Keep track of the contents of this file because you will need to generate a new one if you lose it (and add any secrets).


### Run the app
1. Run `rails server` to start the app
1. Navigate to `http://localhost:3000` to view 

## How to contribute

1. Make sure you have pulled down the latest version of `main`. Run `git pull`
1. After you make your code changes, create and checkout a new branch, e.g. `git checkout -b update-swap-factory`
1. Run `git branch` to make sure you are on the branch you just created (not `main`!)
1. Stage the files that you wish to commit, e.g. `git add test/factories/swaps.rb`
1. Commit the files that you staged, e.g. `git commit -m "update swap factory"`
1. Push your changes, e.g. `git push origin update-swap-factory` 
1. Open a pull request on github and assign a reviewer.
1. Once the review has been completed and the PR is approved, you can merge the commit with "Squash and Merge."
1. After merging, you can delete the branch.

## Deployment Instructions
TODO: Heroku setup, pipeline configuration, etc.
