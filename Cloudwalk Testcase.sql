PRAGMA table_info(users);

PRAGMA table_info(emotional_data);

PRAGMA table_info(loans);

SELECT * FROM users;

SELECT * FROM emotional_data;

SELECT * FROM loans;

SELECT COUNT(*) - COUNT(user_id) AS missing_user_ids FROM users;

SELECT COUNT(*) - COUNT(user_id) AS missing_user_ids FROM emotional_data;

SELECT COUNT(*) - COUNT(user_id) AS missing_user_ids FROM loans;

SELECT * FROM emotional_data WHERE user_id = '551' AND intensity = '5.0';

SELECT * FROM loans WHERE loan_id = '734';

SELECT ed.user_id, ed.primary_emotion, ed.intensity, ed.time_of_day, ed.relationship FROM emotional_data ed JOIN loans l ON ed.user_id = l.user_id;

SELECT status, COUNT(*) AS total_loans, SUM(loan_amount) AS total_loan_amount, SUM(total_amount) AS total_amount_collected FROM loans GROUP BY status;

SELECT user_id, primary_emotion, time_of_day, COUNT(*) AS occurrence FROM emotional_data GROUP BY user_id, primary_emotion, time_of_day ORDER BY user_id, occurrence DESC;

SELECT ed.primary_emotion, ed.intensity, l.loan_amount FROM emotional_data ed JOIN loans l ON ed.user_id = l.user_id WHERE l.loan_amount > 5000 ORDER BY l.loan_amount DESC;

SELECT loan_id, user_id, loan_amount, total_amount, issue_date, due_date, status, paid_date FROM loans WHERE status = 'paid';

SELECT * FROM loans WHERE loan_amount_paid > total_amount;


-- For the 'users' table:
SELECT 
    COUNT(*) - COUNT(score) AS missing_score,
    COUNT(*) - COUNT(credit_limit) AS missing_credit_limit,
    COUNT(*) - COUNT(interest_rate) AS missing_interest_rate,
    COUNT(*) - COUNT(loan_term) AS missing_loan_term,
    COUNT(*) - COUNT(approved_date) AS missing_approved_date,
    COUNT(*) - COUNT(denied_date) AS missing_denied_date
FROM users;

-- For the 'loans' table:
SELECT 
    COUNT(*) - COUNT(loan_amount) AS missing_loan_amount,
    COUNT(*) - COUNT(total_amount) AS missing_total_amount,
    COUNT(*) - COUNT(installment_amount) AS missing_installment_amount,
    COUNT(*) - COUNT(loan_amount_paid) AS missing_loan_amount_paid,
    COUNT(*) - COUNT(issue_date) AS missing_issue_date,
    COUNT(*) - COUNT(due_date) AS missing_due_date,
    COUNT(*) - COUNT(paid_date) AS missing_paid_date,
    COUNT(*) - COUNT(status) AS missing_status
FROM loans;

-- For the 'emotional_data' table:
SELECT 
    COUNT(*) - COUNT(intensity) AS missing_intensity,
    COUNT(*) - COUNT(grade) AS missing_grade,
    COUNT(*) - COUNT(timestamp) AS missing_timestamp,
    COUNT(*) - COUNT(time_of_day) AS missing_time_of_day,
    COUNT(*) - COUNT(primary_emotion) AS missing_primary_emotion,
    COUNT(*) - COUNT(relationship) AS missing_relationship,
    COUNT(*) - COUNT(situation) AS missing_situation,
    COUNT(*) - COUNT(location) AS missing_location,
    COUNT(*) - COUNT(weather) AS missing_weather,
    COUNT(*) - COUNT(physical_state) AS missing_physical_state,
    COUNT(*) - COUNT(preceding_event) AS missing_preceding_event
FROM emotional_data;








-- Replace NULL values in numerical columns with their respective mean
UPDATE users
SET score = (SELECT AVG(score) FROM users WHERE score IS NOT NULL)
WHERE score IS NULL;

