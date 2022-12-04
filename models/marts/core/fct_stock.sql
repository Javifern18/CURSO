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
        stock,
        {{timestamp_to_date_id('dbt_valid_from')}} as stock_valid_from_id,
        {{timestamp_to_date_id('dbt_valid_to')}} as stock_valid_to_id
    
    from {{ ref('stg_stock_snapshot') }}
)

select * from stock_snapshot

{% if is_incremental() %}

  where stock_valid_from > (select max(stock_valid_from) from {{ this }})

{% endif %}