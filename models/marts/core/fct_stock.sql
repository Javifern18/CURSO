-- Tabla de hechos de tipo SNAPSHOT (foto diaria)

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
        stock,
        month(product_and_stock_valid_from) as mes,
        product_and_stock_valid_from as stock_valid_from,
        product_and_stock_valid_to as stock_valid_to
    
    from {{ ref('stg_products') }}
)

select * from products_snapshot

{% if is_incremental() %}

  where stock_valid_from > (select max(stock_valid_from) from {{ this }})

{% endif %}