{{ config(
    tags = ["dim_customer", "backoffice"], 
    alias = "dim_customer"
    )
}}

WITH latitem AS
    (
        select fieldvalue, fieldname , xlatlongname
        from {{ source( 'rand-rusaweb-dedup', 'psxlatitem_fs')}}
    )
    , item_activity AS
    (
        select  cust_id, MAX(post_dt) AS last_customer_payment
        from {{ source( 'rand-rusaweb-dedup', 'ps_item_activity')}}
        
        where entry_type = 'PY'
        GROUP BY cust_id
    )
    , rna_cust_option AS
    (
        select setid, cust_id, rna_weekday
            ,case  when rna_weekday = '1' then 'Sun'
                    when rna_weekday = '2' then 'Mon'
                    when rna_weekday = '3' then 'Tues'
                    when rna_weekday = '4' then 'Wed'
                    when rna_weekday = '5' then 'Thur'
                    when rna_weekday = '6' then 'Fri'
                    when rna_weekday = '7' then 'Sat' 
            end as customer_we
        from {{ source( 'rand-rusaweb-dedup', 'ps_rna_cust_option')}}    
        
        where effdt <= CURRENT_DATE()
        qualify row_number() over (partition by setid, cust_id order by effdt desc nulls last ) = 1
    )

select distinct
    c.setid
    , c.CUST_ID AS customer_id
    /* We are cleaning up the name columns here and passing on original values */
    , initcap( trim( REGEXP_REPLACE( c.name1, r'([^\p{ASCII}]+)', ' '))) AS customer_name
    , initcap( trim( REGEXP_REPLACE( corp.name1, r'([^\p{ASCII}]+)', ' '))) AS corporate_customer_name
    , initcap( trim( REGEXP_REPLACE( c.NAMESHORT, r'([^\p{ASCII}]+)', ' '))) AS customer_short_name
    , c.NAME1 AS original_customer_name
    , corp.name1 AS original_corporate_customer_name
    , c.CUST_STATUS AS customer_status
    , cxstatus.xlatlongname AS customer_status_description
    , c.add_dt
    , c.last_maint_oprid
    , c.date_last_maint
    , c.corporate_setid
    , c.CUSTOMER_TYPE AS customer_type
    , c.RNA_SOURCE_SYSTEM AS rna_source_system
    , c.DEPTID AS department_id
    , c.SINCE_DT AS customer_since_dt
    , c.CORPORATE_CUST_ID AS corporate_customer_id
    , c.RNA_BILLING_METHOD AS rna_billing_method
    , m.xlatlongname AS rna_billing_method_description
    , case c.RNA_BILLING_METHOD
        when 'V' then 'Y'
        else 'N'
        end as is_vms_customer
    , c.RNA_TIME_ENTRY_MHD AS rna_time_entry_method
    , t.xlatlongname AS rna_time_entry_method_description
    , case when upper( trim( o.rna_po_track_flag)) = 'Y' then 'Yes' else 'No' end as po_customer
    , o.rna_tracking_funds
    , x.XLATLONGNAME AS po_tracking_method
    , pso.CR_ANALYST AS analyst_code
    , IFNULL(INITCAP(pscat.NAME1),'Unknown') AS analyst_name
    , sam.MANAGER_NAME AS analyst_manger
    , case
        when psgf.RS_NAT_OWN_FLG = 'Y' then 'Strategic Account'
        when psgf.RNA_LAUNCH_FLG = 'Y' then 'Launch Account'
        when psgf.RNA_NATL_ACCT_FLG = 'Y' then 'National Account'
        when psrcl.RNA_FLAG_NAME = 'NSO' then 'NSO'
        else 'Retail'
        end as account_type
    , d.source AS vms_source_code
    , case 
        when left( d.source, 1) = '0' then 'N'
        when left( d.source, 1) != '0' then 'Y' 
        else NULL /* This is not required however it may be confusing if not there */
        end as automated_vms
    , pso.bill_cycle_id
    , pso.po_required AS require_po
    , pso.pymnt_terms_cd
    , pterm.description AS payment_term_description
    , cxcredit.risk_code
    , ccode.xlatlongname AS risk_code_description
    , cxcredit.credit_class
    , cclass.xlatlongname AS credit_class_description
    , cxcredit.cr_limit AS credit_limit
    , iact.last_customer_payment
    , rco.customer_we
    , d.rna_vms_sep_pay_bi
    , case when lower(c.NAME1) LIKE '%do not use%'
            then 'Y'
            else 'N'
        end as do_not_use_flag
    , cKey.cust_key

