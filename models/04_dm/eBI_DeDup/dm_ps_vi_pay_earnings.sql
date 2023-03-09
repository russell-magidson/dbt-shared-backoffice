{{ config(
    tags = ["ps_vi_pay_earnings"], 
    alias = "ps_vi_pay_earnings"
    )
}}

select *
from {{ ref( 'dwh_ps_vi_pay_earnings')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_vi_pay_earnings')}}
                        )
