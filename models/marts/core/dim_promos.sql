with dim_promos as (
    select 
        promo_id,
        NK_promo_id,
        promo_name,
        promo_status,
        discount,
        promo_valid_from,
        promo_valid_to
    
    from {{ ref('stg_promos') }}
)

select * from dim_promos
