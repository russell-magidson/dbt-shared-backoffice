{{ config(
    tags = ["ps_rna_asgn_po_trk", "po_assignments"], 
    alias = "ps_rna_asgn_po_trk"
    )
}}

SELECT 
    assignment_id
    ,effdt
    ,ca_po_id
    ,contract_num
    ,contract_line_num
    ,po_ref
    ,rna_awaitingpo_flg
    ,business_unit
    ,lastupddttm
    ,lastupdoprid
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_ASGN_PO_TRK')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY assignment_id ORDER BY effdt DESC) = 1
