require 'rubygems'
require 'sinatra'
require 'rack'
require 'digest/md5'
require 'sdbm'

module Gyazo
  class Controller < Sinatra::Base

    configure do
      set :dbm_path, 'db/id'
      set :image_dir, 'public/images'
      set :image_url, 'http://localhost:8080/images'
    end

    post '/gyazo' do
      id = request[:id]
      data = request[:imagedata][:tempfile].read
      hash = Digest::MD5.hexdigest(data).to_s
      dbm = SDBM.open(options.dbm_path, 0644)
      dbm[hash] = id
      File.open("#{options.image_dir}/#{hash}.png", 'w'){|f| f.write(data)}

      "#{options.image_url}/#{hash}.png"
    end

    post '/' do
      data = request[:data][:tempfile].read
      hash = Digest::MD5.hexdigest(data).to_s
      File.open("/tmp/#{hash}.mp4", 'w'){|f| f.write(data)}
      ret = system("sh /Users/takc923/Workspace/gyazo-sinatra/convert_mp4togif.sh #{hash}")

      "#{options.image_url}/#{hash}.gif"
    end
  end
end
