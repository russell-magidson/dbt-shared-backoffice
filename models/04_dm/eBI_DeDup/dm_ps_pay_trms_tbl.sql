{{ config(
    tags = ["ps_pay_trms_tbl"], 
    alias = "ps_pay_trms_tbl"
    )
}}

select *
from {{ ref( 'dwh_ps_pay_trms_tbl')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_pay_trms_tbl')}}
                        )