from {{ source( 'rand-rusaweb-dedup', 'ps_customer')}} as c

left join {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_CUSTDAT_TBL')}} as d 
    on c.cust_id = d.cust_id

left join {{ source( 'rand-rusaweb-dedup', 'ps_customer')}} as corp
    on c.corporate_cust_id = corp.cust_id

left join {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_CUST_PO_OPT')}} as o
    on c.cust_id = o.cust_id and c.setid = o.setid

left join {{ source( 'rand-rusaweb-dedup', 'psxlatitem_fs')}} as x
    on trim( x.fieldvalue) = trim( o.RNA_TRACKING_FUNDS) and x.fieldname = 'RNA_TRACKING_FUNDS'

left join {{ source( 'rand-rusaweb-utils', 'vw_Latest_FS_Cust_Option')}} as pso
        ON c.CUST_ID = pso.CUST_ID

left join {{ source( 'rand-rusaweb-dedup', 'ps_rna_pymnt_term')}} as pterm
        ON pso.pymnt_terms_cd = pterm.pymnt_terms_cd

left join {{ source( 'rand-rusaweb-utils', 'vw_Latest_FS_CR_Analyst_Tbl')}} as pscat
        ON pso.CR_ANALYST = pscat.CR_ANALYST

left join {{ source( 'rand-rusaweb-dso', 'STG_AR_ANALYST_MGR')}} as sam
        ON pso.CR_ANALYST = sam.CR_ANALYST

left join {{ source( 'datalake-frontoffice-fs_bo', 'PS_RS_GROUP_FLAGS')}} as psgf
        ON c.CORPORATE_CUST_ID = psgf.CORPORATE_CUST_ID
        AND psgf.CORPORATE_SETID = 'SHARE'

left join {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_CUST_LVLFLG')}} as psrcl
        ON c.CUST_ID = psrcl.CUST_ID
        AND psrcl.RNA_FLAG_NAME = 'NSO'

left join {{ source( 'rand-rusaweb-dedup', 'ps_cust_credit')}} as cxcredit
        ON c.setid = cxcredit.setid
        AND c.cust_id = cxcredit.cust_id

inner join {{ source( 'ebi_keys', 'keys_customer')}} as cKey
        on  c.CUST_ID = cKey.customer_id

LEFT JOIN item_activity iact
        ON c.cust_id = iact.cust_id

LEFT JOIN rna_cust_option AS rco
        ON c.cust_id = rco.cust_id
        AND c.setid = rco.setid

LEFT JOIN latitem m
        ON c.rna_billing_method = m.fieldvalue
        AND m.fieldname = 'RNA_BILLING_METHOD'

LEFT JOIN latitem cxstatus
        ON c.cust_status = cxstatus.fieldvalue
        AND cxstatus.fieldname = 'CUST_STATUS'

LEFT JOIN latitem t
        ON c.rna_time_entry_mhd = t.fieldvalue
        AND t.fieldname = 'RNA_TIME_ENTRY_MHD'

LEFT JOIN latitem ccode
        ON cxcredit.risk_code = ccode.fieldvalue
        AND ccode.fieldname = 'RISK_CODE'

LEFT JOIN latitem cclass
        ON cxcredit.credit_class = cclass.fieldvalue
        AND cclass.fieldname = 'CREDIT_CLASS'
        
qualify row_number() over( partition by customer_id order by customer_id desc) = 1
