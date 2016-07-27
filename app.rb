require 'sinatra'
require 'redcarpet'
require 'fileutils'

def read_slides
    IO.read("slides.md")
end

get '/' do
    erb :view, :locals => { :slides => markdown(read_slides()) }   
end

get '/edit' do
    erb :edit, :locals => { :slides => read_slides() }
end

post '/edit' do
    IO.write("slides.md", params['slides'])
    redirect to('/')
end

get '/reset' do
    FileUtils.copy("slides.bak", "slides.md")
    redirect to('/')
end

