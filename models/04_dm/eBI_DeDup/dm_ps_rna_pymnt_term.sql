{{ config(
    tags = ["ps_rna_pymnt_term"], 
    alias = "ps_rna_pymnt_term"
    )
}}

select *
from {{ ref( 'dwh_ps_rna_pymnt_term')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rna_pymnt_term')}}
                        )
