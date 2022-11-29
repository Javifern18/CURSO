{{
    config(
        materialized='incremental'
    )
}}

with users_snapshot as (
      select * from {{ ref('users_snapshot') }}
),

users_addresses as (
      select * from {{ref('stg_addresses')}}
),

dim_users as (
  select 
        u.user_id,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        a.address,
        a.zipcode,
        a.primary_city as city,
        a.county,
        a.state,
        a.country,
        u.user_created_at,
        u.dbt_valid_from as user_valid_from,
        u.dbt_valid_to as user_valid_to

  from users_snapshot u left join users_addresses a
    on u.address_id = a.address_id
)

select * from dim_users

{% if is_incremental() %}

  where user_valid_from > (select max(user_valid_from) from {{ this }})

{% endif %}