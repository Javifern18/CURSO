-- Tabla de hechos de tipo SNAPSHOT (foto diaria)

{{
    config(
        materialized='incremental',
        tags=['incremental'] 
    )
}}

with stock_snapshot as (   

    select 
        product_id,
        NK_product_id,
        stock,
        month(dbt_valid_from) as mes,
        dbt_valid_from as stock_valid_from,
        dbt_valid_to as stock_valid_to
    
    from {{ ref('stg_stock_snapshot') }}
)

select * from stock_snapshot

{% if is_incremental() %}

  where stock_valid_from > (select max(stock_valid_from) from {{ this }})

{% endif %}