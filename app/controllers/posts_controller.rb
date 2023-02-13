class PostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
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
    # コメント表示用
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
    if logged_in? 
      if params[:name]
        category = Category.find_by(name: params[:name])
        @lists = category.posts
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
        @lists.sort!{ |a, b| b.created_at <=> a.created_at }
      end
    else #ログインしていない場合全投稿を一覧する
      posts = Post.all
      questions = Question.all
      @lists =  posts | questions
      @lists.sort!{ |a, b| b.created_at <=> a.created_at }      
    end
  end
  
  def change_lists_if_logged_in
  end
  
  def define_big_categories
    domestic_categories = Category.where(big_category: "国内旅行")
    asia_categories = Category.where(big_category: "アジア") 
    oceania_categories = Category.where(big_category: "オセアニア")
    north_america_categories = Category.where(big_category: "北アメリカ")
    europe_categories = Category.where(big_category: "ヨーロッパ")
    other_categories = Category.where(big_category: "その他")
    @big_categories = [domestic_categories, asia_categories, oceania_categories,
                       north_america_categories, europe_categories, other_categories]
  end
end