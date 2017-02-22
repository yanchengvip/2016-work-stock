json.status 'ok'
json.data do
	json.enshrines_list(@enshrines) do |enshrine|
	  json.id enshrine.ID
	  json.product_id enshrine.ProductID
	  json.product_name enshrine.product.Name
	  json.product_img enshrine.product.cover_url('v100')
	  json.product_price enshrine.product.ProductPrice
	end
end
