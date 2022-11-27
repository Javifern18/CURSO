with stg_events as (
    select md5(event_id) as event_id,
    event_id as NK_event_id,
    md5(user_id) as user_id,
    user_id as NK_user_id,
    md5(nullif(order_id,'')) as order_id,
    nullif(order_id,'') as NK_order_id,
    md5(session_id) as session_id,
    session_id as NK_session_id,
    page_url,
    created_at as event_created_at,
    md5(event_type) as event_type_id,
    event_type,
    md5(product_id) as product_id,
    product_id as NK_product_id,
    _fivetran_deleted,
    _fivetran_synced
    
    from {{ source("sql_server_dbo", "events") }}
)

select *
from stg_events
