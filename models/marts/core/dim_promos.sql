with dim_promos as (
    select 
        promo_id,
        promo_name,
        promo_status,
        discount,
        _fivetran_synced
    
    from {{ ref('stg_promos') }}

    union

    select 'no_aplica_promo', 'no_aplica_promo', 'no_aplica_promo', 0, null

)

select * from dim_promos
