# pythonのbottleと同じ。rubyのsinatra
require 'bundler'
Bundler.require
#これは気にしないでください
require 'sinatra/reloader'

ActiveRecord::Base.configurations=YAML.load_file('db/database.yml')
ActiveRecord::Base.establish_connection(:development)


class Contact < ActiveRecord::Base

end
# sinatra::ContetFor

configure do
  set :public_folder, File.dirname(__FILE__) +  "/public"
end



#--------------------ここ以下から見てください-----------------------------------#
# get '/' do = @route("/")で
# erb :home = return template("list_tmpl", item_list=item_list)　と一緒
# erbはHTMLファイルと思ってくれて良いです。
get '/' do
  @title = 'パイナップルパーティーオキナワ新商品紹介'
  erb :ppo
end

get'/contact' do
  @title= 'contact'
  erb :finish
end

# 無記入でもデータ挿入されてページ遷移したので、そうならないようにした。もっと良い書き方ありそう。
post '/new'do
  @title ='お問い合わせページ'
  @name = params[:name]
  @email = params[:email]
  @tele = params[:tele]
  @address = params[:address]
  @body = params[:body]
  @all = @name + @email + @tele + @body

  contact = Contact.new do |c|
    c.name = @name
    c.email = @email
    c.tele = @tele
    c.address = @address
    c.body = @body
    if @all != ""
     c.save
    end
  end

  if @all == ""
      puts '入力してください'
      redirect '/'
  elsif contact.valid? && contact.save
    redirect '/contact'
  else
    redirect back
  end

end

post '/' do
  redirect '/'
end
