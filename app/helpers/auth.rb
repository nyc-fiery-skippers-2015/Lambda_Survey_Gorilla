def require_logged_in
  redirect('/login') unless is_authenticated?
end

def is_authenticated?
  return !!session[:user_id]
end

def current_user
  User.find_by(id: session[:user_id])
end

def my_time(timestamp)
  timestamp.strftime("%B %d, %Y %I:%M:%S")
end
