{{ config(
    tags = ["ps_personal_data", "po_assignments"], 
    alias = "ps_personal_data"
    )
}}

SELECT
    emplid
    , country_nm_format
    , name
    , name_initials
    , name_prefix
    , name_suffix
    , name_royal_prefix
    , name_royal_suffix
    , name_title
    , last_name_srch
    , first_name_srch
    , last_name
    , first_name
    , middle_name
    , second_last_name
    , second_last_srch
    , name_ac
    , pref_first_name
    , partner_last_name
    , partner_roy_prefix
    , last_name_pref_nld
    , name_display
    , name_formal
    , country
    , address1
    , address2
    , address3
    , address4
    , city
    , num1
    , num2
    , house_type
    , addr_field1
    , addr_field2
    , addr_field3
    , county
    , state
    , postal
    , geo_code
    , in_city_limit
    , sex
    , mar_status
    , mar_status_dt
    , birthdate
    , birthplace
    , birthcountry
    , birthstate
    , dt_of_death
    , highest_educ_lvl
    , ft_student
    , lang_cd
    , alter_emplid
    , address1_ac
    , address2_ac
    , address3_ac
    , city_ac
    , country_other
    , address1_other
    , address2_other
    , address3_other
    , address4_other
    , city_other
    , county_other
    , state_other
    , postal_other
    , num1_other
    , num2_other
    , house_type_other
    , addr_field1_other
    , addr_field2_other
    , addr_field3_other
    , in_city_lmt_other
    , geo_code_other
    , country_code
    , phone
    , extension
    , va_benefit
    , campus_id
    , death_certif_nbr
    , ferpa
    , place_of_death
    , us_work_eligibilty
    , military_status
    , citizen_proof1
    , citizen_proof2
    , medicare_entld_dt
    , honseki_jpn
    , military_stat_ita
    , military_type_ita
    , military_rank_ita
    , military_end_ita
    , entry_dt_fra
    , milit_situatn_fra
    , cpamid
    , bilingualism_code
    , health_care_nbr
    , health_care_state
    , milit_situatn_esp
    , soc_sec_aff_dt
    , military_stat_ger
    , expctd_military_dt
    , hr_responsible_id
    , smoker
    , smoker_dt
    , gvt_cred_mil_svce
    , gvt_military_comp
    , gvt_mil_grade
    , gvt_mil_resrve_cat
    , gvt_mil_sep_ret
    , gvt_mil_svce_end
    , gvt_mil_svce_start
    , gvt_mil_verify
    , gvt_par_nbr_last
    , gvt_unif_svc_ctr
    , gvt_vet_pref_appt
    , gvt_vet_pref_rif
    , gvt_change_flag
    , gvt_draft_status
    , gvt_yr_attained
    , disabled_vet
    , disabled
    , gvt_disability_cd
    , grade
    , sal_admin_plan
    , gvt_curr_agcy_empl
    , gvt_curr_fed_empl
    , gvt_high_pay_plan
    , gvt_high_grade
    , gvt_prev_agcy_empl
    , gvt_prev_fed_empl
    , gvt_sep_incentive
    , gvt_sep_incent_dt
    , gvt_tenure
    , gvt_pay_plan
    , barg_unit
    , lastupddttm
    , insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PS_PERSONAL_DATA')}} 

QUALIFY ROW_NUMBER() OVER (PARTITION BY emplid ORDER BY lastupddttm DESC) = 1