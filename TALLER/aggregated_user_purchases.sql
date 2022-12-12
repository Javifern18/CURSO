with users as (
    select * from {{ ref('dim_users_today') }}
),

orders as (
    select * from {{ ref('fct_products_by_order') }}
),

promos as (
    select * from {{ref('dim_promos')}}
),

info_total_orders as (
    select
        u.NK_user_id,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        u.address,
        u.zipcode,
        u.city,
        u.county,
        u.state,
        count(distinct o.order_id) as numb_of_total_orders,
        sum(o.product_quantity) as numb_of_total_products,
        round(sum(o.order_cost),2) as total_order_cost,
        round(sum(o.shipping_cost),2) as total_shipping_cost,
        sum(p.discount) as total_discount
        

from 
    users u left join orders o
        on u.user_id = o.user_id
            left join promos p
        on o.promo_id = p.promo_id

    {{dbt_utils.group_by(10)}}
        order by NK_user_id
)

select * from info_total_orders