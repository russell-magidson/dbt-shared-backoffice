{{ config(
    tags = ["ps_bi_hdr"], 
    alias = "ps_bi_hdr"
    )
}}

select *
from {{ ref( 'dwh_ps_bi_hdr')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_bi_hdr')}}
                        )
