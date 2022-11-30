with events as (
    select * from {{ ref('base_events') }}
),

users as (
    select 
        user_id,
        NK_user_id
    
    from {{ ref('base_users') }}
),

orders as (
    select 
        order_id,
        NK_order_id
    
    from {{ ref('base_orders') }}
),

products as (
    select 
        product_id,
        NK_product_id
    
    from {{ ref('base_products') }}
),

final_events as (
    select
        e.event_id,
        e.NK_event_id,
        u.user_id,
        u.NK_user_id,
        o.order_id,
        o.NK_order_id,
        e.session_id,
        e.page_url,
        e.event_date_id,
        e.event_created_at_id,
        e.event_type,
        p.NK_product_id,
        p.product_id,
        e._fivetran_synced

    from 
        events e left join users u
            on e.NK_user_id = u.NK_user_id
                 left join orders o
            on e.NK_order_id = o.NK_order_id
                 left join products p
            on e.NK_product_id = p.NK_product_id  
)

select * from final_events
