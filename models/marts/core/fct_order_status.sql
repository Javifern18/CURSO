-- ACCUMULATING SNAPSHOT
{{
    config(
        materialized='incremental'
    )
}}

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
        days_of_delay,
        order_status_valid_from

    from {{ ref('pre_fct_order_status') }}
    where order_status_valid_to is null

)

select * from fct_order_status_accumulating_snapshot

{% if is_incremental() %}

  where order_status_valid_from > (select max(order_status_valid_from) from {{ this }})

{% endif %}

-- ¿¿No se puede quitar de alguna manera el campo de order_status_valid_from de manera que siga siendo incremental??