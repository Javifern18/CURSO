{% snapshot products_snapshot %}

{{
    config(
      unique_key='NK_product_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_products') }}

{% endsnapshot %}