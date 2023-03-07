{{ config(
    tags = ["ps_pay_earnings"], 
    alias = 'ps_pay_earnings'
    )
}}

select *
from {{ ref( 'stg_ps_pay_earnings')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_pay_earnings')}}
                        ) #}
