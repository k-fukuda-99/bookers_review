class BooksController < ApplicationController
  def new
  end

  def index
    #投稿一覧画面に投稿画面も表示する
    @book = Book.new
    #新規投稿したものは全て表示させる
    @books = Book.all
  end

  def create
    #データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    #データを保存させる為のメソッド
    if @book.save
    #リダイレクト先は投稿詳細画面
      redirect_to book_path(@book.id)
    else
      render 'index'
    end
  end

  def show
    #レコードを1件取得させる
    @book = Book.find(params[:id])
    #フラッシュメッセージ
    flash.now[:notice] = 'Book was successfully update'
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    #レコードを1件取得させる
    @book = Book.find(params[:id])
    #データを更新するメソッド
    if @book.update(book_params)
      #フラッシュメッセージ
      flash.now[:notice] = 'Book was successfully update'
      #リダイレクト先は投稿詳細画面
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    #フラッシュメッセージ
    flash.now[:notice] = 'Book was successfully destroyed.'
    redirect_to books_path
  end

  private
  #ストロングパラメータ(マスアサインメント脆弱性)
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
