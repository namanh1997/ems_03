module SessionsHelper
  def current_user? user
    user == current_user
  end

  def user_role role
    User.roles.key User.roles[role]
  end

  def supervisor_user?
    current_user.supervisor?
  end
end
