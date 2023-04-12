{{ config(
    tags = ["ps_names"], 
    alias = 'ps_names'
    )
}}

SELECT
        emplid
        ,name_type
        ,effdt
        ,country_nm_format
        ,name
        ,name_initials
        ,name_prefix
        ,name_suffix
        ,name_royal_prefix
        ,name_royal_suffix
        ,name_title
        ,last_name_srch
        ,first_name_srch
        ,last_name
        ,first_name
        ,middle_name
        ,second_last_name
        ,second_last_srch
        ,name_ac
        ,pref_first_name
        ,partner_last_name
        ,partner_roy_prefix
        ,last_name_pref_nld
        ,eff_status
        ,name_display
        ,name_formal
        ,lastupddttm
        ,lastupdoprid
        ,name_display_srch
        ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PS_NAMES')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY  emplid ORDER BY effdt DESC, lastupddttm  desc, insert_datetime desc) = 1
