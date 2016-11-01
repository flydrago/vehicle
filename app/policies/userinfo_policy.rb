class UserinfoPolicy < ApplicationPolicy

  def new?

    @current_user.has_role? :userinfo_admin
  end

  def create?

    @current_user.has_role? :userinfo_admin
  end

  def edit?

    (@current_user.has_role? :userinfo_admin) || (@current_user.has_role?(:system_management) && @current_user['userinfo_id'].to_s==record.id.to_s)
  end

  def update?

    (@current_user.has_role? :userinfo_admin) || (@current_user.has_role?(:system_management) && @current_user['userinfo_id'].to_s==record.id.to_s)
  end

  def jyd_check?
    @current_user.has_role? :userinfo_admin
  end

  def jyd_check_out?
    @current_user.has_role? :userinfo_admin
  end
  def initialize_jxc?
    @current_user.has_role? :userinfo_admin
  end
end