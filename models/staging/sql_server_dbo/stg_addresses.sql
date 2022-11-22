with
    base_addresses as (select * from {{ ref("base_addresses") }}),

    base_uszips as (select * from {{ ref("base_uszips") }}),

    final as (
        select
            address_id,
            nk_address_id,
            country,
            state,
            a.zipcode,
            address,
            _fivetran_deleted,
            _fivetran_synced,
            latitude,
            longitude,
            city_name,
            zip_code_tab_area,
            parent_zcta,
            population,
            density,
            county_fips,
            county_name,
            county_weights,
            county_names_all,
            county_fips_all,
            imprecise,
            military,
            timezone

        from base_addresses a
        left join base_uszips u on a.zipcode = u.zipcode
    )

select * from final
