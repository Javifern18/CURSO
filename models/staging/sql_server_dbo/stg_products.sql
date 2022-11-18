with stg_products as (select * from {{ source("sql_server_dbo", "products") }})

select *
from stg_products
