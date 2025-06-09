{{
  config(
    materialized = 'table',
    unique_key='sk_country'
    )
}}

SELECT
  DIM_COUNTRIES.sk_country
  , DIM_COUNTRIES.country_name
  , DIM_COUNTRIES.country_code
  , DIM_COUNTRIES.country_flag_url
FROM {{ ref('stg_dim_countries') }} AS DIM_COUNTRIES
INNER JOIN {{ ref('sdd_countries_to_fetch') }} AS FETCH_COUNTRIES
  ON DIM_COUNTRIES.country_code = FETCH_COUNTRIES.country_code
