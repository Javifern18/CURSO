with base_addresses as (
    select * from {{ ref('base_addresses') }}
),

base_uszips as (
    select * from {{ ref('base_uszips') }}
),

stg_addresses as (
    select *
        from base_addresses a left join base_uszips u
            on a.zipcode = u.zipcode
)

select * from stg_addresses
    
