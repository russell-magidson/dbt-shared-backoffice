{{ config(
    tags = ["department_dynamic_hierarchy", "backoffice"], 
    alias = "department_dynamic_hierarchy"
    )
}}

SELECT distinct 
    CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','Randstad Sourceright','RHS'
                                    , 'US Technologies', 'US Professional Services'
                                    , 'Randstad Life Sciences', 'Healthcare') THEN dept.Concept_Desc
        ELSE 'Randstad USA'
        END as Concept_Desc

/* level 1 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise',"Randstad Sourceright",'RHS') THEN dept.Division_Desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.Region_L3_desc
        WHEN dept.concept_desc in ("Randstad Life Sciences") THEN dept.RegionL2_desc 
        WHEN dept.concept_desc in ("Healthcare") then dept.district_desc
        ELSE 'Randstad USA'
        END as Level01_Desc
    , CASE
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise', 'RHS') THEN 'division' 
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'lob'
        WHEN dept.concept_desc in ("Healthcare") then 'area'
        WHEN dept.concept_desc in ("Randstad Life Sciences") then 'region'
        WHEN dept.concept_desc in ("Randstad Sourceright") then 'company'
        ELSE 'lob' 
        END as Level01_Label

/* level 2 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.zone_Desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.RegionL2_desc
        WHEN dept.concept_desc in ("Healthcare") then dept.branch_desc
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then dept.district_desc
        ELSE dept.branch_desc 
        END as Level02_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'zone'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'region'
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then 'area' 
        WHEN dept.concept_desc in ("Healthcare") then 'branch'
        ELSE 'branch' 
        END as Level02_Label
    
    /* level 3 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.Region_L3_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.Region_desc
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then dept.branch_desc
        END as Level03_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region L3'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'subregion'
        WHEN dept.concept_desc in ("Healthcare") then 'n/a'
        WHEN dept.concept_desc in ("Randstad Life Sciences") then 'branch'
        WHEN dept.concept_desc in ("Randstad Sourceright") then 'business unit'
        END as Level03_Label

    /* level 4 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.RegionL2_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.district_desc
        END as Level04_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region L2'
        WHEN dept.concept_desc = "US Technologies" THEN 'area'
        WHEN dept.concept_desc = "US Professional Services" THEN 'branch'
        WHEN dept.concept_desc in ("Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level04_Label

    /* level 5 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.Region_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.branch_desc
        END as Level05_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region'
        WHEN dept.concept_desc = "US Technologies" THEN 'branch'
        WHEN dept.concept_desc = "US Professional Services" THEN 'practice'
        WHEN dept.concept_desc in ("Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level05_Label

    /* level 6 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.district_desc
        END as Level06_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'district'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services", "Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level06_Label
    
    /* level 7 */
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.branch_desc
        END as Level07_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'branch'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services", "Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level07_Label

    , dept.branch as branch_code  

from {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept

where 1=1
    and UNIT LIKE '%U'
