{{
    config(
        materialized='ephemeral',
        tags=['ephemeral']    
    )
}}

with order_info as (
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
        days_early_or_delay,
        order_status_valid_from,
        order_status_valid_to,
        _fivetran_synced    
    
    from {{ ref('stg_orders') }}
),

order_info_delay as (
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
        case  
            when days_early_or_delay = 0 then 'Correct estimated delivery'
            when days_early_or_delay > 0 then 'Delayed delivery'
            when delivered_at_date_id is null then 'Not delivered'  
            else 'Early delivery'
        end as delivery_info,
        case
            when days_early_or_delay < 0 then abs(days_early_or_delay)
            else null
        end as days_early,
        case
            when days_early_or_delay > 0 then days_early_or_delay
            else null
        end as days_of_delay,
        order_status_valid_from,
        order_status_valid_to,
        _fivetran_synced 

    from order_info
)

select * from order_info_delay