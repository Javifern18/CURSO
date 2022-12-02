{% snapshot base_promos_snapshot %}

{{
    config(
      unique_key='NK_promo_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalidate_hard_deletes=True,
      tags=['SILVER','Bases','Snapshot'],
    )
}}

with promos as (
    select
        {{ dbt_utils.surrogate_key(['promo_id','_fivetran_synced']) }} as promo_id,
        {{ dbt_utils.surrogate_key(['promo_id'])}} as NK_promo_id,
        promo_id as promo_name,
        status as promo_status,
        discount,
        _fivetran_deleted,
        _fivetran_synced 
    
    from {{ source("sql_server_dbo", "promos") }}
),

fivetran_not_deleted as (
    select
        promo_id,  
        NK_promo_id,
        promo_name,
        promo_status,
        discount,
        _fivetran_synced 
    
    from promos where NK_promo_id not in (select NK_promo_id from promos where _fivetran_deleted=true)
)

select * from fivetran_not_deleted

{% endsnapshot %}