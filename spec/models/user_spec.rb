require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

RSpec.describe "User Registrations", type: :request do
  let(:valid_attributes) do
    {
      user: {
        fname: "John",
        lname: "Doe",
        email: "test_#{Time.now.to_i}@example.com", # Tránh trùng lặp email
        password: "Password123!", # Phải có hoa, thường, số, ký tự đặc biệt
        password_confirmation: "Password123!"
      }
    }
  end

  describe "POST /users" do
    context "với thông tin hợp lệ" do
      it "tạo một User mới và chuyển hướng" do
        expect {
          post user_registration_path, params: valid_attributes
        }.to change(User, :count).by(1)
        
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        # expect(response.body).to include("Welcome! You have signed up successfully.")
      end
    end

    context "với thông tin không hợp lệ" do
      it "không tạo User và hiển thị lỗi" do
        invalid_attributes = valid_attributes
        invalid_attributes[:user][:email] = ""
        arr1 = []
        arr2 = []
        expect(arr1).to eq(arr2)
        expect {
          post user_registration_path, params: invalid_attributes
        }.not_to change(User, :count)
        puts response.body
        expect(response.body).to include("is required")
      end
    end
  end
end