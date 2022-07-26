module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def create
        user = User.new(user_params)
        if user.save
          response_success('Add New User Succeed', user, 201)
        else
          response_error('Add New User Failed', user.errors.full_messages)
        end
      end

      def update
        if @user.update(user_params)
          response_success('Update User Succeed', @user)
        else
          response_error('Update User Failed', @user.errors.full_messages)
        end
      end

      def destroy
        return unless @user.destroy

        response_success('Delete User Succeed')
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue StandardError
        response_error('User Error', 'Data not found')
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :birthday, :time_zone)
      end
    end
  end
end
