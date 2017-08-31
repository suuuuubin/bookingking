class MailController < ApplicationController
  def list
    @my = Post.where(receiver_id: current_user.id)
  end

  def read
    @post = Post.find(params[:id])
    @post.checked = true
    @post.save
  end

  def delete
    post = Post.find(params[:id])
    
    post.destroy
    redirect_to '/mail/list'
  end

end
