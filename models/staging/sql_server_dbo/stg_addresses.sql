{{
  config(
    materialized='table',
    transient=false
  )
}}

with
    base_addresses as (select * from {{ ref("base_addresses") }}),

    base_uszips as (select * from {{ ref("base_uszips") }}),

    base_uszips_2 as (select * from {{ ref("base_uszips_2") }}),

    addresses_uszips as (
        select 
            a.address_id,
            a.NK_address_id,
            a.country,
            a.state,
            a.zipcode,
            z2.zipcode_type,   
            z.zip_code_tab_area,
            z.parent_zcta,
            a.address,
            a._fivetran_synced,
            case 
                when z2.latitude is null then z.latitude
                else z2.latitude
                end as latitude,
            case 
                when z2.longitude is null then z.longitude
                else z2.longitude
                end as longitude,
            case
                when z2.primary_city is null then z.city_name
                else z2.primary_city
                end as primary_city,
            case
                when z2.estimated_population is null then z.population
--              when z2.estimated_population=0 then z.population
                else z2.estimated_population
                end as estimated_population,
            z.density,
            z2.acceptable_cities_included,
            z2.unacceptable_cities,
            case
                when z.county_name is null then z2.county
                else z.county_name
                end as county,
            z.county_fips,
            z.county_fips_all,  
            z.county_names_all,
            z.county_weights,         
            case 
                when z2.timezone is null then z.timezone
                else z2.timezone
                end as timezone

        from base_addresses a
        left join base_uszips z on a.zipcode = z.zipcode
        left join base_uszips_2 z2 on a.zipcode = z2.zipcode
)

select * from addresses_uszips