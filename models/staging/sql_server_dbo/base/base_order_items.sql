with order_items as (
    select
        {{ dbt_utils.surrogate_key(['order_id','product_id','_fivetran_synced']) }} as order_items_id,
        {{ dbt_utils.surrogate_key(['order_id','product_id']) }} as NK_order_items_id, 
        order_id as NK_order_id,
        product_id as NK_product_id,
        quantity as product_quantity,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "order_items") }}
),

fivetran_not_deleted as (
    select
        order_items_id,
        NK_order_items_id, 
        NK_order_id,
        NK_product_id,
        product_quantity,
        _fivetran_synced
    
    from order_items where NK_order_items_id not in (select NK_order_items_id from order_items where _fivetran_deleted=true)
)

select * from fivetran_not_deleted