{{ config(
    tags = ["ps_ca_contr_hdr"], 
    alias = "ps_ca_contr_hdr"
    )
}}

select *
from {{ ref( 'stg_ps_ca_contr_hdr')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_ca_contr_hdr')}}
                        ) #}
