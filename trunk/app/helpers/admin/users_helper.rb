module Admin::UsersHelper
  def role_list
    Role.all.map { |role| role.name[0..2] }.join('/')
  end
  
  def check_roles(user)
    returning([]) do |arr|
      Role.all.each do |role|
        arr << check_box_tag("role", "1", user.has_role?(role), :onclick => toggle_value(user, role) )
      end
    end.join(' / ')
  end
  
  def select_state(user)
    select "user", "state", user.aasm_events_for_current_state, { :include_blank => user.state },
           :onchange => change_state(user)
  end
  
  private

  def toggle_value(user, role)
    remote_function :url => user_role_path(user, role), :method => :put,
                    :with => "this.name + '=' + this.checked",
                    :before => "$('#indicator').show()", 
                    :complete => "$('#indicator').hide()"
  end
  
  def change_state(user)
    remote_function :url => "#{user_path(user.id)}/' + this.options[this.selectedIndex].value, dummy:'", 
                    :method => :put, 
                    :with => "this.name + '=' + this.options[this.selectedIndex].value",
                    :update => "user_#{user.id}_state",
                    :before => "$('#indicator').show()", 
                    :complete => "$('#indicator').hide()"
  end
  
end
