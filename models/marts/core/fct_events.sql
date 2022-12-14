{{
    config(
        materialized='incremental',
        unique_key=['NK_event_id'],
        tags=['incremental'] 
    )
}}

with stg_events as (
    select
        event_id,
        NK_event_id,
        user_id,
        {{cambia_nulos_columna_por('product_id','0')}} as product_id,
        {{cambia_nulos_columna_por('order_id','None order')}} as order_id,   -- DEGENERATE DIMENSION
        session_id,
        page_url,
        event_date_id,
        event_created_at_id,
--        event_type_id,
        event_type,
        _fivetran_synced
    
    from {{ ref('stg_events') }}
)

select * from stg_events

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}