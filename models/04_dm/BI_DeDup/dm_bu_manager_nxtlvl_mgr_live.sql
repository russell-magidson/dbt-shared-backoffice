{{ config(
    tags = ["bu_manager_nxtlvl_mgr_live", "po_assignments"], 
    alias = "bu_manager_nxtlvl_mgr_live"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_bu_manager_nxtlvl_mgr_live')}}
