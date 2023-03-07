{{ config(
    tags = ["department_search", "backoffice"], 
    alias = "department_search"
    )
}}

-- level 1
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise',"Randstad Sourceright",'RHS') THEN dept.Division_Desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.Region_L3_desc
        WHEN dept.concept_desc in ("Randstad Life Sciences") THEN dept.RegionL2_desc 
        WHEN dept.concept_desc in ("Healthcare") then dept.district_desc 
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise', 'RHS') THEN 'division' 
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'lob'
        WHEN dept.concept_desc in ("Healthcare") then 'area'
        WHEN dept.concept_desc in ("Randstad Life Sciences") then 'region'
        WHEN dept.concept_desc in ("Randstad Sourceright") then 'company'
        END as Level_Label
    , 1 as Level_Number
    , cast( null as string) as branch_id
    
    FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 2
SELECT distinct 
        dept.Concept_Desc
    ,CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.zone_Desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.RegionL2_desc
        WHEN dept.concept_desc in ("Healthcare") then dept.branch_desc
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then dept.district_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'zone'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'region'
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then 'area'
        WHEN dept.concept_desc in ("Healthcare") then 'branch' 
        END as Level_Label
    , 2 as Level_Number
    , CASE 
        WHEN dept.concept_desc = "Healthcare" THEN branch
        ELSE cast( null as string)
        END as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 3
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.Region_L3_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.Region_desc
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") then dept.branch_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region L3'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN 'subregion'
        WHEN dept.concept_desc in ("Healthcare") then 'n/a'
        WHEN dept.concept_desc in ("Randstad Life Sciences") then 'branch'
        WHEN dept.concept_desc in ("Randstad Sourceright") then 'business unit'
        END as Level_Label
        , 3 as Level_Number
    , CASE 
        WHEN dept.concept_desc in ("Randstad Sourceright","Randstad Life Sciences") THEN branch
        ELSE cast( null as string)
        END as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 4
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.RegionL2_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.district_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region L2'
        WHEN dept.concept_desc = "US Technologies" THEN 'area'
        WHEN dept.concept_desc = "US Professional Services" THEN 'branch'
        WHEN dept.concept_desc in ("Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level_Label
    , 4 as Level_Number
    , CASE 
        WHEN dept.concept_desc = "US Professional Services" THEN branch
        ELSE cast( null as string)
        END as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 5
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.Region_desc
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services") THEN dept.branch_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'region'
        WHEN dept.concept_desc = "US Technologies" THEN 'branch'
        WHEN dept.concept_desc = "US Professional Services" THEN 'practice'
        WHEN dept.concept_desc in ("Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level_Label
    , 5 as Level_Number
    , CASE 
        WHEN dept.concept_desc = "US Technologies" THEN branch
        ELSE cast( null as string)
        END as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 6
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.district_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'district'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services", "Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level_Label
    , 6 as Level_Number
    , cast( null as string) as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'

union all

-- level 7
SELECT distinct 
        dept.Concept_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN dept.branch_desc
        END as Level_Desc
    , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN 'branch'
        WHEN dept.concept_desc in ("US Technologies", "US Professional Services", "Randstad Life Sciences", "Healthcare","Randstad Sourceright") then 'n/a'
        END as Level_Label
    , 7 as Level_Number
        , CASE 
        WHEN dept.concept_desc in ('MC', 'RIS', 'RCS', 'Franchise','RHS') THEN branch
        ELSE cast( null as string)
        END as branch_id

FROM {{ source( 'rand-rusaweb-shared-dim-fact', 'dim_department')}} as dept
    where 1=1
    and UNIT LIKE '%U'
