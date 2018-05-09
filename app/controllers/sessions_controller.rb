class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GitHubService.new
    session[:token] = github.authenticate!(ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET', params[:code]])
    authenticated = GitHubService.new({access_token: session[:token]})
    session[:username] = authenticated.get_username
    redirect_to '/'
  end
end
