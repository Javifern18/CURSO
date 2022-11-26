{% snapshot order_status_snapshot %}

{{
    config(
      unique_key='NK_order_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

with order_info as (
    select
        order_id,
        NK_order_id,
        address_id as shipping_address_id,
        shipping_service_id,
        created_at,
        NK_tracking_id,
        order_status,
        estimated_delivery_at,
        delivered_at,
        to_date(delivered_at) - to_date(estimated_delivery_at) as days_early_or_delay,
        _fivetran_synced    
    
    from {{ ref('stg_orders') }}
),

order_info_delay as (
    select
        order_id,
        NK_order_id,
        shipping_address_id,
        shipping_service_id,
        created_at,
        NK_tracking_id,
        order_status,
        estimated_delivery_at,
        delivered_at, 
        case  
            when days_early_or_delay = 0 then 'Correct estimated delivery'
            when days_early_or_delay > 0 then 'Delayed delivery'
            when delivered_at is null then 'Not delivered'  
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
        _fivetran_synced 

    from order_info
)

select * from order_info_delay

{% endsnapshot %}