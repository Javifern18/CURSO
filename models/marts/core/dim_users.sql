{{
    config(
        materialized='incremental'
    )
}}

select user_id,
  first_name,
  last_name,
  phone_number,
  email,
  address_id,
  user_created_at,
  dbt_valid_from,
  dbt_valid_to

from {{ ref('users_snapshot') }}

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}