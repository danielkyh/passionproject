enable :sessions

get '/' do
  if session[:id]
    redirect "/users/#{session[:id]}/tests"
  else
    erb :homepage
  end
end

get '/users/new' do
  erb :registration
end

post '/users' do
  #post for registration
  User.create(name: params[:name],age: params[:age], email: params[:email], password: params[:password])
  redirect '/'
end


post '/users/authenticate' do
  #post for login
  #check password - using bcrypt
  @user = User.find_by(email: params[:email])
  if @user.password == params[:password]
    session[:id] = @user.id
    session[:tries] = 0
    redirect "/users/#{@user.id}/tests"
  else
    redirect '/'
  end
end

get '/users/logout' do
  session.destroy
  redirect '/'
end

get '/users/:id/reset' do
  session[:line] = 1
  redirect "/users/#{params[:id]}/tests"
end

get '/users/:id/profile' do
  if session[:id] == params[:id].to_i
    @user = User.find(session[:id])
    erb :profile
  else
    redirect '/'
  end
end

get '/users/:id/profile/:type' do
  @type = params[:type]
  if session[:id] == params[:id].to_i
    @user = User.find(session[:id])
    erb :profile
  else
    redirect '/'
  end
end





