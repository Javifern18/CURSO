{{
    config(
        materialized='incremental'
    )
}}

with users_snapshot as (
      
      select user_id,
        first_name,
        last_name,
        phone_number,
        email,
        address_id,
        user_created_at,
        _fivetran_deleted,
        _fivetran_synced,
        dbt_valid_from as user_valid_from,
        dbt_valid_to as user_valid_to

from {{ ref('users_snapshot') }}
)

select * from users_snapshot

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}