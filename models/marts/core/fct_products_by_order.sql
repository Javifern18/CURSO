{{
    config(
        materialized='incremental',
        tags=['incremental'] 
    )
}}

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
        oi.product_id,
        oi.product_quantity, 
        o.promo_id,
        o.user_id,
        o.shipping_address_id,
        o.shipping_service_id,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
        o.tracking_id,
        o._fivetran_synced        
    
    from orders_info o join order_items_info oi
        on o.order_id = oi.order_id        
)


select * from products_by_order

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}