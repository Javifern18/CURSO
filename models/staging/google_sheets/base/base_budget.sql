with stg_budget as (
    select md5(_row) as budget_id,
    _row as NK_budget_id,
    quantity as estimated_quantity,
    month::date as budget_date,
    md5(product_id) as product_id,
    product_id as NK_product_id,
    _fivetran_synced 

    from {{ source("google_sheets", "budget") }}
)

select *
from stg_budget