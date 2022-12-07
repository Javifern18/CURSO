{{
    config(
        materialized='incremental',
        unique_key=['NK_product_id','_fivetran_synced'],
        tags=['incremental'] 
    )
}}

with products as (
    select 
        product_id,
        NK_product_id,
        product_name,
        stock,
        _fivetran_synced
    
    from {{ ref('base_products') }}
)

select * from products

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}