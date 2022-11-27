with promos as (
    select
       {{ dbt_utils.surrogate_key(['promo_id','_fivetran_synced']) }} as promo_id,  -- ¿Merece la pena surrogate key con _fivetran_synced?   
        promo_id as NK_promo_id,
        promo_id as promo_name,
        status as promo_status,
        discount,
        _fivetran_deleted,
        _fivetran_synced 
    
    from {{ source("sql_server_dbo", "promos") }}
)

select * from promos