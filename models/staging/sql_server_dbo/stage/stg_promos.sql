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
    
    from {{ ref('base_promos_snapshot') }} where promo_status='active'

    union
    select '0',null,'no_promo','active',0,to_timestamp(0),null,to_timestamp(0)
)

select * from promos
