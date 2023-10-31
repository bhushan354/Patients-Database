-- make changes 
-- add gitflow
-- add README

-- create patients table :

CREATE TABLE patients (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

-- create medical_histories table and add foreign key

CREATE TABLE medical_histories (
    id INT PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    CONSTRAINT fk_medical_histories FOREIGN KEY (patient_id) REFERENCES patients(id)
);
