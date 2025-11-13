class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy, :assign, :add_guest, :remove_guest]

  def index
    @tables = Table.order(:number)
  end

  def show; end

  def new
    @table = Table.new
  end

  def edit; end

  def create
    @table = Table.new(table_params)
    if @table.save
      redirect_to @table, notice: "Mesa creada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @table.update(table_params)
      redirect_to @table, notice: "Mesa actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @table.destroy
    redirect_to tables_path, notice: "Mesa eliminada."
  end

  # ====== Asignación de invitados ======

  # Vista donde ves asignados y sin mesa para agregar/quitar
  def assign
    @assigned   = @table.guests.order(:name)
    @unassigned = Guest.where(table_id: nil).order(:name)
  end

  # Agrega 1 invitado sin mesa a esta mesa
  def add_guest
    guest = Guest.find(params[:guest_id])

    # Control simple de capacidad
    if @table.used_seats >= @table.capacity
      redirect_to assign_table_path(@table),
                  alert: "La mesa está completa (#{@table.used_seats}/#{@table.capacity})." and return
    end

    guest.update!(table: @table)
    redirect_to assign_table_path(@table), notice: "#{guest.name} asignado a Mesa #{@table.number}."
  end

  # Quita 1 invitado de esta mesa (lo deja sin mesa)
  def remove_guest
    guest = @table.guests.find(params[:guest_id])
    guest.update!(table: nil)
    redirect_to assign_table_path(@table), notice: "#{guest.name} fue quitado de Mesa #{@table.number}."
  end

  private

    def set_table
      @table = Table.find(params[:id])
    end

    def table_params
      params.require(:table).permit(:number, :capacity, :notes)
    end
end
