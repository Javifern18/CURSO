{{
    config(
        materialized='incremental'
    )
}}

with products_snapshot as (   

    select 
        product_id,
        product_name,
        product_price,
        dbt_valid_from as product_valid_from,
        dbt_valid_to as product_valid_to
    
    from {{ ref('products_snapshot') }}
)

select * from products_snapshot

{% if is_incremental() %}

  where product_valid_from > (select max(product_valid_from) from {{ this }})

{% endif %}