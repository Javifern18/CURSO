with stg_promos as (
    select md5(promo_id) as promo_id,
    promo_id as NK_promo_id,
    promo_id as promo_name,
    status as promo_status,
    discount,
    _fivetran_deleted,
    _fivetran_synced 
    
    from {{ source("sql_server_dbo", "promos") }}
)

select *
from stg_promos
