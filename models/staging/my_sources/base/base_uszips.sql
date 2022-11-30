with source as (

    select * from {{ source('my_sources', 'uszips') }}

),

renamed as (

    select
        zip as zipcode,
        lat as latitude,
        lng as longitude,
        city as city_name,
        state_id,
        state_name,
        zcta as ZIP_code_tab_area,
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

    from source

)

select * from renamed