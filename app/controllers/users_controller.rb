class UsersController < ApplicationController
  def index
    matching_users = User.all 
    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "user_templates/index.html.erb"})
  end

  def show
    input_username = params.fetch("path_username")
    m = User.where({ :username =>input_username })
    @the_user = m.first

    if @the_user == nil
      redirect_to("/404")
    else
      render({ :template => "user_templates/show.html.erb" })
    end
  end

  def create 
    u_name = params.fetch("input_username")
    if User.where({ :username =>u_name }).length < 1
      user = User.new
      user.username = u_name
      user.save
      redirect_to("/users/"+user.username) 
    else
      redirect_to("/users")
    end
  end

  def update
    the_name = params.fetch("gg")
    the_id = params.fetch("user_id")
    matching_name = User.where({ :id => the_id })
    the_user = matching_name.at(0)
    the_user.username = the_name
    the_user.save
    redirect_to("/users/"+the_user.username)
  
  end

end
