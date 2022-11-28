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
),

fivetran_not_deleted as (
    select
        product_id,
        NK_product_id,
        product_name,
        product_price,
        stock,
        _fivetran_synced
    
    from products where NK_product_id not in (select NK_product_id from products where _fivetran_deleted=true)
)

select * from fivetran_not_deleted