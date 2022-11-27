with budget_info as (
    select
        budget_id,
        month(budget_date) as month,
        year(budget_date) as year, 
        product_id,
        estimated_quantity    

    from {{ ref('stg_budget') }}
    order by month
),

product_info as (
    select
        product_id,
        product_price
    
    from {{ ref('dim_products') }}
),

final_budget as (
    select
        b.budget_id,
        b.month,
        b.year, 
        b.product_id,
        b.estimated_quantity,
        b.estimated_quantity*p.product_price as estimated_profit
    
    from budget_info b join product_info p
        on b.product_id = p.product_id
)

select * from final_budget