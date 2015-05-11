require 'sinatra'

class Sinatra::Application
  get('/:repo_name') do
    content_type 'text/csv'
    File.open "data/#{params['repo_name']}.csv"
  end
end