UPDATE users
SET credit_limit = (SELECT AVG(credit_limit) FROM users WHERE credit_limit IS NOT NULL)
WHERE credit_limit IS NULL;

UPDATE users
SET interest_rate = (SELECT AVG(interest_rate) FROM users WHERE interest_rate IS NOT NULL)
WHERE interest_rate IS NULL;

UPDATE users
SET loan_term = (SELECT AVG(loan_term) FROM users WHERE loan_term IS NOT NULL)
WHERE loan_term IS NULL;

-- Replace NULL values in categorical columns with the most frequent value
UPDATE users
SET approved_date = (SELECT approved_date FROM users WHERE approved_date IS NOT NULL GROUP BY approved_date ORDER BY COUNT(*) DESC LIMIT 1)
WHERE approved_date IS NULL;

UPDATE users
SET denied_date = (SELECT denied_date FROM users WHERE denied_date IS NOT NULL GROUP BY denied_date ORDER BY COUNT(*) DESC LIMIT 1)
WHERE denied_date IS NULL;




-- Replace NULL values in numerical columns with their respective mean
UPDATE emotional_data
SET intensity = (SELECT AVG(intensity) FROM emotional_data WHERE intensity IS NOT NULL)
WHERE intensity IS NULL;

UPDATE emotional_data
SET grade = (SELECT AVG(grade) FROM emotional_data WHERE grade IS NOT NULL)
WHERE grade IS NULL;

-- Replace NULL values in categorical columns with the most frequent value
UPDATE emotional_data
SET primary_emotion = (SELECT primary_emotion FROM emotional_data WHERE primary_emotion IS NOT NULL GROUP BY primary_emotion ORDER BY COUNT(*) DESC LIMIT 1)
WHERE primary_emotion IS NULL;

UPDATE emotional_data
SET time_of_day = (SELECT time_of_day FROM emotional_data WHERE time_of_day IS NOT NULL GROUP BY time_of_day ORDER BY COUNT(*) DESC LIMIT 1)
WHERE time_of_day IS NULL;

UPDATE emotional_data
SET relationship = (SELECT relationship FROM emotional_data WHERE relationship IS NOT NULL GROUP BY relationship ORDER BY COUNT(*) DESC LIMIT 1)
WHERE relationship IS NULL;

UPDATE emotional_data
SET situation = (SELECT situation FROM emotional_data WHERE situation IS NOT NULL GROUP BY situation ORDER BY COUNT(*) DESC LIMIT 1)
WHERE situation IS NULL;

UPDATE emotional_data
SET location = (SELECT location FROM emotional_data WHERE location IS NOT NULL GROUP BY location ORDER BY COUNT(*) DESC LIMIT 1)
WHERE location IS NULL;

UPDATE emotional_data
SET weather = (SELECT weather FROM emotional_data WHERE weather IS NOT NULL GROUP BY weather ORDER BY COUNT(*) DESC LIMIT 1)
WHERE weather IS NULL;

UPDATE emotional_data
SET physical_state = (SELECT physical_state FROM emotional_data WHERE physical_state IS NOT NULL GROUP BY physical_state ORDER BY COUNT(*) DESC LIMIT 1)
WHERE physical_state IS NULL;

UPDATE emotional_data
SET preceding_event = (SELECT preceding_event FROM emotional_data WHERE preceding_event IS NOT NULL GROUP BY preceding_event ORDER BY COUNT(*) DESC LIMIT 1)
WHERE preceding_event IS NULL;




-- Replace NULL values in numerical columns with their respective mean
UPDATE loans
SET loan_amount = (SELECT AVG(loan_amount) FROM loans WHERE loan_amount IS NOT NULL)
WHERE loan_amount IS NULL;

UPDATE loans
SET total_amount = (SELECT AVG(total_amount) FROM loans WHERE total_amount IS NOT NULL)
WHERE total_amount IS NULL;

