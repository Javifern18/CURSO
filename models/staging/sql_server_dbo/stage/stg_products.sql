with products as (
    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        stock,
        _fivetran_synced

    
    from {{ ref('base_products') }}
)

select * from products
