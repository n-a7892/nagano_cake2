class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.order(id: :DESC)
  end

  def about
  end
end
