{{ config(
    tags = ["dim_date"], 
    alias = "dim_date"
    )
}}

select d.*, h.is_holiday_usa, h.holiday_usa
from {{ ref( 'dwh_dim_date')}} as d
left join {{ ref( 'dm_ext_holidays')}} as h 
    on d.date_key = h.date_key

where d.insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_date')}}
                        )
