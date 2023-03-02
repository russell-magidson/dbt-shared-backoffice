{{ config(
    tags = ["ps_pay_check"], 
    alias = 'ps_pay_check'
    )
}}

select *
from {{ ref( 'dwh_ps_pay_check')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_pay_check')}}
                        )
