{{
    config(
        materialized='incremental',
        unique_key=['NK_user_id'],
        tags=['incremental'] 
    )
}}

with dim_users_today as (
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
)

select * from dim_users_today

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}