UPDATE loans
SET installment_amount = (SELECT AVG(installment_amount) FROM loans WHERE installment_amount IS NOT NULL)
WHERE installment_amount IS NULL;

UPDATE loans
SET loan_amount_paid = (SELECT AVG(loan_amount_paid) FROM loans WHERE loan_amount_paid IS NOT NULL)
WHERE loan_amount_paid IS NULL;

-- Replace NULL values in categorical columns with the most frequent value
UPDATE loans
SET status = (SELECT status FROM loans WHERE status IS NOT NULL GROUP BY status ORDER BY COUNT(*) DESC LIMIT 1)
WHERE status IS NULL;

UPDATE loans
SET issue_date = (SELECT issue_date FROM loans WHERE issue_date IS NOT NULL GROUP BY issue_date ORDER BY COUNT(*) DESC LIMIT 1)
WHERE issue_date IS NULL;

UPDATE loans
SET due_date = (SELECT due_date FROM loans WHERE due_date IS NOT NULL GROUP BY due_date ORDER BY COUNT(*) DESC LIMIT 1)
WHERE due_date IS NULL;

UPDATE loans
SET paid_date = (SELECT paid_date FROM loans WHERE paid_date IS NOT NULL GROUP BY paid_date ORDER BY COUNT(*) DESC LIMIT 1)
WHERE paid_date IS NULL;





-- Emotional Pattern Analysis:

-- Identify the most common emotions over time
SELECT strftime('%Y-%m', timestamp) AS month, primary_emotion, COUNT(*) AS emotion_count
FROM emotional_data
GROUP BY month, primary_emotion
ORDER BY month ASC, emotion_count DESC;

-- Correlate emotions with different contexts like relationship, situation, time_of_day
SELECT 
    primary_emotion,
    relationship,
    situation,
    time_of_day,
	location,
	weather,
    COUNT(*) AS emotion_count
FROM emotional_data
GROUP BY primary_emotion, relationship, situation, time_of_day
ORDER BY emotion_count DESC;





-- Loan-Emotion Correlation:

-- Analyze correlation between emotions and loan amounts
SELECT 
    ed.primary_emotion,
    AVG(l.loan_amount) AS avg_loan_amount,
    AVG(u.interest_rate) AS avg_interest_rate
FROM emotional_data ed
JOIN loans l ON ed.user_id = l.user_id
JOIN users u ON ed.user_id = u.user_id
GROUP BY ed.primary_emotion
ORDER BY avg_loan_amount DESC;


-- Identify which emotional factors influence loan results
SELECT 
    ed.primary_emotion, 
    l.status, 
    COUNT(*) AS loan_count 
FROM emotional_data ed
JOIN loans l ON ed.user_id = l.user_id
GROUP BY ed.primary_emotion, l.status
ORDER BY loan_count DESC;




-- Lending Operation Assessment:

-- Evaluate loan defaults based on interest rates and loan amounts
SELECT 
    l.loan_amount, 
    u.interest_rate, 
    COUNT(*) AS loan_count, 
    SUM(CASE WHEN l.status = 'default' THEN 1 ELSE 0 END) AS default_count
FROM loans l
JOIN users u ON l.user_id = u.user_id
GROUP BY l.loan_amount, u.interest_rate
ORDER BY default_count DESC;


-- Analyze disbursement trends over time
SELECT 
    strftime('%Y-%m', issue_date) AS month, 
    SUM(loan_amount) AS total_disbursed_amount
FROM loans
GROUP BY month
ORDER BY month ASC;

-- Calculate revenue trends (loan_amount_paid vs total_amount)
SELECT 
    strftime('%Y-%m', paid_date) AS month, 
    SUM(loan_amount_paid) AS total_revenue,
    SUM(total_amount) AS expected_total_amount,
    SUM(loan_amount_paid - total_amount) AS revenue_difference
FROM loans
GROUP BY month
ORDER BY month ASC;
