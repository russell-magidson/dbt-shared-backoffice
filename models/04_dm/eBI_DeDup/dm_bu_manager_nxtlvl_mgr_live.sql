{{ config(
    tags = ["bu_manager_nxtlvl_mgr_live"], 
    alias = "bu_manager_nxtlvl_mgr_live"
    )
}}

select *
from {{ ref( 'dwh_bu_manager_nxtlvl_mgr_live')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_bu_manager_nxtlvl_mgr_live')}}
                        )
