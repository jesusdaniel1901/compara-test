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
  def user_exists?(user)
    @users.key?(user)
  end

  # Register user
  def register_user(user, password)
    return false if user_exists?(user)
    @users[user] = password
    login(user,password) and return true
  end

  def remove_user(user)
    logout(user)
    @users.delete(user)
  end

  def check_password?(user, password)
    @users[user] == password
  end

  def update_password(user, old_password, new_password)
    return false if user_exists?(user) || !check_password?(user,old_password)
    @users[user] = new_password and return true
  end

  def login(user, password)
    return false unless user_exists?(user)
    sessions.push(user) and return true if check_password?(user,password)
  end
end



registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

login = Login.new(registered_users)

login.register_user('user4', 'pass4');
login.update_password('user3', 'pass3', 'pass5');
login.login('user3', 'pass5');
