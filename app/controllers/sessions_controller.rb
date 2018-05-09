
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create


  def create
    github = GithubService.new

    session[:token] = github.authenticate!(ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_SECRET"], params[:code])

    github_authenticated = GithubService.new({"access_token" => sesion[:token]})
    session[:username] = github_authenticated.get_username

    redirect_to '/'
  end
end
