with stg_addresses as (select * from {{ source("sql_server_dbo", "addresses") }})

select *
from stg_addresses