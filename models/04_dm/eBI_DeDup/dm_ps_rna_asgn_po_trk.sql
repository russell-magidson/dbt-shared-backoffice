{{ config(
    tags = ["ps_rna_asgn_po_trk", "po_assignments"], 
    alias = "ps_rna_asgn_po_trk"
    )
}}

select *
from {{ ref( 'dwh_ps_rna_asgn_po_trk')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rna_asgn_po_trk')}}
                        )
