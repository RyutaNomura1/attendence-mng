class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_post_user, only: [:edit, :update, :destroy]
  before_action :define_big_categories, only: [:edit, :new, :index, :create, :update]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "#{@post.title}を投稿しました"
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def index
    unless logged_in?
      redirect_to top_path
    end
    # 投稿を表示用インスタンス変数
    define_lists_by_params
    #ページ右の最新質問用インスタンス変数
    @right_questions = Question.order(id: :DESC).first(5)
    # モーダルコメント作成用インスタンス変数
    @comment = Comment.new
    @lists = @lists.paginate(page: params[:page], per_page: 15)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "#{@post.title}を更新しました"
      redirect_to root_url
    else
      render "edit"
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
    params.require(:post).permit(:title, :body, :post_image, :location, category_ids: [])
  end
  
  def define_lists_by_params
    if params[:name]
      category = Category.find_by(name: params[:name])
      @lists = category.posts.sort {|a, b| b.id <=> a.id}
    elsif params[:big_category]
      categories = Category.where(big_category: params[:big_category])
      @lists = []
      categories.each do |category|
        @lists.push(*category.posts)
      end
    else
      users = current_user.followings
      @lists = []
      users.each do |user|
        @lists.push(*user.posts, *user.questions)
      end
      @lists.push(*current_user.posts, *current_user.questions)
      @lists.sort!{ |a, b| b.created_at <=> a.created_at }
    end
  end
  
  def define_big_categories
    @big_categories = []
    bc_names = %w(国内旅行 アジア オセアニア 北アメリカ ヨーロッパ その他)
    bc_names.each do |bc_name, i|
      i = Category.where(big_category: bc_name)
      @big_categories.push(i)
    end
  end
end