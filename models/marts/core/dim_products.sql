{{
    config(
        materialized='incremental',
        unique_key=['NK_product_id','product_valid_from'],
        tags=['incremental'] 
    )
}}

with products as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        _fivetran_synced,
        dbt_valid_from as product_valid_from,
        dbt_valid_to as product_valid_to
    
    from {{ ref('stg_products_snapshot') }}

    union
    select '0',null,'None product', null,null,null,null
)

select * from products

{% if is_incremental() %}

  where NK_product_id in (select NK_product_id from products where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}))

{% endif %}