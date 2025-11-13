# app/controllers/guests_controller.rb
class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :edit, :update, :destroy]

  def index
    @guests = Guest.includes(:table).order("tables.number NULLS LAST", "guests.name ASC")
  end

  def new
    @guest  = Guest.new
    @tables = Table.includes(:guests).order(:number)
  end

  def edit
    @tables = Table.includes(:guests).order(:number)
  end

  def create
    @guest  = Guest.new(guest_params)
    @tables = Table.includes(:guests).order(:number)
    if @guest.save
      redirect_to new_guest_path, notice: "Invitado agregado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @tables = Table.includes(:guests).order(:number)
    if @guest.update(guest_params)
      redirect_to @guest, notice: "Invitado actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @guest.destroy
    redirect_to guests_path, notice: "Invitado eliminado."
  end

  private
    def set_guest; @guest = Guest.find(params[:id]); end
    def guest_params; params.require(:guest).permit(:table_id, :name, :notes); end
end
