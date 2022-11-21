with stg_products as (
    select md5(product_id) as product_id,
    product_id as NK_product_id,
    price as product_price,
    inventory as stock,
    name as product_name,
    _fivetran_deleted,
    _fivetran_synced

    
    from {{ source("sql_server_dbo", "products") }}
)

select *
from stg_products
