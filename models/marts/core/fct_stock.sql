-- Tabla de hechos de tipo SNAPSHOT
-- ¿¿Cómo cargar esto de mes en mes?? ¿¿Con una condición sobre la fecha?

{{
    config(
        materialized='incremental'
    )
}}

with products_snapshot as (   

    select 
        product_id,
        stock,
        month(dbt_valid_from) as mes,
        dbt_valid_from as stock_valid_from,
        dbt_valid_to as stock_valid_to
    
    from {{ ref('products_snapshot') }}
)

select * from products_snapshot

{% if is_incremental() %}

  where stock_valid_from > (select max(stock_valid_from) from {{ this }})

{% endif %}