with events as (
    select
        {{ dbt_utils.surrogate_key(['event_id','_fivetran_synced']) }} as event_id,  -- ¿Merece la pena surrogate key con _fivetran_synced?  
        event_id as NK_event_id,
        user_id as NK_user_id,
        session_id,   -- ¿Estaría bien crear una surrogate key para session_id?
        product_id as NK_product_id,
        nullif(order_id,'') as NK_order_id,
        page_url,
        created_at as event_created_at,
        event_type,
        _fivetran_deleted,
        _fivetran_synced
    
    from {{ source("sql_server_dbo", "events") }}
),

fivetran_not_deleted as (
    select
        event_id,
        NK_event_id,
        NK_user_id,
        session_id,
        NK_product_id,
        NK_order_id,
        page_url,
        event_created_at,
        event_type,
        _fivetran_synced
    
    from events where NK_event_id not in (select NK_event_id from events where _fivetran_deleted=true)
)

select * from fivetran_not_deleted