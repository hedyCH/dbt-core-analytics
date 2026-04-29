with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select
        order_id,
        max(payment_method)                     as payment_method,
        max(payment_status)                     as payment_status,
        sum(amount)                             as amount,
        max(payment_created_at)                 as payment_created_at

    from {{ ref('stg_payment') }}
    group by order_id

),

joined as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
        payments.payment_method,
        payments.payment_status,
        payments.amount,
        payments.payment_created_at

    from orders
    left join payments
        on orders.order_id = payments.order_id

)

select * from joined