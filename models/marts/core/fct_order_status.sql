{{
    config(
        materialized='incremental',
        unique_key=['NK_order_id'],
        tags=['incremental'] 
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
        _fivetran_synced    
    
    from {{ ref('int_order_status') }}
),

order_status_updated as (
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
        {{ dbt_utils.surrogate_key(['delivery_info', 'days_early','days_of_delay']) }} as delivery_info_id,
        _fivetran_synced    
    
    from order_status_info
)

select * from order_status_updated

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}