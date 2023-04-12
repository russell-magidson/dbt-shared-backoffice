{{ config(
    tags = ["ps_pay_check"], 
    alias = 'ps_pay_check'
    )
}}

SELECT
    company
    , paygroup
    , pay_end_dt
    , off_cycle
    , page_num
    , line_num
    , sepchk
    , form_id
    , paycheck_nbr
    , emplid
    , empl_rcd
    , name
    , deptid
    , empl_type
    , ssn
    , sin
    , total_gross
    , total_taxes
    , total_deductions
    , net_pay
    , check_dt
    , paycheck_status
    , paycheck_option
    , paycheck_adjust
    , paycheck_reprint
    , paycheck_cashed
    , paycheck_addr_optn
    , paycheck_name
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
    , location
    , paycheck_dist_key1
    , paycheck_dist_key2
    , benefit_rcd_nbr
    , pay_sheet_src
    , business_unit
    , gvt_schedule_no
    , gvt_pay_id_line_1
    , gvt_pay_id_line_2
    , gvt_ecs_ltd_indic
    , gvt_ecs_off_acct
    , gvt_rits_dt
    , gvt_tsp_seq_yr
    , gvt_tsp_seq_no
    , province
    , hp_correct_status
    , hp_corrected_dt
    , hr_wp_process_flg
    , update_dt
    , hdm_id
    , insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PS_PAY_CHECK')}}

WHERE 1=1
    AND check_dt > "2020-12-27"
    AND company NOT IN ("RTI", "RPI", "RAN", "CEL")
    AND paycheck_status IN ("F", "A", "R")
    
QUALIFY ROW_NUMBER() OVER (PARTITION BY company, paygroup, pay_end_dt, off_cycle, page_num, line_num, sepchk ORDER BY UPDATE_DT DESC) = 1
