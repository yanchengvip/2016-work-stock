# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( events/invite.css events/invitation_letter.css vendors.css mobile.css vendors/base-min.css events/new_year.css events/women_s_day.css
                                                  vendors/picker.css events/hire2016.css events/weishu.css events/my_store.css events/anniversary.css pay_by_code.css
                                                  pc/index.css pc/product.css pc/help_center.css pc/login.css pc/account.css pc/second_page.css pc/screen.css pc/buy_car.css pc/zhifuc.css
                                                  pc/welcome.css pc/main.css pc/index_new.css pc/pc_new.css events/golden_egg.css events/golden_egg_history.css events/anniver_share_page.css
                                                  events/anniver_wechat.css map.css scan_product.css)

Rails.application.config.assets.precompile += %w( common.js vendors.js index.js session.js detail.js orders.js address.js carts.js shop_carts.js coupons.js my_orders.js product.js map.js
                                                  invite_event.js list.js invitation_letter.js rush.js search.js location.js events/new_year.js events/women_s_day.js mall.js events/hire2016.js
                                                  events/anniver_wechat.js events/weishu.js events/my_store.js events/festival.js events/anniversary.js mall/old_lottery.js mall/lottery.js mall/new_lottery.js
                                                  index_new.js vendors/jquery.lazyload.min.js pay_by_code.js
                                                  pc/index.js pc/com_show.js pc/layer.js pc/common.js pc/imgSlider.js pc/ciling.js pc/buycart_edit.js pc/tab.js pc/screen.js pc/area.js
                                                  pc/welcome.js pc/carts.js pc/handlebars.js events/golden_egg.js events/golden_egg_history.js	events/anniver_share_page.js events/anniver_wechat.js
                                                  barcode.js)
