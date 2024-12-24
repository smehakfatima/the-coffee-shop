# Use the official Ruby image from Docker Hub
FROM ruby:3.2-slim

# Set the working directory in the container
WORKDIR /app

# Install dependencies for Rails and SQLite
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  nodejs \
  yarn

# Install Rails
RUN gem install rails -v 8.0

# Install required gems (dependencies) for the Rails app
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the entire application code into the container
COPY . .

# Precompile assets (optional but recommended for production)
RUN rails assets:precompile

# Expose port 3000 to the host machine
EXPOSE 3000

# Start the Rails application when the container runs
CMD ["rails", "server", "-b", "0.0.0.0"]
