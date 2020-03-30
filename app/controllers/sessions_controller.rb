class SessionsController < ApplicationController
  def new
    
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ログインに成功しました'
      redirect_to root_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end
  
  private

  def login(email, password)
    #登録したメールアドレスと同じメールアドレスを探し@userに代入
    @user = User.find_by(email: email)
    #メールアドレスとパスワードが間違っていないか確認しそれぞれの処理を実行
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
