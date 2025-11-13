class CheckinsController < ApplicationController
  def new; end

  def create
    q = params[:q].to_s.strip
    scope = Guest.includes(table: :guests)
    guest = scope.where("guests.name ILIKE ?", "%#{q}%").order(:name).first

    if guest
      redirect_to checkin_path(guest.id, q: q)
    else
      flash.now[:alert] = "No encontramos tu invitación. Probá con tu nombre/apellido."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @guest = Guest.includes(table: :guests).find(params[:id])
  end
end
