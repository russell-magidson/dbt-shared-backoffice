{{ config(
    tags = ["dim_employee", "backoffice"], 
    alias = "dim_employee"
    )
}}

WITH latest_job AS (
    SELECT emplid, jobcode, empl_status, deptid, empl_class, company, termination_dt
    
    from {{ source( 'rand-rusaweb-dedup', 'ps_job')}}
        
    QUALIFY ROW_NUMBER() OVER (PARTITION BY emplid  ORDER BY effdt DESC, effseq DESC) = 1
    ),

email_ads AS (
    SELECT emplid, e_addr_type, email_addr, pref_email_flag
    
    from {{ source( 'datalake-frontoffice-hr_bo', 'PS_EMAIL_ADDRESSES')}}
        
    WHERE e_addr_type = 'BUSN' OR pref_email_flag = 'Y'
    ),

max_oprid AS (
    SELECT oprid, emplid
    
    from {{ source( 'rand-rusaweb-dedup', 'psoprdefn')}}
        
    QUALIFY ROW_NUMBER() OVER (PARTITION BY emplid ORDER BY lastupddttm DESC) = 1
    ),

latest_rt_email as ( 
    select email, userID
    
    from {{ source( 'datalake-frontoffice-rt', 'CorporateUser')}}
    
    qualify row_number() over (partition by email  order by userDateAdded desc) = 1
    ), 

latest_rls_email as ( 
    select email, userID
    
    from {{ source( 'datalake-frontoffice-rls', 'CorporateUser')}}
    
    qualify row_number() over (partition by email  order by userDateAdded desc) = 1
) 

SELECT 
        latest_job.emplid AS employee_id
    , COALESCE(
                (SELECT max(name)
                
                from {{ source( 'rand-rusaweb-dedup', 'ps_names')}} as inn_names
                    
                WHERE name_type = 'PRF' AND inn_names.emplid = latest_job.emplid),
                    (SELECT max(name)
                
                    from {{ source( 'rand-rusaweb-dedup', 'ps_names')}} as inn_names
                    
                    WHERE name_type = 'PRI' AND inn_names.emplid = latest_job.emplid), ''
                ) AS employee_name
    , latest_job.jobcode
    , jobcodes.descr
    , jobcodes.job_function as job_function
    , latest_job.empl_status AS employee_status
    , latest_job.deptid AS department_id
    , max_oprid.oprid
    , email_ad_bus.email_addr AS business_email_address
    , email_ad_pref.email_addr AS preferred_email_address
    , latest_job.company
    , latest_job.empl_class
    , latest_job.termination_dt
    , emp.position_nbr as position_number
    , emp.per_org as employee_type
    , emp.rehire_dt as rehire_date
    , emp.hire_dt as hire_date
    , emp.orig_hire_dt as orig_hire_date
    , emp.dept_entry_dt as department_entry_date
    , emp.job_entry_dt as job_entry_date
    , emp.position_entry_dt as position_entry_date
    , emp.cmpny_seniority_dt as company_seniority_date
    , reports.supervisor_id as supervisor_emplid
    , reports.supervisor_name as supervisor_name
    , rtEmail.userID as RTBullhornUserID
    , rlsEmail.userID as RLSBullhornUserID
    , eKey.employee_key
    
FROM latest_job

inner join {{ source( 'ebi_keys', 'keys_employee')}} as eKey
    on  latest_job.emplid = eKey.employee_id

inner join {{ source( 'rand-rusaweb-dedup', 'ps_jobcode_tbl')}} as jobcodes
    ON latest_job.jobcode = jobcodes.jobcode

left JOIN {{ source( 'datalake-frontoffice-hr_bo', 'PS_EMPLOYEES')}} as emp
    on latest_job.emplid = emp.emplid            

left join {{ source( 'datalake-frontoffice-hr_bo', 'PS_RNA_EMP_REPORTS')}} as reports
    on latest_job.emplid = reports.emplid

LEFT JOIN max_oprid
    ON latest_job.emplid = max_oprid.emplid
    
LEFT JOIN email_ads AS email_ad_pref
    ON latest_job.emplid = email_ad_pref.emplid
    AND email_ad_pref.pref_email_flag = 'Y'
    
LEFT JOIN email_ads AS email_ad_bus
    ON latest_job.emplid = email_ad_bus.emplid
    AND email_ad_bus.e_addr_type = 'BUSN'
    
left join latest_rt_email as rtEmail 
    on rtEmail.email = email_ad_bus.email_addr
    
left join latest_rls_email as rlsEmail 
    on rlsEmail.email = email_ad_bus.email_addr
    
WHERE latest_job.empl_class IN ('B','RIN')
AND latest_job.company IN ('RTI','RPI','RAN')
