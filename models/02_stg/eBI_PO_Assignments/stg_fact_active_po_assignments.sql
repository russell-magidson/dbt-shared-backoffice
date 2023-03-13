{{ config(
    tags = ["fact_active_po_assignments", "po_assignments"], 
    alias = 'fact_active_po_assignments'
    )
}}

WITH rfph AS 
    /*exclude inactive purchase orders FROM PS_RNA_FO_PO_HDR*/ 
    (SELECT *
        FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_FO_PO_HDR')}} 
        WHERE CA_PO_STATUS <> 'I'
        )

,rco AS   
    (SELECT setid
            ,cust_id
            ,effdt
            ,validate_po
            ,rna_weekday
            ,CASE  WHEN rna_weekday = '1' then 'Sunday'
                    WHEN rna_weekday = '2' then 'Monday'
                    WHEN rna_weekday = '3' then 'Tuesday'
                    WHEN rna_weekday = '4' then 'Wednesday'
                    WHEN rna_weekday = '5' then 'Thursday'
                    WHEN rna_weekday = '6' then 'Friday'
                    WHEN rna_weekday = '7' then 'Saturday' 
                END AS customer_we
        FROM {{ source( 'rand-rusaweb-dedup', 'ps_rna_cust_option')}} 
        WHERE effdt <= CURRENT_DATE()
        QUALIFY ROW_NUMBER() OVER (PARTITION BY setid, cust_id ORDER BY effdt  DESC NULLS LAST) = 1
        )

,avgweekbill AS
    (SELECT ca_po_id
            ,ROUND(SUM(gross_extended_amt / 7) , 2) AS average_per_week
            ,SUM(gross_extended_amt) AS amount_billed    
        FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_INTFCBICMP')}}
        WHERE trans_dt > DATE_ADD(CURRENT_DATE(), INTERVAL -50 DAY)
        GROUP BY ca_po_id
        )

,latest_effdt_per_assign_id as (
    SELECT assignment_id, effdt, oprid, rna_role_name
    FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_FO_ASGN_CMSN_DL')}}
    WHERE(RNA_ROLE_NAME like '%Order%' OR RNA_ROLE_NAME like '%Sales%')
    QUALIFY ROW_NUMBER() OVER (PARTITION BY assignment_id, oprid ORDER BY effdt DESC) = 1
)

,producer_info AS
    (SELECT A.assignment_id
            ,STRING_AGG(CASE 
                WHEN COALESCE(P1.oprdefndesc, '') LIKE '%Disabled%' 
                THEN COALESCE(D.employee_name, '') 
                ELSE COALESCE(P1.oprdefndesc, '') 
                END, '|')    AS producer
            ,STRING_AGG(D.business_email_address, '|')  AS producer_email
            ,STRING_AGG(D.employee_status, '|')    AS producer_status
        FROM latest_effdt_per_assign_id A
        
        LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'psoprdefn')}} as P1
                ON A.oprid = P1.oprid
        LEFT JOIN {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_employee')}} as D
                ON P1.emplid = D.employee_id
        GROUP BY a.assignment_id
        )

,rbps_ddup AS 
    (SELECT *
    FROM {{ source( 'rand-rusaweb-dedup', 'ps_rna_bh_plac_stg')}} as rbps
    QUALIFY ROW_NUMBER() OVER (PARTITION BY rna_bh_corp_id, rna_bh_plc_id ORDER BY seqno DESC) = 1
    )

