{% snapshot base_orders_snapshot %}

{{
    config(
      unique_key='NK_order_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
      tags=['SILVER']
    )
}}

with orders as (
    select 
        {{ dbt_utils.surrogate_key(['order_id','status','_fivetran_synced']) }} as order_id,  -- ¿Merece la pena surrogate key con _fivetran_synced?     
        order_id as NK_order_id,
        nullif(promo_id,'') as NK_promo_id,
        nullif(shipping_service,'') as shipping_service,
        shipping_cost,
        year(to_date(estimated_delivery_at))*10000+month(to_date(estimated_delivery_at))*100+day(to_date(estimated_delivery_at)) as estimated_delivery_at_date_id,
        to_date(estimated_delivery_at) as estimated_delivery_at_date,
        hour(estimated_delivery_at)*24*60+minute(estimated_delivery_at)*60+second(estimated_delivery_at) as estimated_delivery_at_id,  
        to_time(estimated_delivery_at) as estimated_delivery_at,
        address_id as NK_address_id,
        user_id as NK_user_id,
        status as order_status,
        order_cost,
        nullif(tracking_id,'') as tracking_id,   -- ¿Estaría bien crear una surrogate key para tracking_id?
        year(to_date(created_at))*10000+month(to_date(created_at))*100+day(to_date(created_at)) as order_created_at_date_id,
        to_date(created_at) as order_created_at_date,
        hour(created_at)*24*60+minute(created_at)*60+second(created_at) as order_created_at_id,  
        to_time(created_at) as order_created_at,
        year(to_date(delivered_at))*10000+month(to_date(delivered_at))*100+day(to_date(delivered_at)) as delivered_at_date_id,
        to_date(delivered_at) as delivered_at_date,
        hour(delivered_at)*24*60+minute(delivered_at)*60+second(delivered_at) as delivered_at_id,  
        to_time(delivered_at) as delivered_at,
        order_total,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "orders") }}
),

fivetran_not_deleted as (
    select
        order_id,   
        NK_order_id,
        NK_promo_id,
        shipping_service,
        shipping_cost,
        estimated_delivery_at_date_id,
        estimated_delivery_at_date,
        estimated_delivery_at_id,
        estimated_delivery_at,
        NK_address_id,
        NK_user_id,
        order_status,
        order_cost,
        tracking_id,  
        order_created_at_date_id,
        order_created_at_date,
        order_created_at_id,
        order_created_at,
        delivered_at_date_id,
        delivered_at_date,
        delivered_at_id,
        delivered_at,
        order_total,
        _fivetran_synced
    
    from orders where NK_order_id not in (select NK_order_id from orders where _fivetran_deleted=true)
)

select * from fivetran_not_deleted

{% endsnapshot %}