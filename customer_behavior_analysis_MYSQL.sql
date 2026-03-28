use customer_behavior;
select * from customer limit 20;
# Total revenue by male vs female
select gender, SUM(purchase_amount) as total_revenue from customer group by gender;
# Customers who used discount but spent more than average
select customer_id,purchase_amount from customer where discount_applied = 'Yes' and purchase_amount > (select avg(purchase_amount) from customer);
# Top 5 products by highest average rating
select item_purchased, avg(review_rating) as avg_rating from customer group by item_purchased order by avg_rating desc limit 5;
# Avg purchase: Standard vs Express shipping
select shipping_type, avg(purchase_amount) as avg_purchase from customer where shipping_type in ("Standard","Express") group by shipping_type;
# Subscribers vs Non-subscribers (avg + total spend)
select subscription_status, avg(purchase_amount) as avg_spend, sum(purchase_amount) as total_revenue from customer group by subscription_status;
# Customer segmentation (New, Returning, Loyal)
select case when previous_purchases = 1 then "new" when previous_purchases between 5 and 10 then "returning" else "loyal" end as customer_segment, count(*) from customer group by customer_segment;
# Top 3 most purchased products in each category
select * from (select category, item_purchased, count(*) as total_orders, rank() over (partition by category order by count(*) desc) as item_rank from customer group by category, item_purchased) sub where iTem_rank <= 3;
# Are repeat buyers likely to subscribe?
select subscription_status,count(customer_id) as repeat_buyers from customer where previous_purchases > 5 group by subscription_status;
# Revenue contribution by age group
select age_group,sum(purchase_amount) as total_revenue from customer group by age_group order by total_revenue desc;