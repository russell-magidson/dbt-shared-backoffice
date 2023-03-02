{{ config(
    tags = ["ps_rdm_revcost_dtl"], 
    alias = "ps_rdm_revcost_dtl"
    )
}}

select *
from {{ ref( 'dwh_ps_rdm_revcost_dtl')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rdm_revcost_dtl')}}
                        )