SELECT
        ROW_NUMBER() OVER() AS row_number
    ,ra.CUST_ID AS customer_id
    ,ra.DEPTID  AS department_id
    ,ra.ASSIGNMENT_ID AS assignment_id
    ,CASE WHEN ra.END_ACTUAL_DATE IS NULL THEN 'A' 
            ELSE 'T' 
            END AS assignment_status
    ,ra.EMPLID AS employee_id
    ,COALESCE(pd.NAME, vam.NAME) AS emp_name
    ,rapt.CA_PO_ID AS po_tracking_id
    ,rfph.DESCR AS po_number
    ,CASE WHEN psxl.XLATLONGNAME IN ('Funds', 'Funds & Date') THEN rfph.PO_AMT1 
            ELSE NULL --dummy value
            END AS po_amount   
    ,CASE WHEN psxl.XLATLONGNAME IN ('Funds', 'Funds & Date')THEN  rfph.REMAINING_AMOUNT 
            ELSE NULL --dummy value
            END AS po_remaining_amt 
    ,rfph.START_DT AS po_start_date
    ,rfph.END_DATE AS po_end_date
    ,rcpo.rna_tracking_funds
    ,psxl.XLATLONGNAME AS po_tracking_method
    ,CASE WHEN IFNULL(rapt.ca_po_id, '') = '' THEN 'Missing PO Track ID' 
            ELSE 'No Issue'
            END AS po_alert_1       
    ,CASE WHEN DATE_DIFF(DATE (rfph.end_date), DATE (CURRENT_DATE()), DAY) <= 0 THEN 'Expired'
            ELSE 'No Issue'
            END AS po_alert_2  
    ,CASE WHEN DATE_DIFF(DATE (rfph.end_date), DATE (CURRENT_DATE()), DAY) BETWEEN 0 AND 45 THEN 'Near Expiration'
            ELSE 'No Issue'
            END AS po_alert_3  
    ,CASE WHEN rfph.remaining_amount = 0 THEN 'Exhausted'
            ELSE 'No Issue'
            END AS po_alert_4  
    ,CASE WHEN (rfph.PO_AMT1 != 0.0) AND (rfph.remaining_amount / rfph.po_amt1) <= .25 THEN 'Near Funds Exhaustion'
            ELSE 'No Issue'
            END AS po_alert_5
    /* keep the individual alerts, combine them in DWH or DM queries */
    ,CASE WHEN psxl.XLATLONGNAME = 'Presentment Only'
            THEN NULL
            ELSE DATE_DIFF(DATE (rfph.end_date), DATE (current_date()), DAY) 
        END  AS days_to_expiration
    ,CASE WHEN psxl.XLATLONGNAME = 'Presentment Only'
            THEN NULL
            ELSE CAST(TRUNC(DATE_DIFF(DATE (rfph.end_date), DATE (current_date()), DAY)/7 )AS INT64)
        END AS weeks_to_expiration
    -- average_per_week  
    ,avgweekbill.average_per_week
    ,cust.bill_cycle_id as bill_cucle
    ,rco.customer_we
    ,cust.require_po
    ,rco.VALIDATE_PO as po_tracking
    ,pi.producer
    ,pi.producer_email
    ,pi.producer_status
    ,rbps.end_est_date as estimated_end_date
    ,rbps.rna_bh_plc_id as bh_placement_id
    ,bmxm.name AS md
    ,(SELECT DATETIME(max(ra.source_insert_datetime), "America/New_York") AS data_as_of_est
            FROM {{ source( 'rand-rusaweb-dedup', 'ps_rs_assignment')}}
        ) as data_as_of_est
    ,cust.cust_key
    ,dept.dept_key

FROM  {{ source( 'rand-rusaweb-dedup', 'ps_rs_assignment')}} as ra

LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'ps_personal_data')}} as pd
    ON ra.emplid = pd.emplid

LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'ps_vi_ave_master')}} as vam
    ON ra.emplid = vam.vi_aveid

LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'ps_rna_asgn_po_trk')}} as rapt
    ON ra.assignment_id = rapt.assignment_id  

LEFT JOIN rfph 
    ON rapt.ca_po_id = rfph.ca_po_id

LEFT JOIN {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_CUST_PO_OPT')}} as rcpo
    ON ra.CUST_ID = rcpo.CUST_ID

LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'psxlatitem_fs')}} as psxl
    ON rcpo.RNA_TRACKING_FUNDS = psxl.FIELDVALUE 
    AND psxl.FIELDNAME = 'RNA_TRACKING_FUNDS'

LEFT JOIN rco  
    ON rcpo.SETID = rco.SETID 
    AND rcpo.CUST_ID = rco.CUST_ID

LEFT JOIN avgweekbill 
    ON rapt.ca_po_id = avgweekbill.ca_po_id

LEFT JOIN rbps_ddup  AS rbps
    ON ra.project_id = rbps.order_id

LEFT JOIN {{ source( 'rand-rusaweb-dedup', 'bu_manager_nxtlvl_mgr_live')}} as bmxm
    ON ra.deptid = bmxm.branch 

LEFT JOIN producer_info pi 
    ON pi.assignment_id = ra.assignment_id

LEFT JOIN {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_customer')}} as cust
    ON cust.customer_id =  ra.CUST_ID

LEFT JOIN {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    ON dept.branch =  ra.DEPTID
    AND dept.UNIT LIKE '%U'

WHERE 1 = 1
    AND ra.END_ACTUAL_DATE IS NULL
    and cust.po_customer = 'Yes'
