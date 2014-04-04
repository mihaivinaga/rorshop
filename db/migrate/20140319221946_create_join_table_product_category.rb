class CreateJoinTableProductCategory < ActiveRecord::Migration
  def change
    create_join_table :products, :categories do |t|
      t.index [:product_id, :category_id], :unique => true
      # t.index [:category_id, :product_id]
    end
  end
end