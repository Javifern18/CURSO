{{
    config(
        materialized='incremental',
        tags=['incremental']    
    )
}}

with products as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        dbt_valid_from as product_valid_from,
        dbt_valid_to as product_valid_to
    
    from {{ ref('stg_products_snapshot') }}

    union
    select '0',null,'None product', null,to_timestamp(0),null
)

select * from products

{% if is_incremental() %}

  where product_valid_from > (select max(product_valid_from) from {{ this }})

{% endif %}