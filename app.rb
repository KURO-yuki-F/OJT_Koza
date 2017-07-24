# pythonのbottleと同じ。rubyのsinatra
require 'bundler'
Bundler.require
#これは気にしないでください
require 'sinatra/reloader'

ActiveRecord::Base.configurations=YAML.load_file('db/database.yml')
ActiveRecord::Base.establish_connection(:development)

module ppo do


  class Contact < ActiveRecord::Base

  end
  # sinatra::ContetFor

  configure do
    set :public_folder, File.dirname(__FILE__) +  "/public"
  end

  # helpers do
  #   def back_
  # end



  #--------------------ここ以下から見てください-----------------------------------#
  # get '/' do = @route("/")で
  # erb :home = return template("list_tmpl", item_list=item_list)　と一緒
  # erbはHTMLファイルと思ってくれて良いです。


  get '/ppo_okinawa' do
    @title = 'パイナップルパーティーオキナワ新商品紹介'
    erb :ppo
  end

  get'/form_complete' do
    @title= 'お問い合わせ完了'
    erb :form_complete
  end

  # 無記入でもデータ挿入されてページ遷移したので、そうならないようにした。もっと良い書き方ありそう。
  post '/new'do
    @title ='お問い合わせページ'
    @name_kj = params[:name_kj]
    @name_kt = params[:name_kt]
    @email = params[:email]
    @tele = params[:tele]
    @body = params[:body]

    @all = @name_kj + @name_kt + @email + @tele + @body

    contact = Contact.new do |c|
      c.name_kj = @name_kj
      c.name_kt = @name_kt
      c.email = @email
      c.tele = @tele
      c.body = @body
      if @all != ""
       c.save
      end
    end


    if @all == ""
        redirect '/ppo_okinawa'
    elsif contact.valid? && contact.save
      redirect '/form_complete'
    else
      redirect back
    end

    redirect_to hogehoge_path

  end

  post '/' do
    redirect '/'
  end


end
