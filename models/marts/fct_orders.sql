with orders as (

    select * from {{ ref('int_orders_joined') }}

),

final as (

    select
        order_id,
        customer_id,
        order_date,
        order_status,
        payment_method,
        payment_status,
        amount,
        payment_created_at

    from orders

)

select * from final