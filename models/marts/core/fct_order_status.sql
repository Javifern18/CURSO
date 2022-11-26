-- ACCUMULATING SNAPSHOT

with fct_order_status_accumulating_snapshot as (

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
        days_of_delay

    from {{ ref('pre_fct_order_status') }}
    where order_status_valid_to is null

)

select * from fct_order_status_accumulating_snapshot