{{
    config(
        tags='Views'
    )
}}

with events as (
    select
        {{ dbt_utils.surrogate_key(['event_id','_fivetran_synced']) }} as event_id,  
        event_id as NK_event_id,
        user_id as NK_user_id,
        session_id,
        nullif(product_id,'') as NK_product_id,
        nullif(order_id,'') as NK_order_id,
        page_url,
        {{timestamp_to_date_id('created_at')}} as event_date_id,
        to_date(created_at) as event_date,
        {{timestamp_to_time_id('created_at')}} as event_created_at_id,        
        to_time(created_at) as event_created_at,
        event_type,
        _fivetran_deleted,
        _fivetran_synced
    
    from {{ source("sql_server_dbo", "events") }} where _fivetran_deleted = false or _fivetran_deleted is null 
)

select * from events