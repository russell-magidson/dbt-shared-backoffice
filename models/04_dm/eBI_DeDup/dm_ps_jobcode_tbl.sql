{{ config(
    tags = ["ps_jobcode_tbl"], 
    alias = "ps_jobcode_tbl"
    )
}}

select *
from {{ ref( 'dwh_ps_jobcode_tbl')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_jobcode_tbl')}}
                        )
