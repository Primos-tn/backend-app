require 'spec_helper'

describe RegistrationsController do
  render_views

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context "create" do
    before(:each) do
      @user_params = {
        email: "usermail@gmail.com",
        password: "AbCdEfGh9876",
        password_confirmation: "AbCdEfGh9876",
      }
    end

    it "should create new user" do
      assert_difference "User.count" do
        post :create, user: @user_params
      end

      user = User.find_by_cpf(@user_params[:cpf])
      expect(user).not_to be_nil
    end

    it "should create new company" do
      assert_difference "Company.count" do
        post :create, user: @user_params
      end

      user = User.find_by_cpf(@user_params[:cpf])
      expect(user.company).not_to be_nil
      expect(user.company.cnpj).to eq(@user_params[:company_attributes][:cnpj])
    end

    context "invalid user attributes" do
      before(:each) do
        @user_params[:email] = ""
      end

      it "should not create user nor company" do
        assert_no_difference "User.count" do
          assert_no_difference "Company.count" do
            post :create, user: @user_params
          end
        end
      end

      it "should display error messages in the view" do
        post :create, user: @user_params
        user = assigns(:user)
        expect(user.errors[:email]).to_not be_empty
        assert_select "div.field_error", html: user.errors[:email].first
      end
    end

    context "invalid company attributes" do
      before(:each) do
        @user_params[:company_attributes][:cnpj] = ""
      end

      it "should not create user nor company" do
        assert_no_difference "User.count" do
          assert_no_difference "Company.count" do
            post :create, user: @user_params
          end
        end
      end

      it "should display error messages in the view" do
        post :create, user: @user_params
        user = assigns(:user)
        expect(user.errors["company.cnpj"]).to_not be_empty
        assert_select "div.field_error", html: user.errors["company.cnpj"].first
      end
    end
  end
end
