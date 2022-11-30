{{
    config(
        materialized='incremental'
    )
}}

with order_status_info as (
    select 
        order_id,
        NK_order_id,
        shipping_address_id,
        shipping_service_id,
        order_created_at_date_id,
        order_created_at_id,
        tracking_id,
        order_status,
        estimated_delivery_at_date_id,
        estimated_delivery_at_id,
        delivered_at_date_id,
        delivered_at_id,
        delivery_info,
        days_early,
        days_of_delay,
        dbt_valid_from as order_status_valid_from,
        dbt_valid_to as order_status_valid_to
    
    from {{ ref('order_status_snapshot') }}
),

order_status_updated as (
    select
        order_id,
        shipping_address_id,
        shipping_service_id,
        order_created_at_date_id,
        order_created_at_id,
        tracking_id,
        order_status,
        estimated_delivery_at_date_id,
        estimated_delivery_at_id,
        delivered_at_date_id,
        delivered_at_id,
        {{ dbt_utils.surrogate_key(['delivery_info', 'days_early','days_of_delay']) }} as delivery_info_id,
        order_status_valid_from
    
    from order_status_info
        where order_status_valid_to is null  
)

select * from order_status_updated

{% if is_incremental() %}

  where order_status_valid_from > (select max(order_status_valid_from) from {{ this }})

{% endif %}

-- Nico: añade condición... or order_status_valid_to > (select max(order_status_valid_from) from {{ this }}) ???
-- ¿¿No se puede quitar de alguna manera el campo de order_status_valid_from de manera que siga siendo incremental??