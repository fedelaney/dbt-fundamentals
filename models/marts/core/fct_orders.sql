select
    orders.order_id
    ,cust.customer_id
    ,orders.order_date
    ,coalesce(pay.amount, 0)            as amount
from {{ ref('stg_orders') }} orders
    left outer join {{ ref('stg_customers') }} cust
    on orders.customer_id = cust.customer_id
    left outer join {{ ref('stg_payments') }} pay
    on pay.order_id = orders.order_id
        and pay.status = 'success'