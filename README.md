# Introduction
An exploratory project gaining insights into data analyst job postings. From examining top-paying jobs, in-demand skills and the crossover of both, I fine tune my SQL skills and see what an inspiring analyst should focus on in order to land their dream job.

Check out all the SQL queries used in this project here: [Project_SQL folder](/Project_SQL/)

# Background
Wanting to develop a better understanding of SQL and see what skills are going to be necessary in continuing my education in my goal of being a data analyst, this project seemed ideal. Starting with an intermediate knowledge of SQL, this project helped me learn some best practices of the industry and  also allowed exploration of the VS Code environment and the basics of both git and github.

All data for this project comes from Luke Barousses’s [SQL Course](https://lukebarousse.com/sql). Fantastic walkthrough and a great dataset to explore.
# Tools I Used
- **SQL:** Knowing this is a core skill for any data analyst, it was no brainer to use SQL to dive into the data and gain useful insights.
- **PostgreSQL:** Database management system used in the course and worked smoothly with the job posting data and other tools in the course.
- **VS Code:** Popular coding environment and this project got me familiar with the basics of this powerful tool.
- **Git & GitHub:** For version control and sharing this project to the world. Excited to use this more in the future.
- **ChatGPT:** For gaining quick insights into queries made with SQL and the creation of basic visuals to enhance reporting.

# The Analysis
All the queries made in this project were designed to investigate specific aspects of the skills needed and the pay allotted to data analyst jobs in either a remote or in person setting. All queries could be easily altered to look at different job titles or more specific locations, depending on the needs of the job hunter.

Here's the approach used on each question:

### 1. Top Paying Data Analyst Jobs
This query focused on what were the highest paying data analyst roles in the dataset. Focusing on remote jobs, this query shows the top ten positions of highest paying opportunities of 2023.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title = 'Data Analyst'  AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's a few insights gathered from this query:
- **Salary Ranges:** Salaries range from $135,000 to $650,000, with Mantys as an outlier at $650,000. Excluding Mantys, most salaries cluster between $135,000 and $165,000.
- **Industry and Company Trends:** Companies span diverse industries, including IT, healthcare, and major tech firms. Emerging players like Overmind are competitive, while Mantys leads with a standout offer.
- **Job Posting Activity:** Higher-paying roles were frequently posted in the latter half of 2023, indicating seasonal hiring trends.
- **Market Demand:** All positions are fully remote and full-time, highlighting strong demand for dedicated remote data analysts across various sectors.



### 2. Top Paying Data Analyst Skills
In this query, a slightly modified version of query one was used as a CTE to determine which relevant data analyst skills were required for the top-paying data analyst jobs. Two inner joins were needed to show which skills were linked to these high-paying jobs.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title = 'Data Analyst'  AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
![Top Skills for High-Paying Jobs](Project_SQL\assets\2_top_paying_job_skills_chart.png)

From the graph shown above (*generated with ChatGPT*) we gain the following insights:
- Python and SQL are highly demanded, appearing in most job postings.
- R ranks closely behind, suggesting strong demand for statistical programming.
- Visualization tools like Tableau, Looker, and Power BI are frequently requested.
- Knowledge of cloud platforms (e.g., AWS) and data manipulation libraries (e.g. Pandas) is also valuable.

### 3. Top In-Demand Data Analyst Skills 
This query is a follow up to the previous, but now the examination of skills on all data analyst job postings rather than just the top-paying postings. This query gives valuable information for new data analysts looking to see what skills they should be focusing on since they may not yet be qualified to land one of the top-paying positions.
```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;
```
- **SQL** looks to be the go-to tool when it comes to skills needed to be a data analyst, with **Excel** and **Python** neck in neck after the leader. All three tools show that cleaning and processing data are a staple in the industry.
- **Visualization** and **Statistical** tools such as **Tableau**, **Power BI**, **R** and **SAS** also play a huge role in relaying the important information that the raw data represents.

|  Skills     |  Demand Count  |
|-------------|----------------|
|  SQL        |  92628         |
|  Excel      |  67031         |
|  Python     |  57326         |
|  Tableau    |  46554         |
|  Power BI   |  39468         |
|  R          |  30075         |
|  SAS        |  28068         |
|  PowerPoint |  13848         |
|  Word       |  13591         |
|  SAP        |  11297         |
*Table of the demand for the top ten skills in data analyst job postings*

### 4. Top Paying Data Analyst Skills
This query examined the top skills based on salary. This query encompasses all job postings for data analysts and reveals how different skills can impact salary levels and which skills are most financially beneficial.
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) as average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```
Key Takeaways:
- **Specialization Pays:** Focus on niche, high-demand skills like **Solidity**, **MXNet**, or **Terraform** to stand out.
- **AI and Data Are Exploding:** Tools related to machine learning (e.g., **Keras**, **TensorFlow**) are excellent investments for career growth.
- **Legacy Systems Remain Relevant:** Skills like **Perl** and **SVN** show that maintaining older systems can be highly lucrative.
- **Infrastructure Knowledge is Key:** Familiarity with tools for automating and scaling infrastructure, like **Terraform**, is invaluable in DevOps-heavy environments.

|  Skills       |  Average Salary  |
|---------------|------------------|
|  SVN          |  400000          |
|  Solidity     |  179000          |
|  Couchbase    |  160515          |
|  Datarobot    |  155485          |
|  Golang       |  155000          |
|  MXNet        |  149000          |
|  Dplyr        |  147633          |
|  vmware       |  147500          |
|  Terraform    |  146733          |
|  twilio       |  138500          |
|  gitlab       |  134126          |
|  kafka        |  129999          |
|  puppet       |  129820          |
|  keras        |  127013          |
|  pytorch      |  125226          |
|  perl         |  124685          |
|  ansible      |  124370          |
|  hugging face |  123950          |
|  tensorflow   |  120646          |
|  cassandra    |  118406          |
|  notion       |  118091          |
|  atlassian    |  117965          |
|  bitbucket    |  116711          |
|  airflow      |  116387          |
|  scala        |  115479          |
*Table of top paying skills in data analyst job postings*

### 5. Optimal Data Analyst Skills
This query looks at which data analyst skills are both in demand and high paying. Learning these skills could lead to a data analyst to land a job that has job security and a healthy compensation. 
```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
), avg_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) as average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 25;
```
This query produces results that weren’t unexpected but give us a few concrete takeaways:

- **SQL** is key in the data analyst field with having the highest demand by a wide margin. **Excel** comes in second, but with a demand and compensation lower than that of **SQL**.
- **Python** remains the most popular programming language for data analysts and, while not as in demand as **SQL**, has better compensation related to job postings where it’s required.
- For statistical analysis **R** is still on top and compensates in a similar fashion to **python**.
- Visualization software such as **Tableau** and **Power BI** have high demand and have high comparable compensations.

# What I learned
While working through this course and crafting this project, I’ve been able to take my intermediate knowledge of SQL and refine it to an advanced level:
- Using joins and WITH clauses and real world data allowed me to gain valuable insights that can allow for better decision making in the future.
- Writing and adjusting multiple SQL queries that played off each other gave me the opportunity to quickly produce queries without having to reinvent the wheel each time.
- Working with real-world data and answering questions relevant to an ongoing passion of mine gave me knowledge of how to gather actionable information.

# Conclusions
### Insights
1. **SQL as the Core Data Analyst Skill**:
SQL dominates the required skills, with Excel and Python close behind, reflecting the industry's heavy focus on data cleaning and processing. Mastery of SQL ensures strong job prospects, as it is the most requested skill across postings.
2. **Remote Work and Specialized Skill Demand Define the Market**:
The demand for fully remote, full-time data analyst roles highlights a strong industry shift toward flexible work arrangements. SQL, Python, and statistical tools like R are critical, while specialization in niche technologies like Solidity or Terraform offers significant leverage in standing out.
3. **Visualization and Statistical Tools Enhance Job Competitiveness**:
Proficiency in Tableau, Power BI, and R is essential for translating raw data into actionable insights. These tools not only fulfill reporting needs but also command competitive compensation, making them valuable career investments.
4. **Seasonal Hiring Trends for High-Paying Roles**:
The clustering of higher-paying job postings in the latter half of 2023 suggests a seasonal hiring peak. Professionals aiming for competitive salaries should time their job search accordingly to align with market demand.

### Closing Thoughts
I initially started this course to get better with SQL, and I most certainly did, but I didn’t realize all the other skills I would learn and be introduced to while doing the end project. Working with VS Code and now learning github has given me the understanding and confidence to work on more projects in the future. Working with the real-world data throughout the project has also given me a better insight on what to focus my time on learning next. I have by no means mastered SQL and have a lot to learn, but I now know that I have the confidence in saying that I can perform queries on large data sets and produce valuable insights


