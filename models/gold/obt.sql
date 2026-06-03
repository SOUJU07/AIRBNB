{% set configs = [
    {
        "table": "AIRBNB.SILVER.SILVER_BOOKINGS",
        "columns": "silver_bookings.*",
        "alias": "silver_bookings"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_LISTINGS",
        "columns": "silver_listings.property_type as property_type, silver_listings.room_type as room_type, silver_listings.city as city, silver_listings.country as country, silver_listings.accommodates as accommodates, silver_listings.bedrooms as bedrooms, silver_listings.bathrooms as bathrooms, silver_listings.price_per_night_tag as price_per_night_tag",
        "alias": "silver_listings",
        "join_condition": "silver_listings.listing_id = silver_bookings.listing_id"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_HOSTS",
        "columns": "silver_hosts.host_id as host_id, silver_hosts.host_name as host_name, silver_hosts.host_since as host_since, silver_hosts.is_superhost as is_superhost, silver_hosts.response_rate as response_rate",
        "alias": "silver_hosts",
        "join_condition": "silver_hosts.host_id = silver_listings.host_id"
    }
] %}

select 
    {% for config in configs %}
        {{ config["columns"] }}{% if not loop.last %},{% endif %}
    {% endfor %}
from
    {% for config in configs %}
    {% if loop.first %}
        {{ config["table"] }} as {{ config["alias"] }}
    {% else %}
        left join {{ config["table"] }} as {{ config["alias"] }}
        on {{ config["join_condition"] }}
    {% endif %}
    {% endfor %}