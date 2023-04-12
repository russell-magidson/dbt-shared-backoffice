{{ config(
    tags = ["ps_rna_asgn_po_trk", "po_assignments"], 
    alias = "ps_rna_asgn_po_trk"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rna_asgn_po_trk')}}
