USE AirQualityDB;
GO

SELECT
    CAST(Station AS NVARCHAR(100)) AS Station,
    ROUND(AVG(TRY_CONVERT(FLOAT, PM2_5)), 2) AS Average_PM25,
    ROUND(AVG(TRY_CONVERT(FLOAT, PM10)), 2) AS Average_PM10
FROM AirQuality
GROUP BY CAST(Station AS NVARCHAR(100))
ORDER BY Average_PM25 DESC;
USE AirQualityDB;
GO

SELECT
    COUNT(*) AS Total_Records,
    SUM(CASE WHEN AQI_Value IS NULL THEN 1 ELSE 0 END) AS Missing_AQI,
    SUM(CASE WHEN PM2_5 IS NULL THEN 1 ELSE 0 END) AS Missing_PM25,
    SUM(CASE WHEN PM10 IS NULL THEN 1 ELSE 0 END) AS Missing_PM10
FROM AirQuality;
USE AirQualityDB;
GO

SELECT
    COUNT(*) AS Total_Records,
    SUM(
        CASE
            WHEN AQI_Index IS NULL
              OR LTRIM(RTRIM(CAST(AQI_Index AS NVARCHAR(100)))) = ''
            THEN 1
            ELSE 0
        END
    ) AS Missing_AQI_Category
FROM AirQuality;
USE AirQualityDB;
GO

SELECT
    CAST(AQI_Index AS NVARCHAR(100)) AS AQI_Category,
    COUNT(*) AS Record_Count
FROM AirQuality
WHERE AQI_Index IS NOT NULL
GROUP BY CAST(AQI_Index AS NVARCHAR(100))
ORDER BY Record_Count DESC;
USE AirQualityDB;
GO

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
ORDER BY Record_Count DESC;
USE AirQualityDB;
GO

SELECT
    COUNT(*) AS Duplicate_Date_Station_Groups
FROM
(
    SELECT
        CAST(Date AS NVARCHAR(50)) AS Reading_Date,
        CAST(Station AS NVARCHAR(100)) AS Station_Name
    FROM AirQuality
    GROUP BY
        CAST(Date AS NVARCHAR(50)),
        CAST(Station AS NVARCHAR(100))
    HAVING COUNT(*) > 1
) AS DuplicateGroups;
USE AirQualityDB;
GO

SELECT
    CAST(Date AS NVARCHAR(50)) AS Reading_Date,
    CAST(Station AS NVARCHAR(100)) AS Station_Name,
    COUNT(*) AS Record_Count
FROM AirQuality
GROUP BY
    CAST(Date AS NVARCHAR(50)),
    CAST(Station AS NVARCHAR(100))
HAVING COUNT(*) > 1;
USE AirQualityDB;
GO

SELECT *
FROM AirQuality
WHERE CAST(Date AS NVARCHAR(50)) = '26 FEBRUARY'
  AND CAST(Station AS NVARCHAR(100)) = 'Kodungaiyur';

USE AirQualityDB;
GO

SELECT
    Duplicate_Date_Station_Flag,
    COUNT(*) AS Record_Count
FROM AirQuality
GROUP BY Duplicate_Date_Station_Flag
ORDER BY Duplicate_Date_Station_Flag;