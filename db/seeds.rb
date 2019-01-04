require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

#admin = create(:admin)
user = create(:user)
merchant_1 = create(:merchant)
merchant_2 = create(:merchant)
merchant_3 = create(:merchant)
merchant_4 = create(:merchant)
merchant_5 = create(:merchant)

#inactive_merchant_1 = create(:inactive_merchant)
#inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
item_5 = create(:item, user: merchant_5)

item_6 = create(:item, user: merchant_3)

#create_list(:item, 10, user: merchant_1)

#inactive_item_1 = create(:inactive_item, user: merchant_1)
#inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

#Random.new_seed
#rng = Random.new

#ORDERS WITH OIs COMPLETED LAST MONTH
order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 5, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
#Extra item for merchant 3
create(:fulfilled_order_item, order: order, item: item_6, price: 5, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
#Extra item for merchant 3
create(:fulfilled_order_item, order: order, item: item_6, price: 5, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
#Extra item for merchant 3
create(:fulfilled_order_item, order: order, item: item_6, price: 5, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

#ORDERS PENDING -- All crediting merchant 4
order = create(:order, user: user)
create(:order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:order, user: user)
create(:order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:order, user: user)
create(:order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:order, user: user)
create(:order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

#ORDERS THAT DON'T COUNT FROM LAST MONTH
order = create(:cancelled_order, user: user)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:cancelled_order, user: user)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:cancelled_order, user: user)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:cancelled_order, user: user)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)

order = create(:cancelled_order, user: user)
create(:fulfilled_order_item, order: order, item: item_4, price: 1, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)
create(:fulfilled_order_item, order: order, item: item_5, price: 2, quantity: 1, created_at: 30.days.ago, updated_at: 28.days.ago)


#ORDERS WITH OIs COMPLETED THIS MONTH
order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_5, price: 1, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 2, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 4, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_1, price: 5, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_5, price: 1, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 2, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_2, price: 4, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_5, price: 1, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 2, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_5, price: 1, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order, item: item_4, price: 2, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_5, price: 1, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
