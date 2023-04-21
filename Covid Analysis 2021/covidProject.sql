--Overview
SELECT * FROM portfolioSQL..CovidDeaths 
ORDER BY 3,4

SELECT DISTINCT(continent) FROM portfolioSQL..CovidDeaths 


--SELECT * FROM portfolioSQL..CovidVaccinations
--ORDER BY 3,4

-- Select Data that we are going to be starting with
SELECT Location, date, total_cases, new_cases, total_deaths, population
From portfolioSQL..CovidDeaths 
ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Argentina 2021
SELECT Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From portfolioSQL..CovidDeaths 
WHERE location LIKE '%Argentina%' 
ORDER BY 1,2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
FROM portfolioSQL..CovidDeaths 
WHERE location LIKE '%Argentina%' AND total_cases IS NOT NULL 
ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM portfolioSQL..CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- DEATH  SECTION 
-- Countries with Highest Death Count per Population
SELECT Location,  MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM portfolioSQL..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population
SELECT location,  MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM portfolioSQL..CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS - CASES DAILY
SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioSQL..CovidDeaths
WHERE continent IS NOT NULL 
 Group By date
order by 1,2


-- GLOBAL NUMBERS - TOTAL
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portfolioSQL..CovidDeaths
WHERE continent IS NOT NULL 
order by 1,2

--VACCINATIONS
-- Total Rolling People Vaccinated
SELECT  dea.continent, dea.location, CAST(dea.date AS date) AS date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM portfolioSQL..CovidDeaths dea
JOIN portfolioSQL..CovidVaccinations  vac 
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY  2,3

-- Using CTE to perform Calculation Percent Population Vaccinated 

WITH  populationvsVaccination(Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
AS (
	SELECT  dea.continent, dea.location, CAST(dea.date AS date) AS date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
	FROM portfolioSQL..CovidDeaths dea
	JOIN portfolioSQL..CovidVaccinations  vac 
		ON dea.location = vac.location
		AND dea.date = vac.date
	WHERE dea.continent IS NOT NULL)

SELECT *, (RollingPeopleVaccinated/Population)*100  AS PercentPopulationVaccinated 
FROM populationvsVaccination

-- Using TEMP TABLE to perform Calculation Percent Population Vaccinated 
DROP Table if exists  #PercentPopulationVaccinate

CREATE TABLE #PercentPopulationVaccinate
( Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric

)

INSERT INTO #PercentPopulationVaccinated 
SELECT  dea.continent, dea.location, CAST(dea.date AS date) AS date, dea.population, vac.new_vaccinations,
	SUM(CAST(vac.new_vaccinations AS int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
	FROM portfolioSQL..CovidDeaths dea
	JOIN portfolioSQL..CovidVaccinations  vac 
		ON dea.location = vac.location
		AND dea.date = vac.date

SELECT *, (RollingPeopleVaccinated/Population)*100  AS PercentVaccinated 
FROM  #PercentPopulationVaccinated  

-- Creating View to store data for later visualizations 
CREATE VIEW TotalRollingPeopleVaccinated AS 
SELECT  dea.continent, dea.location, CAST(dea.date AS date) AS date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
FROM portfolioSQL..CovidDeaths dea
JOIN portfolioSQL..CovidVaccinations  vac 
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 

SELECT * FROM TotalRollingPeopleVaccinated