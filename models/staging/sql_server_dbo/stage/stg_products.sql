with products as (
    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        stock,
        dbt_valid_from as product_and_stock_valid_from,
        dbt_valid_to as product_and_stock_valid_to,
        _fivetran_synced

    
    from {{ ref('base_products_snapshot') }}
)

select * from products
