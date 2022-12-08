{{
    config(
        tags='Views'
    )
}}

with order_items as (
    select
        {{ dbt_utils.surrogate_key(['order_id','product_id','_fivetran_synced']) }} as order_items_id,
        {{ dbt_utils.surrogate_key(['order_id','product_id']) }} as NK_order_items_id, 
        order_id as NK_order_id,
        product_id as NK_product_id,
        quantity as product_quantity,
        _fivetran_deleted,
        _fivetran_synced

    from {{ source("sql_server_dbo", "order_items") }} where _fivetran_deleted = false
)

select * from order_items