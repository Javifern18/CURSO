with base_orders as (
    select 
        {{ dbt_utils.surrogate_key(['order_id','status','_fivetran_synced']) }} as order_id,  -- ¿Merece la pena surrogate key con _fivetran_synced?     
        order_id as NK_order_id,
        nullif(promo_id,'') as NK_promo_id,
        nullif(shipping_service,'') as shipping_service,
        shipping_cost,
        estimated_delivery_at,
        address_id as NK_address_id,
        user_id as NK_user_id,
        status as order_status,
        order_cost,
        nullif(tracking_id,'') as tracking_id,   -- ¿Estaría bien crear una surrogate key para tracking_id?
        created_at as order_created_at,
        delivered_at,
        order_total,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "orders") }}
)

select * from base_orders
