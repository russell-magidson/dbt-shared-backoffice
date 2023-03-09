{{ config(
    tags = ["ps_bi_line"], 
    alias = "ps_bi_line"
    )
}}

select *
from {{ ref( 'dwh_ps_bi_line')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_bi_line')}}
                        )
