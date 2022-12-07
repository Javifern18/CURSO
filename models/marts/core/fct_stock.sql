-- Tabla de hechos de tipo SNAPSHOT (foto diaria)

{{
    config(
        materialized='incremental',
        unique_key=['NK_product_id','_fivetran_synced'],
        tags=['incremental'] 
    )
}}

with stock_snapshot as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        stock,
        {{timestamp_to_date_id(('_fivetran_synced'))}} as id_fecha,
        _fivetran_synced

    from {{ ref('stg_stock') }}
)

select * from stock_snapshot

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}