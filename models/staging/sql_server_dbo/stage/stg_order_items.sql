with order_items as (
    select * from {{ ref('base_order_items') }}
),

orders as (
    select
        order_id,
        NK_order_id
    
    from {{ ref('base_orders_snapshot') }}
),

products as (
    select
        product_id,
        NK_product_id
    
    from {{ ref('base_products_snapshot') }}
),

final_order_items as (
    select
        oi.order_items_id,
        oi.NK_order_items_id,
        o.order_id,
        o.NK_order_id,
        p.product_id,
        p.NK_product_id,
        oi.product_quantity,
        oi._fivetran_synced

    from order_items oi left join orders o
        on oi.NK_order_id = o.NK_order_id
                        left join products p
        on oi.NK_product_id = p. NK_product_id    
)

select * from final_order_items
