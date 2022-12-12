{{
    config(
        tags=['Views'],
    )
}}

with products as (
    select 
        {{ dbt_utils.surrogate_key(['product_id', 'inventory','price']) }} as product_id,
        product_id as NK_product_id,
        name as product_name,
        price as product_price,
        inventory as stock,
        _fivetran_deleted,
        _fivetran_synced

    
    from {{ source("sql_server_dbo", "products") }} where _fivetran_deleted = false or _fivetran_deleted is null
)

select * from products