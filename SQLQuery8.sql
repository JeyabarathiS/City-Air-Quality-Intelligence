USE AirQualityDB;
GO

SELECT
    CAST(Station AS NVARCHAR(100)) AS Station,

    COUNT(*) AS Total_Records,

    ROUND(AVG(TRY_CONVERT(FLOAT, AQI_Value)), 2)
        AS Average_AQI,

    MAX(TRY_CONVERT(FLOAT, AQI_Value))
        AS Highest_AQI,

    SUM(
        CASE
            WHEN TRY_CONVERT(FLOAT, AQI_Value) > 150
            THEN 1
            ELSE 0
        END
    ) AS High_AQI_Count,

    ROUND(AVG(TRY_CONVERT(FLOAT, PM2_5)), 2)
        AS Average_PM25,

    ROUND(AVG(TRY_CONVERT(FLOAT, PM10)), 2)
        AS Average_PM10

FROM AirQuality

GROUP BY CAST(Station AS NVARCHAR(100))

ORDER BY Average_AQI DESC;
USE AirQualityDB;
GO

SELECT
    COUNT(*) AS Total_Records,

    ROUND(AVG(TRY_CONVERT(FLOAT, AQI_Value)), 2)
        AS Overall_Average_AQI,

    MAX(TRY_CONVERT(FLOAT, AQI_Value))
        AS Overall_Highest_AQI,

    ROUND(AVG(TRY_CONVERT(FLOAT, PM2_5)), 2)
        AS Overall_Average_PM25,

    ROUND(AVG(TRY_CONVERT(FLOAT, PM10)), 2)
        AS Overall_Average_PM10

FROM AirQuality;
USE AirQualityDB;
GO

WITH CategoryCounts AS
(
    SELECT
        CASE
            WHEN LTRIM(RTRIM(CAST(AQI_Index AS NVARCHAR(100)))) = 'Satisfactor'
            THEN 'Satisfactory'
            ELSE LTRIM(RTRIM(CAST(AQI_Index AS NVARCHAR(100))))
        END AS AQI_Category,
        COUNT(*) AS Record_Count
    FROM AirQuality
    WHERE AQI_Index IS NOT NULL
    GROUP BY
        CASE
            WHEN LTRIM(RTRIM(CAST(AQI_Index AS NVARCHAR(100)))) = 'Satisfactor'
            THEN 'Satisfactory'
            ELSE LTRIM(RTRIM(CAST(AQI_Index AS NVARCHAR(100))))
        END
)
SELECT
    AQI_Category,
    Record_Count,
    ROUND(
        CAST(Record_Count * 100.0 / SUM(Record_Count) OVER() AS FLOAT),
        2
    ) AS Percentage
FROM CategoryCounts
ORDER BY Record_Count DESC;