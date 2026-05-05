SELECT driver_id,driver_name,statuss,trust_score,distance_km
FROM Drivers
WHERE status = 'AVAILABLE'
  AND trust_score >= 80
  AND trust_score >= 0
ORDER BY distance_km ASC, trust_score DESC;
