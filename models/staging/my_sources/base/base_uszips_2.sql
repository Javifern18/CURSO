with source as (

    select * from {{ source('my_sources', 'uszips_2') }}

),

renamed as (

    select
        zip as zipcode,
        type as zipcode_type,
        decommissioned,
        primary_city,
        acceptable_cities as acceptable_cities_included,
        unacceptable_cities,
        state,
        county,
        area_codes as area_codes_included,
        timezone,
        world_region,
        country,
        latitude,
        longitude,
        irs_estimated_population as estimated_population

    from source

)

select * from renamed