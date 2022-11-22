with stg_orders as (
    select md5(order_id) as order_id,
    order_id as NK_order_id,
    md5(nullif(promo_id,'')) as promo_id,
    nullif(promo_id,'') as NK_promo_id,
    nullif(shipping_service,'') as shipping_service,
    shipping_cost,
    estimated_delivery_at,
    md5(address_id) as address_id,
    address_id as NK_address_id,
    md5(user_id) as user_id,
    user_id as NK_user_id,
    status as order_status,
    order_cost,
    md5(tracking_id) as tracking_id,
    tracking_id as NK_tracking_id,
    delivered_at,
    order_total,
    _fivetran_deleted,
    _fivetran_synced

    from {{ source("sql_server_dbo", "orders") }}
)

select *
from stg_orders
