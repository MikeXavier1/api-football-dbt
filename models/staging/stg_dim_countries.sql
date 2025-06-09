{{
  config(
    materialized = 'view',
    schema = 'staging',
    unique_key='sk_country'
    )
}}

WITH

SOURCE AS (
  SELECT
      {{ 
        generate_surrogate_key([
          'COUNTRY_CODE',
        ])
      }} AS sk_country
      , CAST(country_name AS STRING) AS country_name
      , CAST(country_code AS STRING) AS country_code
      , CAST(country_flag_url AS STRING) AS country_flag_url
  FROM {{ source('raw', 'countries') }} AS DIM_COUNTRIES
)

SELECT
  SOURCE.sk_country
  , SOURCE.country_name
  , SOURCE.country_code
  , SOURCE.country_flag_url
FROM SOURCE
LEFT JOIN {{ ref('sdd_countries_duplicated') }} AS DUPLICATED_COUNTRIES
  ON SOURCE.country_name = DUPLICATED_COUNTRIES.country_name
WHERE DUPLICATED_COUNTRIES.is_active IS NOT FALSE
