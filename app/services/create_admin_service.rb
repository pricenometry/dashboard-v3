class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.configuration.config[:admin][:email]) do |user|
      user.password = Rails.configuration.config[:admin][:password]
      user.password_confirmation = Rails.configuration.config[:admin][:password]
      user.admin!
    end
  end
end
