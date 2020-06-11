class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def current_ability
    @current_ability ||= GroupAbility.new(current_user)
  end

  def index
    render json: @groups
  end

  def show
    render json: @group
  end

  def create
    @group = Group.new(group_params)
    @group.created_by = current_user
    @group.users << current_user
    @group.save!
    render json: @group
  rescue => error
    render json: { error: error }, status: 422
  end

  def update
    @group.update(group_params)
    render json: @group
  rescue => error
    render json: { error: error }, status: 422
  end

  def destroy
    render json: @group.delete
  end

  def users
    render json: @group.users
  end

  def books
    render json: @group.books.uniq
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

end
