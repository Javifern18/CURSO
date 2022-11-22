with stg_addresses as (
    select md5(address_id) as address_id,
    address_id as NK_address_id,
    country,
    state,
    zipcode,
    md5(zipcode) as zipcode_id,
    address,
    _fivetran_deleted,
    _fivetran_synced 
    
    from {{ source("sql_server_dbo", "addresses") }}
)

select *
from stg_addresses