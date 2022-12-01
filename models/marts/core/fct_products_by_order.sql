with orders_info as (
    select * from {{ ref('stg_orders') }}
),

order_items_info as (
    select * from {{ ref('stg_order_items') }}
),

products_by_order as (
    select
        {{ dbt_utils.surrogate_key(['o.order_id','oi.order_items_id']) }} as products_by_order_id,
        o.order_id,
        o.NK_order_id,
        oi.product_id,
        oi.NK_product_id,
        oi.product_quantity, 
        o.promo_id,
        o.NK_promo_id,
        o.user_id,
        o.NK_user_id,
        o.address_id as shipping_address_id,
        o.shipping_service_id,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
--        o.order_created_at,
        o.tracking_id
--        o._fivetran_synced 
--        oi._fivetran_synced
-- HACER INCREMENTAL CON USANDO _FIVETRAN_SYNCED            
    
    from orders_info o join order_items_info oi
        on o.order_id = oi.order_id        
)


select * from products_by_order