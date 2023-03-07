{{ config(
    tags = ["ps_earnings_tbl"], 
    alias = 'ps_earnings_tbl'
    )
}}

select *
from {{ ref( 'stg_ps_earnings_tbl')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_earnings_tbl')}}
                        ) #}
