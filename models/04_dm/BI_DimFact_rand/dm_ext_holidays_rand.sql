{{ config(
    tags = ["ext_holidays"], 
    alias = "ext_holidays"
    )
}}

select *
from {{ ref( 'dm_ext_holidays')}}
