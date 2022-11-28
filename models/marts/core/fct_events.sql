with stg_events as (
    select
        event_id,
        user_id,
        product_id,
        order_id,   -- Degenerate dimension key
        session_id,
        page_url,
        event_created_at,
--        event_type_id,
        event_type,
        _fivetran_synced
    
    from {{ ref('stg_events') }}
)

select * from stg_events