get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end
  
get '/signup' do

  # grab uesr input values from params
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  # if all user params are present
  if email.present? && avatar_url.present? && username.present? && password.present?

    # instantiate and save a User
    user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    user.save

    # return readable representation of User object
    escape_html user.inspect

  else

    # display simple error message
    "Validation failed."
  end


end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    "User #{username} saved!"
  else
    erb(:signup)
  end
end