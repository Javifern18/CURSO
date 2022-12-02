{% snapshot stg_stock_snapshot %}

{{
    config(
        strategy='check',
        unique_key='NK_product_id',
        check_cols=['stock'],
        invalidate_hard_deletes=True,
        tag=['SILVER']
    )
}}

with products as (
    select 
        product_id,
        NK_product_id,
        stock,
        _fivetran_synced

    
    from {{ ref('base_products') }}
)

select * from products

{% endsnapshot %}