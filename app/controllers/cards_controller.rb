class CardsController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    # binding.pry
    # @posts = Post.where(params["genres"])
    genre_array = []
    params[:chk].each do | di1,di2 |
      # チェックボックスにチェックがついている場合
      # if di2 == "1"
        genre_array << di1
        # DBのtitleカラムにタイトルを格納し保存
        # @get_game.save
      # end
    end

    
    if params[:mode] == "2"
      @cards = Card.where(genres: genre_array).where(rank: 0..3).order("created_at DESC")
    else
      @cards = Card.where(deck_id: params[:deck_id],genres: genre_array).order("created_at DESC")
    end
    
    # @posts = Post.where(deck_id: params[:deck_id]).order("created_at DESC")


    # binding.pry
    # @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(10)
    # @posts = Post.find_by(params["genres"])

    respond_to do |format|
      format.html
      format.csv { send_data @cards.generate_csv, filename: "cards-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" } # --- ②
    end
  end

  def show
  end

  def new
    # binding.pry
    @card = Card.new
    @deck = Deck.where(user_id: current_user)
  end

  def create
    Card.create(question: card_params[:question], answer: card_params[:answer], user_id: current_user.id, deck_id: card_params[:deck_id])
    @quote = Quote.where( 'id >= ?', rand(Quote.first.id..Quote.last.id) ).first
    binding.pry
  end

  def edit
    @card = Card.find(params["id"])
  end

  def update
    card = Card.find(params["id"])
    if card.user_id == current_user.id
      card.title = params["cards"]["title"]
      card.body = params["cards"]["body"]
      card.save
      redirect_to "/"
    end
  end

  def destroy
    card = Card.find(params["id"])
    if card.user_id == current_user.id
      card.destroy
      redirect_to "/"
    end
  end

  def import
    current_user.cards.import(params[:file],params[:deck_id])
    redirect_to "/", notice: "タスクを追加しました"
  end


  def rankChange
    # binding.pry
    card = Card.find(params["id"]) 
    if card.user_id == current_user.id
      if params["rank"] == "max"
        card.rank = 10
      elsif params["rank"] == "up"
        # post.rank += 1 unless post.rank = 10
        card.rank += 1 

      else
        # post.rank -= 1 unless post.rank = 0
        card.rank -= 1 
      end
      card.save
      redirect_to cards_index_path
    end
  end


  def rankupmax
    # binding.pry
    post = Post.find(params["id"])
    if post.user_id == current_user.id
      post.rank = 10
      post.save
      redirect_to posts_index_path
    end
  end

  def rankup
    # binding.pry
    post = Post.find(params["id"])
    if post.user_id == current_user.id
      post.rank += 1
      post.save
      redirect_to posts_index_path
    end
  end

  def rankdown
    # binding.pry
    post = Post.find(params["id"])
    if post.user_id == current_user.id
      post.rank -= 1
      post.save
      redirect_to posts_index_path
    end
  end

  def set
    # binding.pry
    @test = Card.new
    @deck = Deck.where(user_id: current_user)
  end

  def search
    # binding.pry
    # @posts = Post.where(title: genre_array).order("created_at DESC").page(params[:page]).per(10)
    # @posts = Post.where("title like or body like '%人%'").order("created_at DESC").page(params[:page]).per(10)
    @cards = Card.ransack(title_or_body_cont: params[:keyword]).result.order("created_at DESC").page(params[:page]).per(10)
  end


  private
  def card_params
    params.require(:card).permit(:title, :body, :mode, :checkbox, :deck_id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
