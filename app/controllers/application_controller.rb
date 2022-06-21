class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller? #deviseに関するコントローラーの処理の場合にメソッドを実行する

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  #sign_upの処理の許可
  def configure_permitted_parameters #メソッド名は慣習
    # deviseのUserモデルにパラメーターを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
    # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
  end
end
