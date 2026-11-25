USE AirQualityDB
GO

SELECT
    CAST(AQI_Index AS NVARCHAR(100)) AS AQI_Category,
    LEN(CAST(AQI_Index AS NVARCHAR(100))) AS Category_Length,
    COUNT(*) AS Total_Records
FROM AirQuality
WHERE AQI_Index IS NOT NULL
GROUP BY CAST(AQI_Index AS NVARCHAR(100))
ORDER BY Total_Records DESC;


SELECT
    Date,
    CAST(Station AS NVARCHAR(100)) AS Station,
    CAST(AQI_Index AS NVARCHAR(100)) AS AQI_Category,
    AQI_Value
FROM AirQuality
WHERE CAST(AQI_Index AS NVARCHAR(100)) = 'Satisfactor';


SELECT
    CASE
        WHEN CAST(AQI_Index AS NVARCHAR(100)) = 'Satisfactor'
            THEN 'Unclassified (source label)'
        ELSE CAST(AQI_Index AS NVARCHAR(100))
    END AS AQI_Category,

    COUNT(*) AS Total_Records

FROM AirQuality

WHERE AQI_Index IS NOT NULL

GROUP BY
    CASE
        WHEN CAST(AQI_Index AS NVARCHAR(100)) = 'Satisfactor'
            THEN 'Unclassified (source label)'
        ELSE CAST(AQI_Index AS NVARCHAR(100))
    END

ORDER BY Total_Records DESC;
