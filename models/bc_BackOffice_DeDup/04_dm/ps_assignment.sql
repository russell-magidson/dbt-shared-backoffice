{# create or replace table raw.rand_rusaweb.BI_DeDup.ps_assignment as #}
{{ config(
    tags = ["ps_assignment", "backoffice"]
    )
}}

select *
from {{ ref( 'dwh_ps_assignment')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_assignment')}}
                        )
