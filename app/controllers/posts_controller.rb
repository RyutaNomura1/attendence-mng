class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "#{@post.title}を投稿しました"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def index
    @posts = Post.all.order(id: "DESC")
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を更新しました"
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image, :location)
  end
end