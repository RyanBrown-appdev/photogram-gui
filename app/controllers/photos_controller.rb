class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all 

    @list_of_photos = matching_photos.order({ :created_at => :desc})
    render({ :template => "photo_templates/index.html.erb"})
  end

  def show
    input_username = params.fetch("path_id")
    m = Photo.where({ :id =>input_username })
    @the_photo = m.first

    if @the_photo == nil
      redirect_to("/404")
    else
      render({ :template => "photo_templates/show.html.erb" })
    end
  end

  def baii
     t = params.fetch("toast_id")
     m = Photo.where({ :id => t})
     the_photo = m.first
     the_photo.destroy
    redirect_to('/photos')
  end

  def create 
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new 
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id
    a_new_photo.save
    redirect_to("/photos/"+a_new_photo.id.to_s)
  end 
  def update

    the_id = params.fetch("modify_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    the_photo.image = input_image
    the_photo.caption = input_caption
    the_photo.save
    redirect_to("/photos/"+the_photo.id.to_s)
  end

  def create_c
    p_id = params.fetch("input_photo_id")
    a_id = params.fetch("input_author_id")
    comment = params.fetch("input_body")

    c = Comment.new
    c.body = comment
    c.author_id = a_id.to_i 
    c.photo_id =  p_id.to_i 
    c.save
    redirect_to("/photos/"+p_id)
  end 

end