{{ config(
    tags = ["dim_department", "backoffice", "po_assignments"], 
    alias = "dim_department"
    )
}}

SELECT
  dept.DEPTID AS deptid,
  dept.ACTIVE_STATUS AS active_status,
  dept.ACTIVE_DESC AS active_desc,
  dept.EFFDT AS effdt,
  dept.BUSINESS_UNIT AS business_unit,
  dept.UNIT AS unit,
  dept.UNIT_DESC AS unit_desc,
  dept.RNA_UNIT_TYPE AS rna_unit_type,
  dept.SEGMENT AS segment,
  dept.SEGMENT_DESC AS segment_desc,
  dept.BRANCH AS branch,
  case when regexp_contains( dept.branch_desc, dept.branch) = false 
    then concat (dept.branch_desc, ' (', dept.branch, ')')
    else dept.branch_desc
  end as branch_desc, 
  dept.DISTRICT AS district,
  dept.DISTRICT_DESC AS district_desc,
  dept.REGION AS region,
  dept.REGION_DESC AS region_desc,
  dept.REGIONL2 AS regionl2,
  dept.REGIONL2_DESC AS regionl2_desc,
  dept.REGION_L3 AS region_l3,
  dept.REGION_L3_DESC AS region_l3_desc,
  dept.ZONE AS zone,
  dept.ZONE_DESC AS zone_desc,
  dept.DIVISION AS division,
  dept.DIVISION_DESC AS division_desc,
  dept.CONCEPT_445 AS concept_445,
  dept.CONCEPT_445_DESC AS concept_445_desc,
  dept.CONCEPT AS concept,
  dept.CONCEPT_DESC AS concept_desc,
  dept.COMPANY AS company,
  dept.ENTITY AS entity,
  dept.ENTITY_DESC AS entity_desc,
  dept.ENT AS ent,
  dept.ENTERPRISE AS enterprise,
  dept.BIRTHDATE AS birthdate,
  dept.ADDR AS addr,
  dept.CITY AS city,
  dept.STATE AS state,
  dept.ZIP AS zip,
  dept.INS_BATCH_ID AS ins_batch_id,
  dept.UPD_BATCH_ID AS upd_batch_id,
  dept.OPCO AS opco,
  dept.PHONE AS phone,
  dept.POWER_MARKET AS power_market,
  
  /* include both spellings - support legacy use of the column name */
  keys.dept_key, 
  keys.dept_key as department_key 

from {{ source( 'rand-rusaweb-dims', 'DIM_DEPT')}} as dept

inner join {{ source( 'ebi_keys', 'keys_department')}} as keys
  on dept.UNIT = keys.unit 
