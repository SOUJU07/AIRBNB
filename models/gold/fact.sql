{% set configs = [
    {
        "table": "AIRBNB.GOLD.OBT",
        "columns": "GOLD_OBT.BOOKING_ID,GOLD_OBT.LISTING_ID,GOLD_OBT.HOST_ID,GOLD_OBT.TOTAL_BOOKING_AMOUNT,GOLD_OBT.CLEANING_FEE,
        GOLD_OBT.SERVICE_FEE,GOLD_OBT.ACCOMMODATES,GOLD_OBT.BEDROOMS,GOLD_OBT.BATHROOMS",
        "alias": "GOLD_OBT"
    },
    {
        "table": "AIRBNB.GOLD.DIM_LISTINGS",
        "columns": "",
        "alias": "GOLD_LISTINGS",
        "join_condition": "GOLD_OBT.listing_id = GOLD_LISTINGS.listing_id"
    },
    {
        "table": "AIRBNB.GOLD.DIM_HOSTS",
        "columns": "",
        "alias": "GOLD_HOSTS",
        "join_condition": "GOLD_OBT.HOST_id = GOLD_HOSTS.host_id"
    }
] %}

select 
    
        {{ configs[0]["columns"] }}
    
from
    {% for config in configs %}
    {% if loop.first %}
        {{ config["table"] }} as {{ config["alias"] }}
    {% else %}
        left join {{ config["table"] }} as {{ config["alias"] }}
        on {{ config["join_condition"] }}
    {% endif %}
    {% endfor %}