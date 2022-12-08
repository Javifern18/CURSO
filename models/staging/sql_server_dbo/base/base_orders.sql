{{
    config(
        tags=['Views']
    )
}}

with orders as (
    select 
        {{ dbt_utils.surrogate_key(['order_id','status','_fivetran_synced']) }} as order_id,  
        order_id as NK_order_id,
        nullif({{ dbt_utils.surrogate_key(['promo_id'])}},'') as NK_promo_id,
        nullif(promo_id,'') as promo_name,
        nullif(shipping_service,'') as shipping_service,
        shipping_cost,
        {{timestamp_to_date_id('estimated_delivery_at')}} as estimated_delivery_at_date_id,
        to_date(estimated_delivery_at) as estimated_delivery_at_date,
        {{timestamp_to_time_id('estimated_delivery_at')}} as estimated_delivery_at_id, 
        to_time(estimated_delivery_at) as estimated_delivery_at,
        address_id as NK_address_id,
        user_id as NK_user_id,
        status as order_status,
        order_cost,
        nullif(tracking_id,'') as tracking_id,
        {{timestamp_to_date_id('created_at')}} as order_created_at_date_id,
        to_date(created_at) as order_created_at_date,
        {{timestamp_to_time_id('created_at')}} as order_created_at_id,  
        to_time(created_at) as order_created_at,
        {{timestamp_to_date_id('delivered_at')}} as delivered_at_date_id,
        to_date(delivered_at) as delivered_at_date,
        {{timestamp_to_time_id('delivered_at')}} as delivered_at_id,  
        to_time(delivered_at) as delivered_at,
        order_total,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "orders") }} where _fivetran_deleted is null
)

select * from orders