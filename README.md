# Emotional Pattern Analysis and Loan-Emotion Correlation Dashboard

## Overview
This project focuses on the analysis of emotional patterns and their correlation with loan operations. It includes emotional pattern analysis, loan-emotion correlation, lending operation assessment, machine learning modeling, and overall visualization. The goal is to understand how emotions impact loan decisions and to provide data-driven insights into lending operations.

## Key Features

### Emotional Pattern Analysis:
- Identifies dominant emotional patterns over time.
- Analyzes how emotions vary based on relationships, time of day, and other contexts.

### Loan-Emotion Correlation:
- Examines the relationship between emotional patterns and loan terms (amount, interest rate).
- Identifies emotional factors influencing loan outcomes (approved, denied, default).

### Lending Operation Assessment:
- Evaluates the effectiveness of lending policies (interest rates, loan amounts) in terms of default rates.
- Assesses loan disbursement, performance, and revenue trends over time.

### Machine Learning:
- Predicts loan terms based on emotional and contextual data.
- Includes model interpretation using SHAP values.

### Dashboard:
- Visualizes emotional patterns and loan data using interactive graphs and slicers.
- Provides insights into the relationship between emotions and loan amounts, emotional intensity over time, and other key factors.

## Data
The project utilizes data from three primary sources:
- **Emotional Data**: Captures users' emotional states (e.g., intensity, relationship, time of day).
- **Loan Data**: Includes loan-related information (e.g., loan amount, interest rate, status).
- **User Data**: Contains user-related attributes (e.g., credit score, approved/denied dates, credit limit).

## Workflow
1. **Data Merging**: Merged tables (`loans`, `users`, `emotional_data`) into a single DataFrame for analysis.
2. **Data Exploration**: Conducted data exploration and identified missing values, outliers, and patterns.
3. **Data Preprocessing**: Treated outliers, normalized the data, and handled missing values.
4. **Emotional Pattern Analysis**: Performed visual analysis of emotional patterns and their contexts.
5. **Loan-Emotion Correlation**: Analyzed correlations between emotional factors and loan outcomes.
6. **Lending Operation Assessment**: Evaluated loan performance and profitability over time.
7. **Machine Learning**: Built and evaluated predictive models for loan terms.
8. **Visualization**: Created a comprehensive Power BI dashboard to visualize key metrics.

## Tools and Technologies
- **Python**: For data processing, analysis, and machine learning.
- **Pandas**: Data manipulation and cleaning.
- **Power BI**: For interactive data visualization and dashboard creation.
- **SQLite**: Database for storing and querying loan, user, and emotional data.
- **Git**: Version control and project management.

## Key Visualizations
- **Emotional Pattern Dashboard**: Includes interactive bubble and bar charts displaying the relationship between emotions, loan amounts, relationships, and time of day.
- **Slicers**: Allow users to filter by relationship and primary emotion to explore specific patterns.


## Additional Resources
- All the required Python scripts, Jupyter Notebook, SQL query file, and Power BI dashboard file are included.
- Detailed explanations of the code, SQL query, and visualizations are provided in three separate Word documents.

## Future Enhancements
- Implement advanced machine learning models for better loan term predictions.
- Add additional filtering options to the Power BI dashboard.
- Explore the integration of real-time emotional data for dynamic analysis.

