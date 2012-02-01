class CombineItemsInCart < ActiveRecord::Migration
  def up
    #カート内に１つの商品に対して複数の品目があった場合、１つの品目に置き換える
    Cart.all.each do |cart|
      #カート内の各商品の個数をカウントする
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          #個別の品目を削除
          cart.line_items.where(product_id: product_id).delete_all

          #1つの品目に置き換える
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end
      end
    end
  end

  def down
  end
end
