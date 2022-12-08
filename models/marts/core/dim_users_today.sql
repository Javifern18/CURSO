{{
    config(
        materialized='incremental',
        unique_key=['NK_user_id'],
        tags=['incremental'] 
    )
}}

select
    user_id,
    NK_user_id,
    first_name,
    last_name,
    phone_number,
    email,
    address,
    zipcode,
    city,
    county,
    state,
    country,
    _fivetran_synced

from {{ ref('dim_users') }}

{% if is_incremental() %}

  where NK_user_id in (select NK_user_id from final_users where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}))

{% endif %}