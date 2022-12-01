with promos as (
    select
        promo_id,
        NK_promo_id,
        promo_name,
        promo_status,
        discount,
        dbt_valid_from as promo_valid_from,
        dbt_valid_to as promo_valid_to,
        _fivetran_synced 
    
    from {{ ref('base_promos_snapshot') }}
)

select * from promos
