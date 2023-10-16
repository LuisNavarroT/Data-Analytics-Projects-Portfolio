-- Check data bases 

SELECT * 
FROM PortfolioProjectCovid.dbo.CovidDeathscut
where continent is not null
ORDER BY 3, 4

SELECT * 
FROM PortfolioProjectCovid.dbo.CovidVaxcut
ORDER BY 3, 4

-- Select data to be used

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeathscut
ORDER BY 1,2 

-- Looking at total Cases vs Total deaths

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
FROM CovidDeathscut
WHERE location like '%bolivia%'
ORDER BY 5 

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
FROM CovidDeathscut
WHERE location like '%Ireland%'
ORDER BY 5

-- Looking at total cases vs Population

SELECT Location, date, total_cases, Population, (total_cases/population)*100 as CovidPercentage
FROM CovidDeathscut
WHERE location like '%Ireland%'
ORDER BY 1,2

-- Looking at the Countries with the highest infection % vs population

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount,
MAX(total_cases/population)*100 as MaxCovidPercentage
FROM CovidDeathscut
GROUP BY Location, Population
ORDER BY MaxCovidPercentage DESC

-- Looking at Countries with the highest death count per population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeathscut
where continent is not null
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Looking at Countries with the Lowest death count per population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeathscut
where continent is not null 
GROUP BY Location
ORDER BY TotalDeathCount 

-- Breaking down by continent

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeathscut
where continent is null
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Global percentage of deaths

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM CovidDeathscut
WHERE continent is not null 
ORDER BY 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as PeopleVaccinatedTotal
From CovidDeathscut As dea
Join CovidVaxcut As vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

--Using CTE

with PopulationVsVaccination (Continent, Location, Date, Population, new_vaccinations, PeopleVaccinatedTotal)
as(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as PeopleVaccinatedTotal
From CovidDeathscut As dea
Join CovidVaxcut As vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)

SELECT *, (PeopleVaccinatedTotal/population)*100 AS VacPercentage
FROM PopulationVsVaccination

-- Using temp table

Drop table if exists #PercentOfVaccination
Create Table #PercentOfVaccination
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
PeopleVaccinatedTotal numeric
)

INSERT into #PercentOfVaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as PeopleVaccinatedTotal
From CovidDeathscut As dea
Join CovidVaxcut As vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

SELECT *, (PeopleVaccinatedTotal/population)*100 AS VacPercentage
FROM #PercentOfVaccination

-- Creating View to store data for later visualizations

Create View PercentOfVaccination as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeathscut As dea
Join CovidVaxcut As vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

SELECT * 
FROM PercentOfVaccination 