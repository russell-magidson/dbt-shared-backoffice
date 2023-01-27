{# create or replace table raw.rand_rusaweb.BI_DeDup.ps_assignment as #}
{{ config(
    tags = ["ps_bi_hdr", "backoffice"]
    )
}}

select *
from {{ ref( 'dwh_ps_bi_hdr')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_bi_hdr')}}
                        )
