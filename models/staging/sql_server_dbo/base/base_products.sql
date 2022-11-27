with products as (
    select 
        {{ dbt_utils.surrogate_key(['product_id', 'name','price']) }} as product_id,
        product_id as NK_product_id,
        name as product_name,
        price as product_price,
        inventory as stock,
        _fivetran_deleted,
        _fivetran_synced

    
    from {{ source("sql_server_dbo", "products") }}
)

select * from products