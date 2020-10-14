with orders as (
select * from {{ ref('stg_orders') }} 
),

payments as (
select * from {{ ref('stg_payments') }} 
),

final as (
SELECT  
    o.order_id,
    o.customer_id,
    o.order_date,
    SUM(p.amount) as amount
FROM orders o
JOIN payments p USING (order_id)
WHERE p.status IN ('success')
GROUP BY 1,2,3
)

SELECT * FROM final