with stg_users as (
    select {{ dbt_utils.surrogate_key(['user_id', 'updated_at']) }} as user_id,
    user_id as NK_user_id,
    first_name,
    last_name,
    replace(phone_number,'-','')::number as phone_number,
    md5(address_id) as address_id,
    address_id as NK_address_id,
    email,
    created_at as user_created_at,
    updated_at as user_updated_at,
    _fivetran_deleted,
    _fivetran_synced

    from {{ source("sql_server_dbo", "users") }}
)

select *
from stg_users
