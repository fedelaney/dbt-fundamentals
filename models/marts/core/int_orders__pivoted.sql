{%- set payment_methods = ['bank_transfer'
                         ,'coupon'
                         ,'credit_card'
                         ,'gift_card'] -%}

select
    order_id
    {% for p in payment_methods -%}
    sum(case when payment_method = '{{p}}' then amount else 0 end) as {{p}}_amount{% if not loop.last %}, {% endif %}
    {% endfor -%}
from {{ ref('stg_payments') }}
where
    status = 'success'
group by 1
