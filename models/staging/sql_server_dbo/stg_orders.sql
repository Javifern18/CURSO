with orders as (
    select * from {{ ref("base_orders") }}
),

seed_shipping_service_description as (
    select
        {{ dbt_utils.surrogate_key(['shipping_service_name', 'shipping_service_description']) }} as shipping_service_id
        ,shipping_service_name
        ,shipping_service_description 

    from {{ ref("seed_shipping_service_description") }}
),

promos as (
    select
        promo_id,
        NK_promo_id
    
    from {{ ref('base_promos') }}
),

addresses as (
    select
        address_id,
        NK_address_id
    
    from {{ ref('base_addresses') }}
),

users as (
    select
        user_id,
        NK_user_id
    
    from {{ ref('base_users') }}
),

final_orders as (
    select 
        o.order_id,
        o.NK_order_id,
        p.promo_id,
        s.shipping_service_id,
        s.shipping_service_name,
        s.shipping_service_description,
        o.shipping_cost,
        o.estimated_delivery_at,
        a.address_id,
        u.user_id,
        o.order_status,
        o.order_cost,
        o.tracking_id,
        o.order_created_at,
        o.delivered_at,
        o.order_total,
        o._fivetran_synced    
         
        from orders o 
                left join seed_shipping_service_description s
            on o.shipping_service = s.shipping_service_name
                left join promos p
            on o.NK_promo_id = p.NK_promo_id
                left join addresses a
            on o.NK_address_id = a.NK_address_id
                left join users u
            on o.NK_user_id = u.NK_user_id
)

select * from final_orders
