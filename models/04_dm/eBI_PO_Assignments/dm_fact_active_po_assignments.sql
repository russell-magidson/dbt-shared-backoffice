{{ config(
    tags = ["fact_active_po_assignments", "po_assignments"], 
    alias = "fact_active_po_assignments"
    )
}}

select *
from {{ ref( 'dwh_fact_active_po_assignments')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_fact_active_po_assignments')}}
                        )
