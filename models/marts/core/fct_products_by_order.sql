with orders_info as (
    select * from {{ ref('stg_orders') }}
),

order_items_info as (
    select * from {{ ref('stg_order_items') }}
),

products_by_order as (
    select
        o.order_id,
        oi.product_id,
        oi.product_quantity, 
        o.promo_id,
        o.user_id,
        o.address_id as shipping_address_id,
        o.shipping_service_id,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
--        o.order_created_at,
        o.tracking_id    
    
    from orders_info o join order_items_info oi
        on o.order_id = oi.order_id        
)


select * from products_by_order