{{ config( materialized='incremental')}}

{# create or replace table raw.rand_rusaweb.BI_DeDup.ps_assignment as #}

select *
from {{ ref( 'dwh_ps_assignment')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_assignment')}}
                        )
