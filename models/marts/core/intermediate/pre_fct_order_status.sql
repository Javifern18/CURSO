
with order_status_info as (
    select 
        order_id,
        shipping_address_id,
        shipping_service_id,
        created_at,
        NK_tracking_id,
        order_status,
        estimated_delivery_at,
        delivered_at,
        delivery_info,
        days_early,
        days_of_delay,
        dbt_valid_from as order_status_valid_from,
        dbt_valid_to as order_status_valid_to
    
    from {{ ref('order_status_snapshot') }}
)

select * from order_status_info