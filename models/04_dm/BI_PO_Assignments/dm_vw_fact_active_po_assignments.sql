{{ config(
    tags = ["vw_fact_active_po_assignments", "view", "po_assignments"], 
    alias = "vw_fact_active_po_assignments", 
    materialized = 'view'
    )
}}

select *
from {{ ref( 'dm_fact_active_po_assignments')}}
