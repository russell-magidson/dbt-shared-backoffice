{{ config(
    tags = ["ps_rna_bh_plac_stg"], 
    alias = "ps_rna_bh_plac_stg"
    )
}}

select *
from {{ ref( 'dwh_ps_rna_bh_plac_stg')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rna_bh_plac_stg')}}
                        )
