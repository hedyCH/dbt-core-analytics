with source as (

    select * from {{ source('jaffle_shop', 'payment_native') }}

),

renamed as (

    select
        id                          as payment_id,
        orderid                     as order_id,
        paymentmethod               as payment_method,
        status                      as payment_status,
        (amount / 100.0)            as amount,   -- adjust if already in dollars
        created                     as payment_created_at,
        _batched_at

    from source

)

select * from renamed