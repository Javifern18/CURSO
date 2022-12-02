{% snapshot stg_products_snapshot %}

{{
    config(
        strategy='check',
        unique_key='NK_product_id',
        check_cols=['product_name', 'product_price'],
        invalidate_hard_deletes=True,
        tag=['SILVER']
    )
}}

with products as (
    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        _fivetran_synced

    
    from {{ ref('base_products') }}
)

select * from products

{% endsnapshot %}
