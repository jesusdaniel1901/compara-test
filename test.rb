# This class is used for logins
class Login
  attr_reader :sessions, :users

  # Receives a hash with usernames as keys and passwords as values
  def initialize(hash_of_users)
    @sessions = []
    @users = {}
    hash_of_users.map do |user,password|
      @users[user] = password
    end
  end

  def logout(user)
    session = sessions.find{ | session | session == user }
    sessions.delete(session)
  end

  # Checks if user exists
  def user_exists(user)
    @users.key?(user)
  end

  # Register user
  def register_user(user, password)
    @users[user] = password
    login(user,password)
  end

  def remove_user(user)
    logout(user)
    @users.delete(user)
  end

  def check_password(user, password)
    @users[user] == password
  end

  def update_password(user, old_password, new_password)
    return false if !@users.key?(user) || @users[user] != old_password
    @users[user] = new_password and return true
  end

  def login(user, password)
    return false unless @users.key?(user)
    sessions.push(user) and return true if @users[user] == password
  end
end



registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

login = Login.new(registered_users)

login.register_user('user4', 'pass4');

# puts "CHECK PASSWORD #{login.check_password('user4','pass4')}"
# puts "USER EXIST #{login.user_exists('user4')}"
puts "REMOVE USER #{login.remove_user('user2')}"


login.update_password('user3', 'pass3', 'pass5');
login.login('user3', 'pass5');
puts "LOGIN #{login.login('user4', 'pass4')} #{login.inspect}"
# login.logout('user4');
# puts "LOGOUT #{login.logout('user3')}"
# puts "session #{login.sessions.inspect}"


# puts("Registered Users: #{login.users}")
# puts("Registered Passwords: #{login.passwords}")
# puts("User -user1- exists? #{login.user_exists('user1222')}")
# puts("User -user7- exists? #{login.user_exists('user7')}")
# puts("Register -user9- pass: -pass9- #{login.register_user('user9', 'pass9')}")
# puts("LOGIN: #{login.inspect}")
# puts("User -user9- exists? #{login.user_exists('user9')}")
# puts("Change Password -user9- to -pass1000- #{login.update_password('user9', 'pass9', 'pass1000')}")
# puts("LOGIN: #{login.inspect}")
# puts("Login -user9- #{login.login('user9', 'pass1000')}")
# puts("LOGIN: #{login.inspect}")
# puts("Logout -user9- #{login.logout('user9')}")
# puts("LOGIN: #{login.inspect}")
# puts("Check password -user9- correct #{login.check_password('user9', 'pass1000')}")
# puts("Check password -user9- incorrect #{login.check_password('user9', 'pass9')}")
# puts("Remove User -user9- #{login.remove_user('user9')}")
# puts("LOGIN: #{login.inspect}")
