class HomeController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: :test_i18n
  # around_action :switch_locale

  def switch_locale(&action)
    locale = extract_locale_from_tld || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split(".").last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def new
  end

  def index
    redirect_to photos_path(type: "following") and return if user_signed_in?
  end

  def test_i18n
    posted_at = 10.minutes.ago
    render json: { 
      time: I18n.l(Time.current),
      trans_text: I18n.t("hello"),
      time_ago: "#{ActionController::Base.helpers.time_ago_in_words(posted_at, include_seconds: true)} trước"
    }, status: :ok
  end

  private
    def require_login
      unless user_signed_in?
        redirect_to "/auth/login"
        return
      end
    end
end