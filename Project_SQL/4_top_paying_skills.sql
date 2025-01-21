/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

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

/*
Key Takeaways for Professionals
- Specialization Pays: Focus on niche, high-demand skills like Solidity, MXNet, or Terraform to stand out.
- AI and Data Are Exploding: Tools related to machine learning (e.g., Keras, TensorFlow) are excellent investments for career growth.
- Legacy Systems Remain Relevant: Skills like Perl and SVN show that maintaining older systems can be highly lucrative.
- Infrastructure Knowledge is Key: Familiarity with tools for automating and scaling infrastructure, like Terraform, is invaluable in DevOps-heavy environments.


[
  {
    "skills": "svn",
    "average_salary": "40
  },
  {
    "skills": "solidity",
    "average_salary": "179000.00"
  },
  {
    "skills": "couchbase",
    "average_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "average_salary": "155485.50"
  },
  {
    "skills": "golang",
    "average_salary": "155000.00"
  },
  {
    "skills": "mxnet",
    "average_salary": "149000.00"
  },
  {
    "skills": "dplyr",
    "average_salary": "147633.33"
  },
  {
    "skills": "vmware",
    "average_salary": "147500.00"
  },
  {
    "skills": "terraform",
    "average_salary": "146733.83"
  },
  {
    "skills": "twilio",
    "average_salary": "138500.00"
  },
  {
    "skills": "gitlab",
    "average_salary": "134126.00"
  },
  {
    "skills": "kafka",
    "average_salary": "129999.16"
  },
  {
    "skills": "puppet",
    "average_salary": "129820.00"
  },
  {
    "skills": "keras",
    "average_salary": "127013.33"
  },
  {
    "skills": "pytorch",
    "average_salary": "125226.20"
  },
  {
    "skills": "perl",
    "average_salary": "124685.75"
  },
  {
    "skills": "ansible",
    "average_salary": "124370.00"
  },
  {
    "skills": "hugging face",
    "average_salary": "123950.00"
  },
  {
    "skills": "tensorflow",
    "average_salary": "120646.83"
  },
  {
    "skills": "cassandra",
    "average_salary": "118406.68"
  },
  {
    "skills": "notion",
    "average_salary": "118091.67"
  },
  {
    "skills": "atlassian",
    "average_salary": "117965.60"
  },
  {
    "skills": "bitbucket",
    "average_salary": "116711.75"
  },
  {
    "skills": "airflow",
    "average_salary": "116387.26"
  },
  {
    "skills": "scala",
    "average_salary": "115479.53"
  }
]0000.00"
*/