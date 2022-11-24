with
    base_addresses as (select * from {{ ref("base_addresses") }}),

    base_uszips as (select * from {{ ref("base_uszips") }}),

    base_uszips_2 as (select * from {{ ref("base_uszips_2") }}), 

    addresses_uszips as (
        select
            a.address_id,
            a.nk_address_id,
            a.country,
            a.state,
            a.zipcode,
            z2.zipcode_type,
            a.address,
            a._fivetran_deleted,
            a._fivetran_synced,
--            z.latitude,
            z2.latitude,
--            z.longitude,
            z2.longitude,
            z2.primary_city,
            z.city_name,
            z2.acceptable_cities_included,
            z2.unacceptable_cities,
            z.zip_code_tab_area,
            z.parent_zcta,
            z.population,
            z2.estimated_population,
            z.density,
            z.county_fips,
            z2.county,
            z.county_name,
            z.county_weights,
            z.county_names_all,
            z.county_fips_all,
            z.imprecise,
            z.military,
--            z.timezone,
            z2.timezone

        from base_addresses a
        left join base_uszips z on a.zipcode = z.zipcode
        left join base_uszips_2 z2 on a.zipcode = z2.zipcode
    )

    select * from addresses_uszips
