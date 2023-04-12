{{ config(
    tags = ["department_search_all_levels", "backoffice"], 
    alias = "department_search_all_levels"
    )
}}

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code

FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level01_Desc

WHERE Level_Number = 1
    
UNION ALL 

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code

FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level02_Desc
WHERE Level_Number = 2
    
UNION ALL 

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code

FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level03_Desc
WHERE Level_Number = 3

UNION ALL 

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code
FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level04_Desc
WHERE Level_Number = 4
    
UNION ALL 

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code
FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level05_Desc
WHERE Level_Number = 5
        
UNION ALL 

SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code
FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level06_Desc
WHERE Level_Number = 6
    
UNION ALL 
        
SELECT
        a.Concept_Desc,
        a.Level_Desc,
        a.Level_Label,
        a.Level_Number,
        b.branch_code
FROM {{ ref( 'dm_department_search')}} a
LEFT JOIN {{ ref( 'dm_department_dynamic_hierarchy')}} b
    ON a.Level_Desc = b.Level07_Desc
WHERE Level_Number = 7
