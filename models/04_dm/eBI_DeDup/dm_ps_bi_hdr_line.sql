{{ config(
    tags = ["ps_bi_hdr_line"], 
    alias = "ps_bi_hdr_line"
    )
}}

select *
from {{ ref( 'dwh_ps_bi_hdr_line')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_bi_hdr_line')}}
                        )
