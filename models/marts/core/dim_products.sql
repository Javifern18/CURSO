{{
    config(
        materialized='incremental',
        tags=['incremental']    
    )
}}

with products_snapshot as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        product_and_stock_valid_from as product_valid_from,
        product_and_stock_valid_to as product_valid_to
    
    from {{ ref('stg_products') }}
)

select * from products_snapshot

{% if is_incremental() %}

  where product_valid_from > (select max(product_valid_from) from {{ this }})

{% endif %}