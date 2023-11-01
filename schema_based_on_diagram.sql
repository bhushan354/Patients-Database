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

CREATE INDEX index_medical_histories_on_patient_id ON medical_histories (patient_id);

CREATE TABLE invoices (
    id INT PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT fk_invoices_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE INDEX index_invoices_on_medical_history_id ON invoices (medical_history_id);

-- create the "treatments" table with the "id" column as a foreign key referencing the "id" column in the "medical_histories" table :

CREATE TABLE treatments (
    id INT PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

-- invoice_items table with all columns and foreign key referneced :
CREATE TABLE invoice_items (
    id INT PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT fk_invoices_id FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    CONSTRAINT fk_treatments_id FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);

CREATE INDEX index_invoice_items_invoice_id ON invoice_items (invoice_id);

CREATE INDEX index_invoice_items_treatment_id ON invoice_items (treatment_id);

ALTER TABLE treatments
ADD COLUMN medical_history_id INTEGER;

ALTER TABLE treatments ADD CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);


CREATE TABLE medical_histories_has_treatments (
    medical_history_id INT,
    treatment_id INT,
    PRIMARY KEY (treatment_id, medical_history_id),
    CONSTRAINT fk_mhht_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_mhht_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);


ALTER TABLE treatments
DROP COLUMN medical_history_id;

CREATE INDEX index_medical_histories_has_treatments_medical_history_id ON medical_histories_has_treatments (medical_history_id);

CREATE INDEX idx_medical_histories_has_treatments_treatment_id ON medical_histories_has_treatments (treatment_id);