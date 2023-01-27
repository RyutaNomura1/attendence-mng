class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "#{@post.title}を投稿しました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end
  
  def index
    @posts = Post.all.order(id: "DESC")
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を削除しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def destroy
    post = post.find(params[:id])
    post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to user_path(post.user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image, :locatio)
  end
end