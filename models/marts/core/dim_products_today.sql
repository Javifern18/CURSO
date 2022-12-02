-- Dimensión con la información actual de los productos a día de hoy
-- ¿En principio no la hago incremental porque no será tan grande como la dimensión histórica?

with historical_products_dimension as (   

    select 
        product_id,
        NK_product_id,
        product_name,
        product_price,
        datediff(day,product_valid_from,current_date()) as last_update_days_ago
    
    from {{ ref('dim_products') }}

    where product_valid_to is null
)

select * from historical_products_dimension