-- Dimensión con la información actual de los productos a día de hoy
{{
    config(
        materialized='incremental',
        unique_key=['NK_product_id'],
        tags=['incremental'] 
    )
}}

with products as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        datediff(day,current_date(),product_valid_from) as last_update_days_ago,
        _fivetran_synced
    
    from {{ ref('dim_products') }}
)

select * from products

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}