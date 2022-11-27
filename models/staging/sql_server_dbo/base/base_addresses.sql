with addresses as (
    select 
        {{ dbt_utils.surrogate_key(['address_id', '_fivetran_synced']) }} as address_id,        
        address_id as NK_address_id,
        country,
        state,
        zipcode,
        address,
        _fivetran_deleted,
        _fivetran_synced 
    
    from {{ source("sql_server_dbo", "addresses") }}
)

select * from addresses