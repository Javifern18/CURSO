with promos as (
    select 
        promo_id,
        NK_promo_id,
        promo_name,
        promo_status,
        discount,
        _fivetran_synced 
    
    from {{ ref('base_promos') }}
)

select * from promos
