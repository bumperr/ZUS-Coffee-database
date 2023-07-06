---Example to execute --> '@C:\Users\LENOVO\Documents\AssignmentDlm\ZUS_create.sql'
--just example path to execute script
--drop table code  @C:\Users\LENOVO\Documents\AssignmentDIm\ZUS_create.sql
@@ZUS_drop.sql

--create table  code

CREATE TABLE Person (
    Per_email VARCHAR(255) NOT NULL PRIMARY KEY ,
    Per_firstname VARCHAR(50),
    Per_middleName VARCHAR(50),
    Per_lastname VARCHAR(50),
    Per_phoneNum VARCHAR(20),
    Per_gender CHAR(1),
    Per_Salutation VARCHAR(20),
    Per_DOB DATE,
    Per_age INT CHECK (Per_age > 0),
    Per_password VARCHAR(255)
);

CREATE TABLE Address (
    A_ID INT NOT NULL PRIMARY KEY,
    A_street VARCHAR(100),
    A_unit VARCHAR(50),
    A_city VARCHAR(50),
    A_state VARCHAR(50),
    A_postcode VARCHAR(20),
    A_country VARCHAR(50),
    A_type VARCHAR(50),
    A_longitude DECIMAL(9,6),
    A_latitude DECIMAL(9,6)
);

CREATE TABLE Branch (
    B_ID INT NOT NULL PRIMARY KEY,
    B_name VARCHAR(100) NOT NULL,
    B_phoneNum VARCHAR(20),
    B_email VARCHAR(255),
    B_openHour TIMESTAMP,
    B_closeHour TIMESTAMP,
    B_openingDate DATE,
    B_staffcount INT,
    B_listOfFacility VARCHAR(255),
    B_totalRevenue DECIMAL(10, 2)
);

CREATE TABLE Applicant (
    Applicant_ID INT PRIMARY KEY,
    Per_email VARCHAR(255) NOT NULL,
    Applicant_maritalStatus VARCHAR(20),
    Applicant_ic VARCHAR(20),
    Applicant_race VARCHAR(50),
    Applicant_qualifications VARCHAR(100),
    Applicant_nationality VARCHAR(50),
    Applicant_religion VARCHAR(50),
    Applicant_ECName VARCHAR(100),
    Applicant_ECNo VARCHAR(20),
    Applicant_ECRelationship VARCHAR(50),
    CONSTRAINT fk_Applicant_Person FOREIGN KEY (Per_email) REFERENCES Person(Per_email)
);

CREATE TABLE Inventory (
    I_ID INT PRIMARY KEY,
    I_storageLocation VARCHAR(100),
    I_Category VARCHAR(50),
    I_Quantity INT,
    I_ReorderPoint INT,
    I_RestockDate DATE,
    I_MaxStockLevel INT,
    I_MinStockLevel INT,
    I_lastUpdate DATE,
    I_Section VARCHAR(50),
    B_ID INT,
    CONSTRAINT fk_I_Branch FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

CREATE TABLE Customer (
    Cust_ID INT PRIMARY KEY,
    Per_email VARCHAR(255) NOT NULL,
    Cust_preferedPaymentMethod VARCHAR(50),
    Cust_redeemableCode VARCHAR(50),
    Cust_inviteCode VARCHAR(50),
    Cust_usageTime INTERVAL DAY(2) TO SECOND(2),
    Cust_rewards VARCHAR2(20),
    Cust_loyalty VARCHAR2(20),
    Cust_totalPurchase DECIMAL(10, 2),
    Cust_points INT,
    Cust_username VARCHAR(50),
    Cust_membershipStatus VARCHAR(50),
    Applicant_ID INT,
    CONSTRAINT fk_Cust_Person FOREIGN KEY (Per_email) REFERENCES Person(Per_email),
    CONSTRAINT fk_CUst_Applicant FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

CREATE TABLE Department (
    Dpt_ID INT NOT NULL PRIMARY KEY,
    Dpt_name VARCHAR2(100),
    Dpt_staffcount NUMBER,
    Dpt_email VARCHAR2(100),
    Dpt_description VARCHAR2(200),
    Dpt_budget NUMBER,
    Dpt_faxno VARCHAR2(20),
    Dpt_performance VARCHAR2(100),
    Dpt_phoneNum VARCHAR2(20),
    Dpt_location VARCHAR2(100)
);

CREATE TABLE Employee (
  E_ID INT NOT NULL PRIMARY KEY,
  Per_email VARCHAR(255),
  E_position VARCHAR2(100),
  E_salary NUMBER,
  E_employmentStatus VARCHAR2(50),
  E_qualification VARCHAR2(100),
  E_hireDate DATE,
  E_race VARCHAR2(50),
  E_maritalStatus VARCHAR2(50),
  E_nationality VARCHAR2(100),
  E_religion VARCHAR2(100),
  E_performanceEvaluation VARCHAR2(50),
  E_ic VARCHAR2(50),
  Applicant_ID INT,
  I_ID INT,
  Dpt_ID INT,
  B_ID INT,
  CONSTRAINT fk_E_Person FOREIGN KEY (Per_email) REFERENCES Person (Per_email),
  CONSTRAINT fk_E_Applicant FOREIGN KEY (Applicant_ID) REFERENCES Applicant (Applicant_ID),
  CONSTRAINT fk_E_Inventory FOREIGN KEY (I_ID) REFERENCES Inventory (I_ID),
  CONSTRAINT fk_E_Department FOREIGN KEY (Dpt_ID) REFERENCES Department (Dpt_ID),
  CONSTRAINT fk_E_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID)
);

CREATE TABLE Application (
  Application_ID INT PRIMARY KEY,
  Application_OutletApplied VARCHAR2(100),
  Application_PositionApplied VARCHAR2(100),
  Application_DepartmentApplied VARCHAR2(100),
  Application_Date DATE,
  Application_ResumeLink VARCHAR2(255),
  Application_Availability CHAR(1),
  Application_WorkExperience VARCHAR2(255),
  Application_SourceInfo VARCHAR2(100),
  Application_Points NUMBER,
  Application_Decisions VARCHAR2(50),
  B_ID INT,
  E_ID INT,
  CONSTRAINT fk_Application_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Application_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID)
);

CREATE TABLE Attendance (
  Att_ID INT NOT NULL PRIMARY KEY,
  Att_date DATE,
  Att_method VARCHAR2(50),
  Att_status VARCHAR2(50),
  Att_remark VARCHAR2(255),
  Att_timeIn TIMESTAMP,
  Att_timeOut TIMESTAMP,
  Att_to_be_attend INT,
  Att_totalAttendance INT,
  Att_percentage NUMBER,
  E_ID INT,
  CONSTRAINT fk_Att_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID)
);

CREATE TABLE Leave (
  Le_ID INT NOT NULL PRIMARY KEY,
  Le_type VARCHAR2(50),
  Le_date_request DATE,
  Le_reason VARCHAR2(255),
  Le_start_date DATE,
  Le_end_date DATE,
  Le_duration NUMBER,
  Le_balance NUMBER,
  Le_remark VARCHAR2(255),
  Le_ApprovalStatus VARCHAR2(50),
  Le_dateApproval DATE,
  E_ID INT,
  Att_ID INT,
  CONSTRAINT fk_Le_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Le_Attendance FOREIGN KEY (Att_ID) REFERENCES Attendance (Att_ID)
);

CREATE TABLE Training (
  Training_ID INT NOT NULL PRIMARY KEY,
  Training_name VARCHAR2(100),
  Training_description VARCHAR2(255),
  Training_preRequisite VARCHAR2(255),
  Training_duration NUMBER,
  Training_module VARCHAR2(255),
  Training_platform VARCHAR2(100),
  Training_evalmetrics VARCHAR2(255),
  Training_material VARCHAR2(255),
  Training_objective VARCHAR2(255)
);

CREATE TABLE Supplier (
  S_ID INT NOT NULL PRIMARY KEY,
  S_companyName VARCHAR2(100),
  S_contract_StartDate DATE,
  S_dealername VARCHAR2(100),
  S_contactNo VARCHAR2(50),
  S_contract_endDate DATE,
  S_email VARCHAR2(255),
  S_supplyType VARCHAR2(100),
  S_ssmNumber VARCHAR2(50),
  S_website VARCHAR2(255)
);

CREATE TABLE Procurement (
  Proc_ID INT NOT NULL PRIMARY KEY,
  Proc_quantity INT,
  Proc_batch INT,
  Proc_date DATE,
  Proc_item VARCHAR2(100),
  Proc_budget NUMBER,
  Proc_method VARCHAR2(50),
  Proc_approvalstatus VARCHAR2(50),
  Proc_remarks VARCHAR2(255),
  Proc_totalCost NUMBER,
  E_ID INT,
  B_ID INT,
  CONSTRAINT fk_Proc_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Proc_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID)
);

CREATE TABLE Vehicle (
  Vec_ID INT NOT NULL PRIMARY KEY,
  Vec_type VARCHAR2(50),
  Vec_plateNum VARCHAR2(20),
  Vec_purchasedate DATE,
  Vec_price NUMBER,
  Vec_year INT,
  Vec_roadTaxNum VARCHAR2(50),
  Vec_mileage NUMBER,
  Vec_model VARCHAR2(100),
  Vec_brand VARCHAR2(100),
  Vec_insuranceNum VARCHAR2(50),
  B_ID INT,
  Proc_ID INT,
  S_ID INT,
  CONSTRAINT fk_Vec_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Vec_Procurement FOREIGN KEY (Proc_ID) REFERENCES Procurement (Proc_ID),
  CONSTRAINT fk_Vec_Supplier FOREIGN KEY (S_ID) REFERENCES Supplier (S_ID)
);

CREATE TABLE Shipment (
  Ship_ID INT NOT NULL PRIMARY KEY,
  Ship_sendDate DATE,
  Ship_receiveDate DATE,
  Ship_type VARCHAR2(50),
  Ship_trackingNumber VARCHAR2(100),
  Ship_status VARCHAR2(50),
  Ship_contentDesc VARCHAR2(255),
  Ship_courier VARCHAR2(100),
  Ship_source VARCHAR2(100),
  Ship_destination VARCHAR2(100),
  Ship_customsInfo VARCHAR2(255),
  Ship_cost NUMBER,
  Ship_estimateDate DATE,
  Ship_dimensions VARCHAR2(100),
  Ship_weight NUMBER,
  A_ID INT,
  E_ID INT,
  Vec_ID INT,
  B_ID INT,
  S_ID INT,
  CONSTRAINT fk_Ship_Address FOREIGN KEY (A_ID) REFERENCES Address (A_ID),
  CONSTRAINT fk_Ship_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Ship_Vehicle FOREIGN KEY (Vec_ID) REFERENCES Vehicle (Vec_ID),
  CONSTRAINT fk_Ship_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Ship_Supplier FOREIGN KEY (S_ID) REFERENCES Supplier (S_ID)
);

CREATE TABLE Item (
  Itm_ID INT NOT NULL PRIMARY KEY,
  Itm_cost NUMBER,
  Itm_expiryDate DATE,
  Itm_name VARCHAR2(100),
  Vec_ID INT,
  Ship_ID INT,
  Proc_ID INT,
  I_ID INT,
  CONSTRAINT fk_Itm_Vehicle FOREIGN KEY (Vec_ID) REFERENCES Vehicle (Vec_ID),
  CONSTRAINT fk_Itm_Shipment FOREIGN KEY (Ship_ID) REFERENCES Shipment (Ship_ID),
  CONSTRAINT fk_Itm_Procurement FOREIGN KEY (Proc_ID) REFERENCES Procurement (Proc_ID),
  CONSTRAINT fk_Itm_Inventory FOREIGN KEY (I_ID) REFERENCES Inventory (I_ID)
);

CREATE TABLE Recipe (
  R_ID INT NOT NULL PRIMARY KEY,
  R_name VARCHAR2(100),
  R_ingredients VARCHAR2(255),
  R_instruction VARCHAR2(1000),
  R_PrepTime NUMBER,
  R_CookTime NUMBER,
  R_ServingSize VARCHAR2(50),
  R_tools VARCHAR2(255),
  R_remarks VARCHAR2(255),
  R_dateCreated DATE
);
CREATE TABLE Product (
  P_ID INT NOT NULL PRIMARY KEY,
  Itm_ID INT,
  P_rating NUMBER,
  P_category VARCHAR2(100),
  P_weight VARCHAR2(20),
  P_retailPrice NUMBER,
  P_nutritionInfo VARCHAR2(255),
  P_availability CHAR(1),
  P_description VARCHAR2(255),
  P_allergenInfo VARCHAR2(255),
  P_shelfLife VARCHAR2(100),
  R_ID INT,
  CONSTRAINT fk_P_Item FOREIGN KEY (Itm_ID) REFERENCES Item (Itm_ID),
  CONSTRAINT fk_P_Recipe FOREIGN KEY (R_ID) REFERENCES Recipe (R_ID)
);

CREATE TABLE RawMaterial (
  Rm_ID INT NOT NULL PRIMARY KEY,
  Itm_ID INT,
  Rm_qualitygrades VARCHAR2(100),
  Rm_type VARCHAR2(100),
  Rm_measurementUnit VARCHAR2(50),
  Rm_amount NUMBER,
  Rm_description VARCHAR2(255),
  Rm_storageRequirement VARCHAR2(100),
  Rm_minimumQuantity INT,
  Rm_maximumQuantity INT,
  Rm_brand VARCHAR2(100),
  S_ID INT,
  CONSTRAINT fk_Rm_Item FOREIGN KEY (Itm_ID) REFERENCES Item (Itm_ID),
  CONSTRAINT fk_Rm_Supllier FOREIGN KEY (S_ID) REFERENCES Supplier(S_ID)
);

CREATE TABLE MarketingProgram (
  Mrkt_ID INT NOT NULL PRIMARY KEY,
  Mrkt_campaignName VARCHAR2(100),
  Mrkt_startDate DATE,
  Mrkt_endDate DATE,
  Mrkt_description VARCHAR2(255),
  Mrkt_channel VARCHAR2(100),
  Mrkt_budget NUMBER,
  Mrkt_metrics VARCHAR2(255),
  Mrkt_targetAudience VARCHAR2(100),
  Mrkt_result VARCHAR2(255),
  Mrkt_objective VARCHAR2(255),
  Dpt_ID INT,
  CONSTRAINT fk_Mrkt_Department FOREIGN KEY (Dpt_ID) REFERENCES Department (Dpt_ID)
);

CREATE TABLE Promotion (
  Promo_ID INT NOT NULL PRIMARY KEY,
  promo_name VARCHAR2(100),
  promo_description VARCHAR2(255),
  promo_type VARCHAR2(50),
  promo_requirement VARCHAR2(255),
  promo_code VARCHAR2(50),
  promo_percentageRate NUMBER,
  promo_TandC VARCHAR2(255),
  promo_startDate DATE,
  promo_endDate DATE,
  promo_status VARCHAR2(100),
  promo_redemptionLimit INT,
  Cust_ID INT,
  Dpt_ID INT,
  Mrkt_ID INT,
  CONSTRAINT fk_Promo_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Promo_Department FOREIGN KEY (Dpt_ID) REFERENCES Department (Dpt_ID),
  CONSTRAINT fk_Promo_MarketingProgram FOREIGN KEY (Mrkt_ID) REFERENCES MarketingProgram (Mrkt_ID)
);
CREATE TABLE "Transaction" (
  Trans_refnum INT NOT NULL PRIMARY KEY,
  Trans_date_time TIMESTAMP,
  Trans_type VARCHAR2(50),
  Trans_currency VARCHAR2(50),
  Trans_Account VARCHAR2(100),
  Trans_source VARCHAR2(100),
  Trans_method VARCHAR2(100),
  Trans_statement VARCHAR2(255),
  Trans_taxAmount NUMBER,
  Trans_amount NUMBER,
  Cust_ID INT,
  E_ID INT,
  Sale_ID INT,
  Promo_ID INT,
  Proc_ID INT,
  S_ID INT,
  CONSTRAINT fk_Trans_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Trans_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Trans_Promotion FOREIGN KEY (Promo_ID) REFERENCES Promotion (Promo_ID),
  CONSTRAINT fk_Trans_Procurement FOREIGN KEY (Proc_ID) REFERENCES Procurement (Proc_ID),
  CONSTRAINT fk_Trans_Supplier FOREIGN KEY (S_ID) REFERENCES Supplier (S_ID)
);

CREATE TABLE Sale (
  Sale_ID INT NOT NULL PRIMARY KEY,
  Sale_date DATE,
  Sale_unit VARCHAR2(50),
  Sale_time TIMESTAMP,
  Sale_target VARCHAR2(100),
  Sale_taxes NUMBER(3,2),
  Sale_history VARCHAR2(255),
  Sale_totalAmount NUMBER,
  Sale_status VARCHAR2(50),
  Sale_quantity INT,
  B_ID INT,
  Promo_ID INT,
  CONSTRAINT fk_Sale_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Sale_Promotion FOREIGN KEY (Promo_ID) REFERENCES Promotion (Promo_ID)
);

CREATE TABLE Delivery (
  Dlvr_ID INT PRIMARY KEY,
  Dlvr_date DATE,
  Dlvr_time TIMESTAMP,
  Dlvr_method VARCHAR2(50),
  Dlvr_eta TIMESTAMP,
  Dlvr_notes VARCHAR2(255),
  Dlvr_packagingdetails VARCHAR2(255),
  Dlvr_dimensions VARCHAR2(100),
  Dlvr_details VARCHAR2(255),
  Dlvr_contact VARCHAR2(100),
  A_ID INT,
  Cust_ID INT,
  Vec_ID INT,
  B_ID INT,
  Sale_ID INT,
  CONSTRAINT fk_Dlvr_Address FOREIGN KEY (A_ID) REFERENCES Address (A_ID),
  CONSTRAINT fk_Dlvr_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Dlvr_Vehicle FOREIGN KEY (Vec_ID) REFERENCES Vehicle (Vec_ID),
  CONSTRAINT fk_Dlvr_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID)
);




CREATE TABLE "Feedback" (
  Fdbk_ID INT NOT NULL PRIMARY KEY,
  Fdbk_title VARCHAR2(100),
  Fdbk_date DATE,
  Fdbk_content VARCHAR2(255),
  Fdbk_rating NUMBER,
  Fdbk_status VARCHAR2(50),
  Fdbk_response VARCHAR2(255),
  Fdbk_type VARCHAR2(50),
  Fdbk_platform VARCHAR2(50),
  Fdbk_fileLink VARCHAR2(255),
  Cust_ID INT,
  E_ID INT,
  Dlvr_ID INT,
  B_ID INT,
  P_ID INT,
  Sale_ID INT,
  CONSTRAINT fk_Fdbk_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Fdbk_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Fdbk_Delivery FOREIGN KEY (Dlvr_ID) REFERENCES Delivery (Dlvr_ID),
  CONSTRAINT fk_Fdbk_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Fdbk_Product FOREIGN KEY (P_ID) REFERENCES Product (P_ID),
  CONSTRAINT fk_Fdbk_Sale FOREIGN KEY (Sale_ID) REFERENCES Sale (Sale_ID)
);

ALTER TABLE "Transaction"
ADD CONSTRAINT fk_Trans_Sale FOREIGN KEY (Sale_ID) REFERENCES Sale(Sale_ID);

ALTER TABLE Delivery
ADD CONSTRAINT fk_Dlvr_Sale FOREIGN KEY (Sale_ID) REFERENCES Sale(Sale_ID);

--Explosion table
CREATE TABLE Address_Person (
  Per_email VARCHAR(255) NOT NULL, 
  A_ID INT NOT NULL,
  PRIMARY KEY (Per_email, A_ID),
  FOREIGN KEY (Per_email) REFERENCES Person(Per_email),
  FOREIGN KEY (A_ID) REFERENCES Address(A_ID)
);

CREATE TABLE Customer_Product (
  Cust_ID INT NOT NULL,
  P_ID INT NOT NULL,
  PRIMARY KEY (Cust_ID, P_ID),
  FOREIGN KEY (Cust_ID) REFERENCES Customer(Cust_ID),
  FOREIGN KEY (P_ID) REFERENCES Product(P_ID)
);

CREATE TABLE Customer_Sale (
  Cust_ID INT NOT NULL,
  P_ID INT NOT NULL,
  PRIMARY KEY (Cust_ID, P_ID),
  FOREIGN KEY (Cust_ID) REFERENCES Customer(Cust_ID),
  FOREIGN KEY (P_ID) REFERENCES Product(P_ID)
);

CREATE TABLE Product_Sale (
  P_ID INT NOT NULL,
  Sale_ID INT NOT NULL,
  PRIMARY KEY (P_ID, Sale_ID),
  FOREIGN KEY (P_ID) REFERENCES Product(P_ID),
  FOREIGN KEY (Sale_ID) REFERENCES Sale(Sale_ID)
);

CREATE TABLE Employee_Supplier (
  E_ID INT NOT NULL,
  S_ID INT NOT NULL,
  PRIMARY KEY (E_ID, S_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (S_ID) REFERENCES Supplier(S_ID)
);

CREATE TABLE Employee_Vehicle (
  E_ID INT NOT NULL,
  Vec_ID INT NOT NULL,
  PRIMARY KEY (E_ID, Vec_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (Vec_ID) REFERENCES Vehicle(Vec_ID)
);

CREATE TABLE Employee_Item (
  E_ID INT NOT NULL,
  Itm_ID INT NOT NULL,
  PRIMARY KEY (E_ID, Itm_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (Itm_ID) REFERENCES Item(Itm_ID)
);

CREATE TABLE Employee_Product (
  E_ID INT NOT NULL,
  P_ID INT NOT NULL,
  PRIMARY KEY (E_ID, P_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (P_ID) REFERENCES Product(P_ID)
);

CREATE TABLE Employee_MarketingProgram (
  E_ID INT NOT NULL,
  Mrkt_ID INT NOT NULL,
  PRIMARY KEY (E_ID, Mrkt_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (Mrkt_ID) REFERENCES MarketingProgram(Mrkt_ID)
);

CREATE TABLE Employee_Recipe (
  E_ID INT NOT NULL,
  R_ID INT NOT NULL,
  PRIMARY KEY (E_ID, R_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (R_ID) REFERENCES Recipe(R_ID)
);

CREATE TABLE Employee_Training (
  E_ID INT NOT NULL,
  Training_ID INT NOT NULL,
  PRIMARY KEY (E_ID, Training_ID),
  FOREIGN KEY (E_ID) REFERENCES Employee(E_ID),
  FOREIGN KEY (Training_ID) REFERENCES Training(Training_ID)
);

CREATE TABLE Department_Branch (
  Dpt_ID INT NOT NULL,
  B_ID INT NOT NULL,
  PRIMARY KEY (Dpt_ID, B_ID),
  FOREIGN KEY (Dpt_ID) REFERENCES Department(Dpt_ID),
  FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

CREATE TABLE Promotion_Branch (
  Promo_ID INT NOT NULL,
  B_ID INT NOT NULL,
  PRIMARY KEY (Promo_ID, B_ID),
  FOREIGN KEY (Promo_ID) REFERENCES Promotion(Promo_ID),
  FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

CREATE TABLE MarketingProgram_Branch (
  Mrkt_ID INT NOT NULL,
  B_ID INT NOT NULL,
  PRIMARY KEY (Mrkt_ID, B_ID),
  FOREIGN KEY (Mrkt_ID) REFERENCES MarketingProgram(Mrkt_ID),
  FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

CREATE TABLE Promotion_Product (
  Promo_ID INT NOT NULL,
  P_ID INT NOT NULL,
  PRIMARY KEY (Promo_ID, P_ID),
  FOREIGN KEY (Promo_ID) REFERENCES Promotion(Promo_ID),
  FOREIGN KEY (P_ID) REFERENCES Product(P_ID)
);

CREATE TABLE Vehicle_Transaction (
  Vec_ID INT NOT NULL,
  Trans_refnum INT NOT NULL,
  PRIMARY KEY (Vec_ID, Trans_refnum),
  FOREIGN KEY (Vec_ID) REFERENCES Vehicle(Vec_ID),
  FOREIGN KEY (Trans_refnum) REFERENCES "Transaction"(Trans_refnum)
);

CREATE TABLE RawMaterial_Recipe (
  R_ID INT NOT NULL,
  RM_ID INT NOT NULL,
  PRIMARY KEY (R_ID, RM_ID),
  FOREIGN KEY (R_ID) REFERENCES Recipe(R_ID),
  FOREIGN KEY (RM_ID) REFERENCES RawMaterial(RM_ID)
);

CREATE TABLE Inventory_Supplier (
  I_ID INT NOT NULL,
  S_ID INT NOT NULL,
  PRIMARY KEY (I_ID, S_ID),
  FOREIGN KEY (I_ID) REFERENCES Inventory(I_ID),
  FOREIGN KEY (S_ID) REFERENCES Supplier(S_ID)
);

CREATE TABLE Inventory_Shipment (
  I_ID INT NOT NULL,
  Ship_ID INT NOT NULL,
  PRIMARY KEY (I_ID, Ship_ID),
  FOREIGN KEY (I_ID) REFERENCES Inventory(I_ID),
  FOREIGN KEY (Ship_ID) REFERENCES Shipment(Ship_ID)
);

CREATE TABLE Inventory_Vehicle (
  I_ID INT NOT NULL,
  Vec_ID INT NOT NULL,
  PRIMARY KEY (I_ID, Vec_ID),
  FOREIGN KEY (I_ID) REFERENCES Inventory(I_ID),
  FOREIGN KEY (Vec_ID) REFERENCES Vehicle(Vec_ID)
);

CREATE TABLE Delivery_Item (
  Dlvr_ID INT NOT NULL,
  Itm_ID INT NOT NULL,
  PRIMARY KEY (Dlvr_ID, Itm_ID),
  FOREIGN KEY (Dlvr_ID) REFERENCES Delivery(Dlvr_ID),
  FOREIGN KEY (Itm_ID) REFERENCES Item(Itm_ID)
);

CREATE TABLE Inventory_Sale (
  I_ID INT NOT NULL,
  Sale_ID INT NOT NULL,
  PRIMARY KEY (I_ID, Sale_ID),
  FOREIGN KEY (I_ID) REFERENCES Inventory(I_ID),
  FOREIGN KEY (Sale_ID) REFERENCES Sale(Sale_ID)
);

CREATE TABLE Item_Transaction (
  Itm_ID INT NOT NULL,
  Trans_refnum INT NOT NULL,
  PRIMARY KEY (Itm_ID, Trans_refnum),
  FOREIGN KEY (Itm_ID) REFERENCES Item(Itm_ID),
  FOREIGN KEY (Trans_refnum) REFERENCES "Transaction"(Trans_refnum)
);

CREATE TABLE Address_Branch (
  A_ID INT NOT NULL,
  B_ID INT NOT NULL,
  PRIMARY KEY (A_ID, B_ID),
  FOREIGN KEY (A_ID) REFERENCES Address(A_ID),
  FOREIGN KEY (B_ID) REFERENCES Branch(B_ID)
);

CREATE TABLE Address_Supplier (
  A_ID INT NOT NULL,
  S_ID INT NOT NULL,
  PRIMARY KEY (A_ID, S_ID),
  FOREIGN KEY (A_ID) REFERENCES Address(A_ID),
  FOREIGN KEY (S_ID) REFERENCES Supplier(S_ID)
);

CREATE TABLE Address_Inventory (
  A_ID INT NOT NULL,
  I_ID INT NOT NULL,
  PRIMARY KEY (A_ID, I_ID),
  FOREIGN KEY (A_ID) REFERENCES Address(A_ID),
  FOREIGN KEY (I_ID) REFERENCES Inventory(I_ID)
);

CREATE TABLE Applicant_Application (
  Applicant_ID INT NOT NULL,
  Application_ID INT NOT NULL,
  PRIMARY KEY (Applicant_ID, Application_ID),
  FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID),
  FOREIGN KEY (Application_ID) REFERENCES Application(Application_ID)
);

CREATE TABLE Delivery_Transaction (
  Dlvr_ID INT NOT NULL,
  Trans_refnum INT NOT NULL,
  PRIMARY KEY (Dlvr_ID, Trans_refnum),
  FOREIGN KEY (Dlvr_ID) REFERENCES Delivery(Dlvr_ID),
  FOREIGN KEY (Trans_refnum) REFERENCES "Transaction"(Trans_refnum)
);

CREATE TABLE MarketingProgram_Sale (
  Mrkt_ID INT NOT NULL,
  Sale_ID INT NOT NULL,
  PRIMARY KEY (Mrkt_ID, Sale_ID),
  FOREIGN KEY (Mrkt_ID) REFERENCES MarketingProgram(Mrkt_ID),
  FOREIGN KEY (Sale_ID) REFERENCES Sale(Sale_ID)
);

CREATE TABLE Transaction_Shipment (
  Trans_refnum INT NOT NULL,
  Ship_ID INT NOT NULL,
  PRIMARY KEY (Trans_refnum, Ship_ID),
  FOREIGN KEY (Trans_refnum) REFERENCES "Transaction"(Trans_refnum),
  FOREIGN KEY (Ship_ID) REFERENCES Shipment(Ship_ID)
);

CREATE TABLE Procurement_Supplier (
  Proc_ID INT NOT NULL,
  S_ID INT NOT NULL,
  PRIMARY KEY (Proc_ID, S_ID),
  FOREIGN KEY (Proc_ID) REFERENCES Procurement(Proc_ID),
  FOREIGN KEY (S_ID) REFERENCES Supplier(S_ID)
);



--insert data code 

INSERT ALL
    INTO Person VALUES ('amirdanial01@gmail.com', 'Muhammad', 'Amir', 'Danial', '010-5941368', 'M', 'Mr.', TO_DATE('1/4/2001', 'dd/mm/yyyy'), 22, 'amir14')
    INTO Person VALUES ('ifabatrisya30@gmail.com', 'Atifah', 'Safiya', 'Zakaria', '016-2694018', 'F', 'Miss', TO_DATE('30/1/2002', 'dd/mm/yyyy'), 21, 'Batrisyia')
    INTO Person VALUES ('wanemir69@gmail.com', 'Muhammad', 'Wan', 'Emir', '017-6984325', 'M', 'Mr.', TO_DATE('6/9/1991', 'dd/mm/yyyy'), 31, 'emir&')
    INTO Person VALUES ('harris89@gmail.com', 'Muhammed', 'Amzar', 'Harris', '018-4165987', 'M', 'Mr.', TO_DATE('8/9/1997', 'dd/mm/yyyy'), 25, 'Harris89')
    INTO Person VALUES ('fasya51@gmail.com', 'Hasya', 'Nur', 'Seman', '019-5897582', 'F', 'Miss', TO_DATE('5/1/2002', 'dd/mm/yyyy'), 21, 'fAsya5')
    INTO Person VALUES ('aminah08@gmail.com', 'Nur', 'Syahirah', 'Amirah', '010-8756286', 'F', 'Miss', TO_DATE('8/12/1990', 'dd/mm/yyyy'), 32, '812amirah')
    INTO Person VALUES ('mimiroslan63@gmail.com', 'Mimi', 'Wan', 'Tania', '012-5825641', 'F', 'Miss', TO_DATE('6/3/2000', 'dd/mm/yyyy'), 23, 'Tania123')
    INTO Person VALUES ('azlinanur12@gmail.com', 'Nur', 'Azlina', 'Rohaizam', '018-2165439', 'F', 'Mrs.', TO_DATE('1/2/1965', 'dd/mm/yyyy'), 58, 'azlina')
    INTO Person VALUES ('nayli47@gmail.com', 'Nurul', 'Nayli', 'Azhar', '012-1235568', 'F', 'Mrs.', TO_DATE('4/7/1952', 'dd/mm/yyyy'), 71, 'Nayli123')
    INTO Person VALUES ('zulamzar43@gmail.com', 'Mohd', 'Zulamzar', 'Rostam', '016-4789851', 'M', 'Mr.', TO_DATE('4/3/1987', 'dd/mm/yyyy'), 36, 'Zul%04')
    INTO Person VALUES ('aminasraff3@gmail.com', 'Muhammad', 'Amin', 'Asraff', '010-3156915', 'M', 'Mr.', TO_DATE('3/1/2002', 'dd/mm/yyyy'), 21, 'amin31')
    INTO Person VALUES ('mysara11@gmail.com', 'Ellya', 'Mysara', 'Sobri', '010-2190196', 'F', 'Miss', TO_DATE('11/2/1990', 'dd/mm/yyyy'), 33, '*Mysara123')
    INTO Person VALUES ('jarinah12@gmail.com', 'Jarinah', 'Johar', 'Bakar', '016-5023086', 'F', 'Mrs.', TO_DATE('12/12/1963', 'dd/mm/yyyy'), 59, 'johar12')
    INTO Person VALUES ('syafiq31@gmail.com', 'Muhammad', 'Syafiq', 'Suhail', '013-4934856', 'M', 'Mr.', TO_DATE('31/12/1989', 'dd/mm/yyyy'), 33, 'syafiq123')
    INTO Person VALUES ('adamfeb28@gmail.com', 'Adam', 'Nur', 'Febian', '019-5617895', 'M', 'Mr.', TO_DATE('28/11/1995', 'dd/mm/yyyy'), 27, 'Adam&%')
    INTO Person VALUES ('ammar19@gmail.com', 'Mohd', 'Ammar', 'Haziq', '018-4684687', 'M', 'Mr.', TO_DATE('19/6/2000', 'dd/mm/yyyy'), 23, 'Haziq2000')
    INTO Person VALUES ('jamal72@gmail.com', 'Jamalludin', 'Hassan', 'Abu', '016-4973588', 'M', 'Mr.', TO_DATE('7/2/1982', 'dd/mm/yyyy'), 41, 'jamal?')
    INTO Person VALUES ('muaz66@gmail.com', 'Muhammad', 'Muazzam', 'Shah', '010-8321015', 'M', 'Mr.', TO_DATE('6/6/2003', 'dd/mm/yyyy'), 20, 'muaz66')
    INTO Person VALUES ('chua45@gmail.com', 'Chua', 'Chai', 'Mei', '018-4203508', 'F', 'Mrs.', TO_DATE('4/5/1973', 'dd/mm/yyyy'), 50, 'meimei')
    INTO Person VALUES ('dania29@gmail.com', 'Nur', 'Dania', 'Zalia', '010-5023648', 'F', 'Mrs.', TO_DATE('29/10/1994', 'dd/mm/yyyy'), 28, 'zalia29')
    INTO Person VALUES ('emsyar10@gmail.com', 'Muhammad', 'Emsyar', 'Fakhrul', '017-9064586', 'M', 'Mr.', TO_DATE('10/6/1994', 'dd/mm/yyyy'), 29, 'Emsyar10')
    INTO Person VALUES ('farisya99@gmail.com', 'Nur', 'Intan', 'Suhaimi', '014-4056878', 'M', 'Mr.', TO_DATE('9/9/2001', 'dd/mm/yyyy'), 21, 'Farisya9')
    INTO Person VALUES ('ghopal17@gmail.com', 'Muthu', 'Ghopal', 'Singh', '012-4600324', 'M', 'Mr.', TO_DATE('17/5/1990', 'dd/mm/yyyy'), 33, 'Ghopal175')
    INTO Person VALUES ('hua22@gmail.com', 'Hua', 'Soo', 'Kim', '019-5020658', 'F', 'Miss', TO_DATE('22/7/2002', 'dd/mm/yyyy'), 20, 'kiM2002%')
    INTO Person VALUES ('intan53@gmail.com', 'Nurul', 'Intan', 'Qasrina', '012-3057905', 'F', 'Mrs.', TO_DATE('5/3/1994', 'dd/mm/yyyy'), 29, 'Qas53')
    INTO Person VALUES ('kuan91@gmail.com', 'Kuan', 'Teo', 'Lim', '010-2031104', 'M', 'Mr.', TO_DATE('9/11/2004', 'dd/mm/yyyy'), 18, 'Lim123')
    INTO Person VALUES ('jamilah6@gmail.com', 'Nurul', 'Jamilah', 'Abdullah', '016-5230510', 'F', 'Mrs.', TO_DATE('6/12/1991', 'dd/mm/yyyy'), 31, 'jamilah69')
    INTO Person VALUES ('lee48@gmail.com', 'Lee', 'Sean', 'Lau', '013-6510589', 'M', 'Mr.', TO_DATE('4/8/1995', 'dd/mm/yyyy'), 27, 'Lau_48')
    INTO Person VALUES ('marsya31@gmail.com', 'Marsya', 'Iman', 'Ali', '017-5380089', 'F', 'Miss', TO_DATE('31/7/1999', 'dd/mm/yyyy'), 23, 'marsya31')
    INTO Person VALUES ('zariff13@gmail.com', 'Muhammad', 'Zariff', 'Haiqal', '010-9875890', 'M', 'Mr.', TO_DATE('13/10/2001', 'dd/mm/yyyy'), 21, 'zaRiff#')
SELECT * FROM DUAL;

INSERT ALL
    INTO Address VALUES (1, '45', 'Jalan Bukit Bintang', 'KL', 'Kuala Lumpur', '65710', 'Malaysia', 'Home', 101.6869, 3.139)
    INTO Address VALUES (2, '66', 'Jalan Chulia', 'George Town', 'Pulau Pinang', '92910', 'Malaysia', 'Home', 100.3327, 5.4164)
    INTO Address VALUES (3, '7', 'Jalan Hang Jebat', 'Malacca', 'Melaka', '89202', 'Malaysia', 'Workplace', 102.2501, 2.1896)
    INTO Address VALUES (4, '99', 'Jalan Kuching', 'Kuching', 'Sarawak', '27120', 'Malaysia', 'Workplace', 110.3593, 1.5535)
    INTO Address VALUES (5, '33', 'Jalan Gaya', 'Kota Kinabalu', 'Sabah', '92030', 'Malaysia', 'Workplace', 116.0753, 5.9788)
    INTO Address VALUES (6, '57', 'Jalan Pudu', 'Ipoh', 'Perak', '73572', 'Malaysia', 'Workplace', 101.0901, 4.5975)
    INTO Address VALUES (7, '32', 'Jalan Riang', 'Johor Bharu', 'Johor', '73929', 'Malaysia', 'Home', 103.7414, 1.4927)
    INTO Address VALUES (8, '40', 'Jalan Pantai', 'Kuala Terengganu', 'Terengganu', '82689', 'Malaysia', 'Home', 103.1350, 5.3157)
    INTO Address VALUES (9, '65', 'Jalan Brooke', 'Miri', 'Sarawak', '72937', 'Malaysia', 'Home', 103.3260, 3.8077)
    INTO Address VALUES (10, '24', 'Jalan Besar', 'Kuantan', 'Pahang', '85120', 'Malaysia', 'Home', 100.5329, 3.8077)
    INTO Address VALUES (11, '57', 'Taman Masjid Lama', 'Alor Setar', 'Kedah', '38290', 'Malaysia', 'Home', 100.3664, 6.1246)
    INTO Address VALUES (12, '11', 'Taman Sentosa', 'Putrajaya', 'WP Putrajaya', '92730', 'Malaysia', 'Workplace', 101.7133, 2.9140)
    INTO Address VALUES (13, '22', 'Kawasan Perkilangan Jamid', 'Kota Bharu', 'Kelantan', '92790', 'Malaysia', 'Workplace', 102.2479, 6.1454)
    INTO Address VALUES (14, '40', 'Kawasan Perushaan Keledang', 'Sandakan', 'Sabah', '79202', 'Malaysia', 'Home', 117.8823, 5.8402)
    INTO Address VALUES (15, '76', 'Jalan Bukit Hitam', 'Shah Alam', 'Selangor', '39270', 'Malaysia', 'Workplace', 101.5151, 3.0907)
    INTO Address VALUES (16, '43', 'Taman Jeletik', 'Taiping', 'Perak', '82648', 'Malaysia', 'Home', 100.7414, 4.8546)
    INTO Address VALUES (17, '8', 'Taman Chepor Indah', 'Tawau', 'Sabah', '74655', 'Malaysia', 'Home', 117.8883, 4.2505)
    INTO Address VALUES (18, '38', 'Jalan Kuala Pari', 'Petaling Jaya', 'Selangor', '45450', 'Malaysia', 'Home', 101.6286, 3.0907)
    INTO Address VALUES (19, '13', 'Taman Kemedang', 'Seremban', 'Negeri Sembilan', '13450', 'Malaysia', 'Workplace', 101.9441, 2.7258)
    INTO Address VALUES (20, '12', 'Eco World Park', 'Muar', 'Johor', '42430', 'Malaysia', 'Workplace', 102.5665, 2.0469)
    INTO Address VALUES (21, '90', 'Jalan Kampar', 'Teluk Intan', 'Perak', '23440', 'Malaysia', 'Workplace', 101.0216, 4.0323)
    INTO Address VALUES (22, '70', 'Taman Ceria', 'Kangar', 'Perlis', '86420', 'Malaysia', 'Workplace', 100.1992, 6.4449)
    INTO Address VALUES (23, '35', 'Kawasan Perkilangan Kuala Sari', 'Kuala Kangsar', 'Perak', '76430', 'Malaysia', 'Workplace', 101.0859, 4.7667)
    INTO Address VALUES (24, '13', 'Taman Seri Jaya', 'Kuala Dungun', 'Terengganu', '54870', 'Malaysia', 'Workplace', 103.4200, 4.7311)
    INTO Address VALUES (25, '46', 'Jalan Tokong Lim', 'Temerloh', 'Terengganu', '34580', 'Malaysia', 'Home', 102.4429, 3.4407)
    INTO Address VALUES (26, '74', 'Taman Jaya Kambus', 'Semporna', 'Sabah', '35660', 'Malaysia', 'Home', 118.6123, 4.4850)
    INTO Address VALUES (27, '58', 'Kawasan Perushaan Batu Pahat', 'Batu Pahat', 'Johor', '34560', 'Malaysia', 'Home', 102.9315, 1.8537)
    INTO Address VALUES (28, '99', 'Taman Chemor Jaya', 'Bintulu', 'Sarawak', '44550', 'Malaysia', 'Workplace', 113.0622, 3.2209)
    INTO Address VALUES (29, '69', 'Jalan Gaya Tupen', 'Subang Jaya', 'Selangor', '22440', 'Malaysia', 'Workplace', 101.5268, 3.0497)
    INTO Address VALUES (30, '32', 'Jalan Lipis', 'Kulai', 'Johor', '24450', 'Malaysia', 'Workplace', 103.6035, 1.6632)
    INTO Address VALUES (31, '45', 'Kampung Sungai Rapat', 'Klang', 'Selangor', '23350', 'Malaysia', 'Home', 101.4437, 3.0600)
    INTO Address VALUES (32, '32', 'Taman Delima', 'Sungai Petani', 'Kedah', '42350', 'Malaysia', 'Workplace', 100.5047, 5.6389)
    INTO Address VALUES (33, '62', 'Jalan Persiaran Putra', 'Sibu', 'Sarawak', '24380', 'Malaysia', 'Home', 111.8210, 2.3022)
    INTO Address VALUES (34, '64', '1 Wisma Yakin', 'Lahad Datu', 'Sabah', '12340', 'Malaysia', 'Workplace', 118.3277, 5.0310)
    INTO Address VALUES (35, '78', 'Jalan Hilir Kawasan 4', 'Batu Gajah', 'Perak', '45450', 'Malaysia', 'Workplace', 101.0231, 4.4686)
    INTO Address VALUES (36, '94', 'Jalan Jelapang', 'Segamat', 'Johor', '34560', 'Malaysia', 'Home', 102.8429, 2.4974)
    INTO Address VALUES (37, '55', 'Jln Raja Abdullah', 'Bukit Mertajam', 'Pulau Pinang', '14000', 'Malaysia', 'Workplace', 100.4534, 5.3644)
    INTO Address VALUES (38, '66', 'Kampung Kangkar', 'Ampang Jaya', 'Selangor', '54380', 'Malaysia', 'Home', 101.7614, 3.1509)
    INTO Address VALUES (39, '67', 'Jln Pandan', 'Sepang', 'Selangor', '87550', 'Malaysia', 'Workplace', 101.7120, 2.6892)
    INTO Address VALUES (40, '91', 'Kulim Avenue', 'Manjung', 'Perak', '32160', 'Malaysia', 'Workplace', 100.6306, 4.2302)
    INTO Address VALUES (41, '10', 'Jalan Merdeka', 'Medan Putra', 'Alor Setar', '5000', 'Malaysia', 'Commercial', 100.381, 6.118)
    INTO Address VALUES (42, '5', 'Jalan Sentral', 'MyTown', 'Kuala Lumpur', '50200', 'Malaysia', 'Commercial', 101.694, 3.147)
    INTO Address VALUES (43, '31', 'Jalan Stesen Sentral', 'NU Sentral', 'Kuala Lumpur', '50470', 'Malaysia', 'Commercial', 101.686, 3.134)
    INTO Address VALUES (44, '15', 'Jalan Bestari', 'Jasin Bestari', 'Melaka', '77000', 'Malaysia', 'Commercial', 102.375, 2.268)
    INTO Address VALUES (45, '8', 'Jalan Ipoh', 'Ipoh Band Squara', 'Perak', '30100', 'Malaysia', 'Commercial', 101.087, 4.593)
    INTO Address VALUES (46, '38', 'Jalan Stesen 18', 'AEON Mall Ipoh Station 18', 'Perak', '31400', 'Malaysia', 'Commercial', 101.082, 4.601)
    INTO Address VALUES (47, '3', 'Jalan Raja Syed Alwi', 'Arau', 'Perlis', '2600', 'Malaysia', 'Commercial', 100.257, 6.429)
    INTO Address VALUES (48, '20', 'Jalan Lintas', 'Lintas Plaza', 'Sabah', '88300', 'Malaysia', 'Commercial', 116.083, 5.971)
    INTO Address VALUES (49, '7', 'Jalan Temiang', 'Caltex Temiang', 'Negeri Sembilan', '70200', 'Malaysia', 'Commercial', 102.232, 2.727)
    INTO Address VALUES (50, '12', 'Jalan Bentong', 'Bentong', 'Pahang', '28700', 'Malaysia', 'Commercial', 101.907, 3.525)
SELECT * FROM DUAL;


INSERT ALL
    INTO Branch VALUES (1, 'Medan Putra, Alor Setar', '016-8701068', 'ZUS_MedanPutra@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('7.00 P.M.', 'HH.MI P.M.'), TO_DATE('2/2/2023', 'DD/MM/YYYY'), 7, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area', 200000.00)
    INTO Branch VALUES (2, 'MyTown Shopping Mall, Kuala Lumpur', '010-5013570', 'ZUS_MyTownShoppingMall@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('9.00 P.M.', 'HH.MI P.M.'), TO_DATE('4/2/2023', 'DD/MM/YYYY'), 5, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area', 350000.00)
    INTO Branch VALUES (3, 'NU Sentral', '019-4660210', 'ZUS_NUSentral@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('9.00 P.M.', 'HH.MI P.M.'), TO_DATE('6/2/2023', 'DD/MM/YYYY'), 9, 'coffee bar, seating area, WiFi access,Restroom, Preparation area, Speacialty brew and brewing equipment', 150000.00)
    INTO Branch VALUES (4, 'Jasin Bestari, Melaka', '017-9501035', 'ZUS_Jasin@gmail.com', TO_TIMESTAMP('11.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('9.00 P.M.', 'HH.MI P.M.'), TO_DATE('8/2/2023', 'DD/MM/YYYY'), 10, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area', 260000.00)
    INTO Branch VALUES (5, 'Ipoh Band Squara, Perak', '016-8740138', 'ZUS_IpohBand@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('9.30 P.M.', 'HH.MI P.M.'), TO_DATE('10/2/2023', 'DD/MM/YYYY'), 8, 'coffee bar, seating area, WiFi access,Restroom, Preparation area, Speacialty brew and brewing equipment', 300000.00)
    INTO Branch VALUES (6, 'AEON Mall Ipoh Station 18', '012-9705413', 'ZUS_AEONMallSt18@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('9.00 P.M.', 'HH.MI P.M.'), TO_DATE('12/2/2023', 'DD/MM/YYYY'), 7, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area, Drive-Thru or Takeaway counter', 640000.00)
    INTO Branch VALUES (7, 'Arau, Perlis', '016-5138799', 'ZUS_Arau@gmail.com', TO_TIMESTAMP('10.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('10.00 P.M.', 'HH.MI P.M.'), TO_DATE('14/2/2023', 'DD/MM/YYYY'), 7, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area, Drive-Thru or Takeaway counter', 450000.00)
    INTO Branch VALUES (8, 'Lintas Plaza, Sabah', '016-9103420', 'ZUS_Lintas@gmail.com', TO_TIMESTAMP('9.30 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('8.00 P.M.', 'HH.MI P.M.'), TO_DATE('16/2/2023', 'DD/MM/YYYY'), 5, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area, Drive-Thru or Takeaway counter', 320000.00)
    INTO Branch VALUES (9, 'Caltex Temiang', '017-1678055', 'ZUS_Temiang@gmail.com', TO_TIMESTAMP('9.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('11.00 P.M.', 'HH.MI P.M.'), TO_DATE('18/2/2023', 'DD/MM/YYYY'), 9, 'coffee bar, seating area, WiFi access,Restroom, Preparation area, Speacialty brew and brewing equipment', 190000.00)
    INTO Branch VALUES (10, 'Bentong, Pahang', '018-9705103', 'ZUS_Bentong@gmail.com', TO_TIMESTAMP('8.00 A.M.', 'HH.MI A.M.'), TO_TIMESTAMP('12.00 P.M.', 'HH.MI P.M.'), TO_DATE('20/2/2023', 'DD/MM/YYYY'), 6, 'Coffee bar, seating area, WiFi access,Restroom, Preparation area, Drive-Thru or Takeaway counter', 520000.00)
SELECT * FROM DUAL;


INSERT ALL
    INTO Applicant VALUES (1, 'emsyar10@gmail.com', 'Single', '940610-01--9791', 'Malay', 'Degree', 'Malaysian', 'Islam', 'Mohd Shahrir B. Zahid', '016-7845620', 'Guardian')
    INTO Applicant VALUES (2, 'farisya99@gmail.com', 'Single', '010909-03-2024', 'Malay', 'Diploma', 'Malaysian', 'Islam', 'Siti Aminah Bt. Anas', '013-5460012', 'Mother')
    INTO Applicant VALUES (3, 'ghopal17@gmail.com', 'Married', '900517-11-5957', 'Indian', 'Degree', 'Malaysian', 'Hindu', 'Revalin', '016-1028430', 'Daughter')
    INTO Applicant VALUES (4, 'hua22@gmail.com', 'Single', '020722-07-5313', 'Chinese', 'Degree', 'Malaysian', 'Buddha', 'Chin Teo Lai', '019-7853412', 'Sibling')
    INTO Applicant VALUES (5, 'intan53@gmail.com', 'Married', '940305-10-2426', 'Malay', 'Diploma', 'Malaysian', 'Islam', 'Farid B. Idham', '012-8870012', 'Father')
    INTO Applicant VALUES (6, 'kuan91@gmail.com', 'Single', '041109-01-7751', 'Chinese', 'Diploma', 'Malaysian', 'Buddha', 'Steven Alvin', '013-5541021', 'Sibling')
    INTO Applicant VALUES (7, 'jamilah6@gmail.com', 'Married', '911206-02-1014', 'Malay', 'Master', 'Malaysian', 'Islam', 'Kamal B. Fuad', '017-4655300', 'Guardian')
    INTO Applicant VALUES (8, 'lee48@gmail.com', 'Married', '950804-07-3152', 'Chinese', 'Master', 'Malaysian', 'Christian', 'Chia Zen', '018-7821001', 'Guardian')
    INTO Applicant VALUES (9, 'marsya31@gmail.com', 'Single', '990731-08-6021', 'Malay', 'Degree', 'Malaysian', 'Islam', 'Joridah Bt. Saad', '019-4201360', 'Mother')
    INTO Applicant VALUES (10, 'zariff13@gmail.com', 'Single', '011013-06-3971', 'Malay', 'Diploma', 'Malaysian', 'Islam', 'Othman B. Bakar', '010-8960047', 'Father')
SELECT * FROM DUAL;

INSERT ALL
    INTO Inventory VALUES (1, 'A-1', 'Foods', 164, 100, TO_DATE('7/5/2023', 'DD/MM/YYYY'), 500, 50, TO_DATE('10/6/2023', 'DD/MM/YYYY'), 'Section A', 1)
    INTO Inventory VALUES (2, 'B-7', 'Drinks', 95, 50, TO_DATE('8/5/2023', 'DD/MM/YYYY'), 200, 20, TO_DATE('11/6/2023', 'DD/MM/YYYY'), 'Section B', 2)
    INTO Inventory VALUES (3, 'C-3', 'Cutlery', 45, 200, TO_DATE('9/5/2023', 'DD/MM/YYYY'), 300, 30, TO_DATE('9/6/2023', 'DD/MM/YYYY'), 'Section C', 3)
    INTO Inventory VALUES (4, 'D-9', 'Merchandise', 74, 20, TO_DATE('10/5/2023', 'DD/MM/YYYY'), 100, 10, TO_DATE('12/6/2023', 'DD/MM/YYYY'), 'Section D', 4)
    INTO Inventory VALUES (5, 'E-5', 'Cutlery', 314, 250, TO_DATE('11/5/2023', 'DD/MM/YYYY'), 400, 20, TO_DATE('8/6/2023', 'DD/MM/YYYY'), 'Section E', 5)
    INTO Inventory VALUES (6, 'F-2', 'Drinks', 220, 30, TO_DATE('12/5/2023', 'DD/MM/YYYY'), 250, 25, TO_DATE('13/6/2023', 'DD/MM/YYYY'), 'Section F', 6)
    INTO Inventory VALUES (7, 'G-8', 'Foods', 197, 80, TO_DATE('13/5/2023', 'DD/MM/YYYY'), 800, 40, TO_DATE('10/6/2023', 'DD/MM/YYYY'), 'Section G', 7)
    INTO Inventory VALUES (8, 'H-4', 'Cutlery', 45, 150, TO_DATE('14/5/2023', 'DD/MM/YYYY'), 450, 20, TO_DATE('7/6/2023', 'DD/MM/YYYY'), 'Section H', 8)
    INTO Inventory VALUES (9, 'I-6', 'Merchandise', 65, 15, TO_DATE('15/5/2023', 'DD/MM/YYYY'), 120, 12, TO_DATE('14/6/2023', 'DD/MM/YYYY'), 'Section I', 9)
    INTO Inventory VALUES (10, 'J-10', 'Drinks', 17, 40, TO_DATE('16/5/2023', 'DD/MM/YYYY'), 180, 30, TO_DATE('6/6/2023', 'DD/MM/YYYY'), 'Section J', 10)
SELECT * FROM DUAL;

-----------------------------------EDIT HERE--------------------------------------------
INSERT ALL 
    INTO Customer VALUES (1, 'aminasraff3@gmail.com', 'credit card', 'ZUSS11', 'ZC250AB', INTERVAL' 0 00:26:00' DAY TO SECOND, 'SILVER', 'HIGH', 1, 100, 'amir_danial', 'PREMIUM', 1)
    INTO Customer VALUES (2, 'mysara11@gmail.com', 'QR', 'ZUSS12', 'ZC251CD', INTERVAL '0 00:13:00' DAY TO SECOND, 'GOLD', 'MEDIUM', 1, 50, 'ifabatrisyia', 'BASIC', 2)
    INTO Customer VALUES (3, 'jarinah12@gmail.com', 'debit', 'ZUSS13', 'ZC252EF', INTERVAL '0 00:34:00' DAY TO SECOND, 'BRONZE', 'HIGH', 5, 250, 'wanemir69', 'VIP', 3)
    INTO Customer VALUES (4, 'syafiq31@gmail.com', 'debit', 'ZUSS14', 'ZC253GH', INTERVAL '0 00:16:00' DAY TO SECOND, 'SILVER', 'LOW', 2, 573, 'harris_89', 'PREMIUM', 4)
    INTO Customer VALUES (5, 'adamfeb28@gmail.com', 'cash', 'ZUSS15', 'ZC254IJ',INTERVAL '0 00:45:00' DAY TO SECOND, 'PLATINUM', 'HIGH', 6, 480, 'Fasyastar51', 'VIP', 5)
    INTO Customer VALUES (6, 'ammar19@gmail.com', 'credit card', 'ZUSS16', 'ZC255KL', INTERVAL '0 00:55:00' DAY TO SECOND, 'GOLD', 'MEDIUM', 8, 548, 'aminah_8', 'BASIC', 6)
    INTO Customer VALUES (7, 'jamal72@gmail.com', 'cash', 'ZUSS17', 'ZC256MN', INTERVAL '0 01:05:00' DAY TO SECOND, 'BRONZE', 'HIGH', 10, 230, 'mimi_roslan', 'BASIC', 7)
    INTO Customer VALUES (8, 'muaz66@gmail.com', 'QR', 'ZUSS18', 'ZC257OP',  INTERVAL'0 00:15:00' DAY TO SECOND, 'GOLD', 'HIGH', 2, 50, 'NurAzlina', 'VIP', 8)
    INTO Customer VALUES (9, 'chua45@gmail.com', 'debit', 'ZUSS19', 'ZC258PQ', INTERVAL '0 00:38:00' DAY TO SECOND, 'GOLD', 'LOW', 4, 70, 'nayli_47', 'PREMIUM', 9)
    INTO Customer VALUES (10, 'dania29@gmail.com', 'cash', 'ZUSS20', 'ZC259RS', INTERVAL '0 00:10:00' DAY TO SECOND, 'GOLD', 'HIGH', 1, 523, 'zulamzar_geng', 'VIP', 10)
SELECT * FROM DUAL;

INSERT ALL
    INTO Department VALUES (1, 'Admin', 20, 'ZussCoffee_Admin@gmail.com', 'Plays a crucial role in ensuring smooth and efficient operations of the coffee shop company.', 150000, '44 1249657995', 'Excellent', '011-5992580', '05-14-06')
    INTO Department VALUES (2, 'Business Development', 15, 'ZussCoffee_BusinessDevelopment@gmail.com', 'Focuses on identifying and pursuing growth opportunities for the coffee shop company.', 300000, '25 226126133', 'Good', '016-5139880', '06-14-00')
    INTO Department VALUES (3, 'Design and Build', 7, 'ZussCoffee_DesignandBuild@gmail.com', 'Responsible for creating visually appealing and functional coffee shop spaces.', 200000, '34 573679381', 'Excellent', '019-2048931', '07-24-06')
    INTO Department VALUES (4, 'Finance', 12, 'ZussCoffee_Finance@gmail.com', 'Manages the financial operations of the coffee shop company. It handles budgeting, financial planning, and forecasting.', 150000, '35 779257276', 'Good', '017-6479001', '08-16-03')
    INTO Department VALUES (5, 'Internal Audit', 8, 'ZussCoffee_InternalAudit@gmail.com', 'Ensures compliance, risk management, and operational efficiency within the coffee shop company.', 70000, '33 982364116', 'Excellent', '014-2011641', '02-19-05')
    INTO Department VALUES (6, 'Operations', 24, 'ZussCoffee_Operations@gmail.com', 'Manages store operations, inventory control, quality assurance, and customer service.', 600000, '36 034817146', 'Normal', '016-1414310', '02-20-02')
    INTO Department VALUES (7, 'Human Resources', 6, 'ZussCoffee_HumanResources@gmail.com', 'Responsible for managing the human capital.', 200000, '39 140391401', 'Normal', '019-4203058', '04-15-07')
    INTO Department VALUES (8, 'Supply Chain', 25, 'ZussCoffee_SupplyChain@gmail.com', 'Manages the sourcing, procurement, and logistics of materials and products for the coffee shop company.', 60000, '42 541241278', 'Normal', '018-1446203', '03-14-02')
    INTO Department VALUES (9, 'Growth and Marketing', 10, 'ZussCoffee_GrowthandMarketing@gmail.com', 'Responsible for driving brand awareness, customer engagement, and revenue growth.', 300000, '40 674126192', 'Normal', '010-7256110', '08-19-03')
    INTO Department VALUES (10, 'Project Management Office(PMO)', 14, 'ZussCoffee_PMO@gmail.com', 'Ensures project objectives are met, timelines are followed, and resources are allocated efficiently.', 200000, '45 325678113', 'Underperformed', '019-9540035', '05-13-01')
SELECT * FROM DUAL;

INSERT ALL
    INTO Employee VALUES (1, 'amirdanial01@gmail.com', 'Outlet Manager', 3200, 'Permanent', 'Master', DATE '2021-06-12', 'Malay', 'Single', 'Malaysian', 'Islam', 'Great!', '0201030-08-5317', 1, 1, 1, 1)
    INTO Employee VALUES (2, 'ifabatrisya30@gmail.com', 'Baristar', 1800, 'Permanent', 'Degree', DATE '2022-04-03', 'Malay', 'Single', 'Malaysian', 'Islam', 'Excellent', '900211-07-2680', 2, 2, 2, 2)
    INTO Employee VALUES (3, 'wanemir69@gmail.com', 'Outlet Supervisor', 3700, 'Contract', 'Diploma', DATE '2022-11-06', 'Malay', 'Married', 'Malaysian', 'Islam', 'No comment', '631212-03-4248', 3, 3, 3, 3)
    INTO Employee VALUES (4, 'harris89@gmail.com', 'Head Quarters', 6400, 'Permanent', 'Master', DATE '2019-02-08', 'Malay', 'Married', 'Malaysian', 'Islam', 'Nice', '891231-02-9713', 4, 4, 4, 4)
    INTO Employee VALUES (5, 'fasya51@gmail.com', 'Baristar', 1300, 'Contract', 'Diploma', DATE '2023-01-27', 'Iban', 'Single', 'Malaysian', 'Christian', 'Need improvement', '951128-12-7371', 5, 5, 5, 5)
    INTO Employee VALUES (6, 'aminah08@gmail.com', 'Outlet Manager', 2800, 'Contract', 'Degree',DATE '2022-05-09', 'Malay', 'Single', 'Malaysian', 'Islam', 'Good Job!', '000619-01-5379', 6, 6, 6, 6)
    INTO Employee VALUES (7, 'mimiroslan63@gmail.com', 'Head Quarters', 5900, 'Permanent', 'Degree',DATE '2021-12-08', 'Malay', 'Married', 'Malaysian', 'Islam', 'Great!', '820207-04-1157', 7, 7, 7, 7)
    INTO Employee VALUES (8, 'azlinanur12@gmail.com', 'Baristar', 1800, 'Contract', 'Diploma', DATE '2022-09-01', 'Malay', 'Single', 'Malaysian', 'Islam', 'Excellent', '030606-09-1791', 8, 8, 8, 8)
    INTO Employee VALUES (9, 'nayli47@gmail.com', 'Outlet Supervisor', 3500, 'Permanent', 'Master', DATE '2021-05-14', 'Chinese', 'Married', 'Malaysian', 'Budha', 'No comment', '730504-11-5131', 9, 9, 9, 9)
    INTO Employee VALUES (10, 'zulamzar43@gmail.com', 'Management Trainee', 2700, 'Permanent', 'Degree', DATE '2023-01-02', 'Malay', 'Single', 'Malaysian', 'Islam', 'Need improvement', '941029-01-2686', 10, 10, 10, 10)
SELECT * FROM DUAL;

INSERT ALL 
    INTO Application VALUES (1, 'Jitra, Kedah', 'Outlet Manager', 'Internal Audit', DATE '2023-05-23', 'https://example.com/res1', 'Y', '3 years with skillfull work ', 'Previous Employment', 98, 'Accept', 1, 1)
    INTO Application VALUES (2, 'Taman Kota Masai, Johor', 'Management Trainee (Operation)', 'Learning and Development (Academy)', DATE '2022-09-08', 'https://example.com/res2', 'Y', '2 Years internship', 'Social Media Presence', 86, 'Pending', 2, NULL)
    INTO Application VALUES (3, 'Selangor', 'Head Quarters', 'Human Resources', DATE '2021-11-17', 'https://example.com/res3', 'Y', '5 Years managerial experts', 'Published Articles or Blog Posts', 97, 'Accept', 3, 2)
    INTO Application VALUES (4, 'KB Mall, Kelantan', 'Outlet Manager', 'Business Development', DATE '2023-02-10', 'https://example.com/res4', 'Y', '10 years team player', 'Previous Employment', 40, 'Reject', 4, NULL)
    INTO Application VALUES (5, 'Masjid Tanah, Melaka', 'Barista (Full Time)', 'Operation', DATE '2023-01-19', 'https://example.com/res5', 'Y', '4 Years', 'Social Media Presence', 89, 'Accept', 5, 3)
    INTO Application VALUES (6, 'Ayer Keroh, Melaka', 'Barista (Part Time)', 'Operation', DATE '2023-03-24', 'https://example.com/res6', 'Y', '1 Year', 'Social Media Presence', 77, 'Accept', 6, 4)
    INTO Application VALUES (7, 'ITCC Penampang, Sabah', 'Outlet Supervisior', 'Finance', DATE '2022-01-30', 'https://example.com/res7', 'Y', '5 Years', 'Previous Employment', 52, 'Reject', 7, NULL)
    INTO Application VALUES (8, 'Selangor', 'Head Quarters', 'Admin', DATE '2023-05-05', 'https://example.com/res8',  'Y', '5 Years', 'Social Media Presence', 80, 'Pending', 8, NULL)
    INTO Application VALUES (9, 'Gurney Paragon Mall, Penang', 'Outlet Supervisior', 'Internal Audit', DATE '2023-06-14', 'https://example.com/res9', 'Y', '7 years', 'Social Media Presence', 88, 'Pending', 9, NULL)
    INTO Application VALUES (10, 'The Curve, Selangor', 'Barista (Part Time)', 'Operation',DATE '2023-06-02', 'https://example.com/res10', 'Y', '4 Years', 'Previous Employment', 92, 'Accept', 10, 5)
SELECT * FROM DUAL;

INSERT ALL 
    INTO Attendance VALUES (1, DATE '2023-05-28', 'Online', 'Successful', 'Consistently punctual and demonstrates excellent attendance.', TO_TIMESTAMP('2023-05-28 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-05-28 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 101, 99, 1)
    INTO Attendance VALUES (2, DATE '2023-05-30', 'Physical', 'Successful', 'Regularly attends work on time and maintains a strong attendance record.', TO_TIMESTAMP('2023-05-30 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-05-30 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 99, 96, 2)
    INTO Attendance VALUES (3, DATE '2023-06-01', 'Online', 'Successful', 'Shows dedication by rarely missing work and being consistently present.', TO_TIMESTAMP('2023-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-01 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 98, 94, 3)
    INTO Attendance VALUES (4, DATE '2023-06-02', 'Online', 'Successful', 'Maintains a commendable attendance record and is reliable in terms of punctuality.', TO_TIMESTAMP('2023-06-02 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-02 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 100, 95, 4)
    INTO Attendance VALUES (5, DATE '2023-06-04', 'Physical', 'Successful', 'Exhibits exceptional attendance, rarely taking unplanned time off.', TO_TIMESTAMP('2023-06-04 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-04 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 102, 96, 5)
    INTO Attendance VALUES (6, DATE '2023-06-06', 'Online', 'Successful', 'Consistently meets attendance expectations and is always present when needed.', TO_TIMESTAMP('2023-06-06 08:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-06 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 97, 95, 6)
    INTO Attendance VALUES (7, DATE '2023-06-08', 'Online', 'Successful', 'Demonstrates a strong commitment to attendance by rarely being absent or late.', TO_TIMESTAMP('2023-06-08 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-08 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 99, 97, 7)
    INTO Attendance VALUES (8, DATE '2023-06-06', 'Physical', 'Successful', 'Maintains a reliable attendance record, ensuring consistent presence in the workplace.', TO_TIMESTAMP('2023-06-06 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 101, 99, 8)
    INTO Attendance VALUES (9, DATE '2023-06-10', 'Online', 'Successful', 'Exhibits excellent attendance habits and consistently meets attendance requirements.', TO_TIMESTAMP('2023-06-10 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-10 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 101, 99, 9)
    INTO Attendance VALUES (10, DATE '2023-06-12', 'Online', 'Successful', 'Consistently attends work without any unexcused absences, showcasing a strong sense of responsibility.', TO_TIMESTAMP('2023-06-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-06-12 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 240, 101, 99, 10)
SELECT * FROM DUAL;



INSERT ALL 
    INTO Leave VALUES (1, 'Annual Leave', DATE '2023-03-01', 'Personal reason', DATE '2023-03-05', DATE '2023-03-08', 4, 139, 'Employee has taken their entitled annual leave for the year.', 'Approved', DATE '2023-03-02', 1, 1)
    INTO Leave VALUES (2, 'Sick Leave', DATE '2023-03-02', 'Fever', DATE '2023-03-02', DATE '2023-03-03', 2, 141, 'Employee has taken sick leave due to illness or medical condition.', 'Approved', DATE '2023-03-02', 2, 2)
    INTO Leave VALUES (3, 'Sick Leave', DATE '2023-03-04', 'Medical treatment', DATE '2023-03-04', DATE '2023-03-04', 1, 142, 'Employee has taken leave to attend to family matters or take care of a family member.', 'Approved', DATE '2023-03-04', 2, 3)
    INTO Leave VALUES (4, 'Emergency Leave', DATE '2023-03-06', 'Personal reason', DATE '2023-03-06', DATE '2023-03-08', 3, 140, 'Employee has taken personal leave for personal reasons or emergencies.', 'Approved', DATE '2023-03-06', 3, 4)
    INTO Leave VALUES (5, 'Unpaid Leave', DATE '2023-03-08', 'Personal reason', DATE '2023-03-12', DATE '2023-03-15', 4, 138, 'Employee has taken parental leave to care for their child well-being and development.', 'Approved', DATE '2023-03-09', 4, 5)
    INTO Leave VALUES (6, 'Sick Leave', DATE '2023-03-10', 'COVID_19', DATE '2023-03-10', DATE '2023-03-16', 7, 143, 'Employee has taken emergency leave due to an unforeseen and urgent situation.', 'Approved', DATE '2023-03-10', 5, 6)
    INTO Leave VALUES (7, 'Annual Leave', DATE '2023-03-12', 'Personal reason', DATE '2023-03-12', DATE '2023-03-12', 1, 141, 'Employee has taken leave without pay for personal reasons or based on mutually agreed arrangements.', 'Approved', DATE '2023-03-12', 5, 7)
    INTO Leave VALUES (8, 'Medical Leave', DATE '2023-03-14', 'Family medical reason', DATE '2023-03-20', DATE '2023-03-20', 1, 139, 'Employee has taken maternity leave to attend to childbirth and initial postnatal care.', 'Approved', DATE '2023-03-16', 5, 8)
    INTO Leave VALUES (9, 'Training Leave', DATE '2023-03-16', 'Attend training program', DATE '2023-03-24', DATE '2023-03-26', 3, 139, 'Employee has taken leave to attend work-related training programs, workshops, or conferences.', 'Rejected', DATE '2023-03-18', 7, 9)
    INTO Leave VALUES (10, 'Sick Leave', DATE '2023-03-18', 'Fever', DATE '2023-03-18', DATE '2023-03-20', 3, 139, 'Employee has taken an extended leave of absence beyond their regular entitlement for personal reasons, subject to prior approval.', 'Pending', DATE '2023-03-18', 1, 10)
SELECT * FROM DUAL;


INSERT ALL 
    INTO Training VALUES (1, 'Area Supervisor', 'They will gain hands-on experience in implementing strategies to drive sales, enhance productivity, and maintain a high-quality customer experience across all locations.', 'Strong leadership and communication skills.', 3 , 'Module 4', 'Online', 'Participants demonstrated improved leadership skills and effectively implemented strategies to drive sales and maintain a high-quality customer experience.', 'Leadership and management books or guides.', 'Learn to implement and maintain company standards and procedures across multiple coffee shop locations.')
    INTO Training VALUES (2, 'Barista Training', 'Trainees will learn to deliver consistently excellent coffee experiences, master latte art skills, and ensure adherence to hygiene and safety standards', 'Basic knowledge of coffee and espresso-based beverages.', 7, null, 'Physical', 'Trainees consistently delivered exceptional coffee experiences, mastered latte art skills, and ensured adherence to hygiene and safety standards.', 'Barista training manuals with step-by-step instructions for preparing different coffee beverages.', 'Master the art of coffee brewing and beverage preparation techniques.')
    INTO Training VALUES (3, 'Area Supervisor', 'Trainees will gain hands-on experience in driving sales, optimizing profitability, and fostering a positive work environment.', 'Familiarity with budgeting, financial analysis, and cost control.', 3, 'Module 4', 'Online', 'Trainees exhibited a strong understanding of sales strategies, optimized profitability, and fostered a positive work environment.', 'Sales and marketing strategies and resources.', 'Gain a deep understanding of coffee shop operations, including inventory management, staffing, and financial performance.')
    INTO Training VALUES (4, 'PIC', 'They will learn to manage inventory, implement marketing initiatives, handle customer inquiries and feedback, and ensure smooth store operations.', 'Previous experience in a supervisory or leadership role in a coffee shop or similar environment.', 3, 'ZACC Module 3', 'Physical', 'Trainees effectively managed inventory, implemented marketing initiatives, handled customer inquiries and feedback, and ensured smooth store operations.', 'Employee scheduling and time management tools.', 'Develop customer service skills to handle inquiries, feedback, and complaints, ensuring a positive customer experience.')
    INTO Training VALUES (5, 'Barista Training', 'Trainees will also be trained in maintaining equipment, following recipes, and delivering exceptional customer service through their coffee craftsmanship.', 'Willingness to learn and develop latte art skills.', 7, null, 'Physical', 'Participants demonstrated proficiency in coffee brewing techniques, espresso extraction, milk texturing, and drink customization, delivering exceptional customer service through their coffee craftsmanship.', 'Espresso machine operation and maintenance guides.', 'Acquire proficiency in latte art and the ability to create visually appealing coffee beverages.')
    INTO Training VALUES (6, 'Assistant PIC', 'Trainees will learn to manage inventory, assist in scheduling and staff coordination, handle cash transactions, and ensure exceptional customer service.', 'Ability to work effectively in a team and support the PIC.', 3, 'ZACC Module 2', 'Online', 'Trainees demonstrated excellent inventory management, scheduling, staff coordination, and cash handling skills, ensuring exceptional customer service.', 'Training modules on coffee shop equipment operation and troubleshooting.', 'Develop excellent customer service skills and the ability to handle customer inquiries and resolve issues effectively.')
    INTO Training VALUES (7, 'PIC', 'Trainees will develop leadership skills and contribute to the overall success of the coffee shop.', 'Excellent problem-solving and decision-making skills.', 3, 'ZACC Module 3', 'Physical', 'Participants displayed strong leadership skills and contributed to the overall success of the coffee shop, effectively solving problems and making informed decisions.', 'Training modules on health and safety regulations and food handling procedures.', 'Develop a comprehensive understanding of different coffee bean varieties and their characteristics.')
    INTO Training VALUES (8, 'Barista Training', 'They will learn coffee brewing techniques, espresso extraction, milk texturing, and drink customization.', 'Ability to work in a fast-paced environment.', 7, null, 'Physical', 'Participants successfully acquired coffee brewing techniques, espresso extraction skills, and the ability to create visually appealing latte art.', 'Latte art tutorials and practice resources.', 'Understand the responsibilities of overseeing daily operations in a coffee shop and managing staff effectively.')
    INTO Training VALUES (9, 'Area Supervisor', 'They will learn to monitor and evaluate store performance, implement operational strategies, conduct staff training and development, and ensure consistent adherence to brand standards.', 'Minimum of 2 years of experience in a supervisory or managerial role in the food and beverage industry.', 3, 'Module 4', 'Physical', 'Participants effectively monitored and evaluated store performance, implemented operational strategies, conducted staff training and development, and ensured consistent adherence to brand standards.', 'Case studies and real-life scenarios for problem-solving exercises.', 'Enhance problem-solving and decision-making abilities to address operational challenges.')
    INTO Training VALUES (10, 'Management Trainee', 'Trainees will rotate through different departments, including operations, finance, marketing, and human resources, gaining a broad understanding of the coffee shop functions.', 'Bachelor degree in business administration, hospitality management, or a related field.', 6, 'ZACC Module 1-3', 'Physical', 'Participants acquired a broad understanding of coffee shop functions, including operations, finance, marketing, and human resources, and demonstrated strategic thinking and decision-making abilities to contribute to the company growth and success.', 'Project management tools and templates.', 'Acquire strategic thinking and decision-making abilities to contribute to the company growth and success.')
SELECT * FROM DUAL;


INSERT ALL 
    INTO Supplier VALUES (1, 'Stellar Beans', DATE '2021-09-05', 'Zulkarnain B. Rashid', '012-5610257', DATE'2025-05-26', 'zulkarnain@gmail.com', 'Coffee beans', '202001516615', 'www.stellarbeans.com.my')
    INTO Supplier VALUES (2, 'Roast and Grind Coffee', DATE'2021-03-26', 'Maryam Azlina Bt. Anwar', '010-4431020', DATE'2024-01-30', 'maryam@gmail.com', 'Coffee powder', '201903326561', 'www.roastandgrindcoffee.com.my')
    INTO Supplier VALUES (3, 'Morning Sun', DATE'2022-08-09', 'Kamariah Bt. Sulaiman', '019-7480013', DATE'2025-02-06', 'kamariah@gmail.com', 'Coffee beans', '200103878432', 'www.morningsun.com.my')
    INTO Supplier VALUES (4, 'Dairy Delights', DATE'2021-11-30', 'Siti Zulaikha Bt. Arsyad', '017-3020158', DATE'2023-03-18', 'sitizulaikha@gmail.com', 'Milk', '200804564532', 'www.dairydelights.com.my')
    INTO Supplier VALUES (5, 'Fresh n Creamy', DATE'2021-12-07', 'Shamsul Nadjmi B. Annuar', '019-7782103', DATE'2025-04-09', 'shamsul@gmail.com', 'Fresh milk', '201203651566', 'www.freshncreamy.com.my')
    INTO Supplier VALUES (6, 'Milky Way Farms', DATE'2020-01-19', 'Ravendran Munash', '016-2030197', DATE'2023-05-27', 'ravendran@gmail.com', 'Milk', '201003654565', 'www.milkywayfarms.com.my')
    INTO Supplier VALUES (7, 'Elite Cutlery Co.', DATE'2022-05-16', 'Zainab Bt. Isa', '012-1380580', DATE'2026-06-15', 'zainab@gmail.com', 'fork', '200904231872', 'www.elitecutleryco.com.my')
    INTO Supplier VALUES (8, 'Precision Kitchenware', DATE'2021-07-03', 'Irfan Siddiq B. Anas', '019-4430121', DATE'2024-07-22', 'irfan@gmail.com', 'Straw', '200505564123', 'www.precisionkitchenware.com.my')
    INTO Supplier VALUES (9, 'Master Cutlery', DATE'2020-12-25', 'Nur Aisyah Bt. Rahman', '012-8410021', DATE'2025-08-19', 'nur@gmail.com', 'Spoon', '200705656132', 'www.mastercutlery.com.my')
    INTO Supplier VALUES (10, 'SweetHarvest', DATE'2021-05-14', 'Tang Wei Man', '019-7452101', DATE'2024-12-31', 'tang@gmail.com', 'Syrup', '200801878132', 'www.sweetharvest.com.my')
SELECT * FROM DUAL;



INSERT ALL 
    INTO Procurement VALUES (1, 3, 5, TO_DATE('1/6/2023', 'MM/DD/YYYY'), 'Cleaning and sanitizing supplies', 2400, 'Vendor Evaluation', 'Completed', 'Vendor exhibited excellent customer service and communication throughout the procurement process.', 2000, 1, 1)
    INTO Procurement VALUES (2, 2, 16, TO_DATE('1/28/2023', 'MM/DD/YYYY'), 'Tea and herbal infusions', 980, 'Request for Qoutation (RFQ)', 'In Progress', null, 800, 2, 2)
    INTO Procurement VALUES (3, 1, 20, TO_DATE('3/3/2023', 'MM/DD/YYYY'), 'Sugar, sweetners and stirrers', 645, 'Direct Procurement', 'Completed', 'Item received as per order specifications and in good condition', 400, 3, 3)
    INTO Procurement VALUES (4, 2, 33, TO_DATE('2/15/2023', 'MM/DD/YYYY'), 'Coffee beans', 1350, 'Quality Assurance and Samplings', 'Completed', 'Supplier was accommodating and flexible in adjusting the order to meet our changing needs.', 1600, 4, 4)
    INTO Procurement VALUES (5, 4, 10, TO_DATE('2/25/2023', 'MM/DD/YYYY'), 'Milk and diary products', 782, 'Request for Qoutation (RFQ)', 'Completed', 'Packaging materials received were of high quality and ensured product freshness', 1200, 5, 5)
    INTO Procurement VALUES (6, 6, 11, TO_DATE('3/4/2023', 'MM/DD/YYYY'), 'Baked goods and pastries', 8750, 'Just-in-Time (JIT)', 'In Progress', null, 2400, 6, 6)
    INTO Procurement VALUES (7, 3, 4, TO_DATE('3/16/2023', 'MM/DD/YYYY'), 'Packaging and merchandise', 6000, 'Vendor Evaluation', 'Declined', null, 900, 7, 7)
    INTO Procurement VALUES (8, 1, 9, TO_DATE('4/10/2023', 'MM/DD/YYYY'), 'Syrups and flavourings', 580, 'Quality Assurance and Samplings', 'In Progress', null, 450, 8, 8)
    INTO Procurement VALUES (9, 3, 29, TO_DATE('5/12/2023', 'MM/DD/YYYY'), 'Disposable cups and lids', 356, 'Online Ordering', 'Completed', 'Delivery was prompt and arrived within the agreed timeframe', 1200, 9, 9)
    INTO Procurement VALUES (10, 5, 3, TO_DATE('5/29/2023', 'MM/DD/YYYY'), 'Brewing equipment', 10640, 'Vendor Evaluation', 'In Progress', null, 4000, 10, 10)
SELECT * FROM DUAL;




INSERT ALL
    INTO Vehicle VALUES (1, 'Motorcycle', 'ARK8972', TO_DATE('4/23/2021', 'MM/DD/YYYY'), 8800, 2018, '5X7K9B3Z', 52345, 'Camry', 'Toyota', 'X7G92A', 1, 1, 1)
    INTO Vehicle VALUES (2, 'Motorcycle', 'VKT5123', TO_DATE('11/15/2019', 'MM/DD/YYYY'), 5397, 2019, 'P2R8M6D1', 87921, 'Civic', 'Honda', 'K3P68B', 2, 2, 2)
    INTO Vehicle VALUES (3, 'Motorcycle', 'KMT6541', TO_DATE('5/24/2022', 'MM/DD/YYYY'), 4090, 2019, '9G3J6F8T', 33789, 'F-150', 'Ford', 'M5R41C', 3, 3, 3)
    INTO Vehicle VALUES (4, 'Motorcycle', 'PHT4502', TO_DATE('12/29/2021', 'MM/DD/YYYY'), 3877, 2017, 'C5V2R9L6', 112503, '3 Series', 'BMW', 'H8J79D', 4, 4, 4)
    INTO Vehicle VALUES (5, 'Motorcycle', 'RMR4577', TO_DATE('6/1/2019', 'MM/DD/YYYY'), 4988, 2017, 'K4D6N8S2', 65217, 'Silverado', 'Chevrolet', 'F2L56E', 5, 5, 5)
    INTO Vehicle VALUES (6, 'Motorcycle', 'AMY6147', TO_DATE('7/11/2022', 'MM/DD/YYYY'), 5600, 2021, '3W6Q1E9R', 98654, 'C-Class', 'Mercedes-Benz', 'N9K23F', 6, 6, 6)
    INTO Vehicle VALUES (7, 'Van', 'WRK2023', TO_DATE('7/13/2021', 'MM/DD/YYYY'), 50350, 2020, 'R8Y2U4K6', 41872, 'Rogue', 'Nissam', 'P4Q87G', 7, 7, 7)
    INTO Vehicle VALUES (8, 'Motorcycle', 'JHR1670', TO_DATE('2/25/2023', 'MM/DD/YYYY'), 3490, 2020, '7L9H2N4C', 76945, 'Golf', 'Volkswagon', 'B1S34H', 8, 8, 8)
    INTO Vehicle VALUES (9, 'Motorcycle', 'SBR2290', TO_DATE('4/29/2021', 'MM/DD/YYYY'), 3150, 2019, 'F1T3S5G7', 28109, 'Tucson', 'Hyundai', 'T6W98I', 9, 9, 9)
    INTO Vehicle VALUES (10, 'Motorcycle', 'AHG8798', TO_DATE('8/30/2021', 'MM/DD/YYYY'), 4518, 2018, 'M6V9B3Z1', 93426, 'A4', 'Audi', 'V0D12J', 10, 10, 10)
SELECT * FROM DUAL;

SET DEF OFF;

INSERT ALL
    INTO Shipment VALUES (1, TO_DATE('1/8/2023', 'MM/DD/YYYY'), TO_DATE('2/21/2023', 'MM/DD/YYYY'), 'Sea Freight', 'TR105795847940', 'Completed', 'Liquid', 'Citylink', 'Pasir Gudang, Johor', 'Changlun, Kedah', 'Perishable goods - store in cool, dry conditions.', 720, TO_DATE('2/25/2023', 'MM/DD/YYYY'), '686.81 in³', 20, 1, 1, 1, 1, 1)
    INTO Shipment VALUES (2, TO_DATE('1/29/2023', 'MM/DD/YYYY'), TO_DATE('2/22/2023', 'MM/DD/YYYY'), 'Express Courier', 'WK2187995870087', 'Completed', 'Solid', 'Gdex', 'Dungun Terengganu', 'Centrio Square Senawang, Negeri Sembilan', 'Fragile contents - handle with care.', 34, TO_DATE('2/20/2023', 'MM/DD/YYYY'), '2196.85 in³', 21, 2, 2, 2, 2,2)
    INTO Shipment VALUES (3, TO_DATE('2/5/2023', 'MM/DD/YYYY'), TO_DATE('2/23/2023', 'MM/DD/YYYY'), 'Express Courier', 'PT458700970790', 'Completed', 'Cutlery', 'ABX Express', 'Kuantan, Pahang', 'Gurney Paragon Mall, Penang', 'Special instructions: Avoid exposure to direct sunlight', 9.8, TO_DATE('2/23/2023', 'MM/DD/YYYY'), '1281.95 in³', 22, 3, 3, 3, 3,3)
    INTO Shipment VALUES (4, TO_DATE('2/20/2023', 'MM/DD/YYYY'), TO_DATE('2/24/2023', 'MM/DD/YYYY'), 'Local Delivery', 'GH588070089070', 'Completed', 'Food', 'J&T Express', 'Pasir Mas Kelantan', 'Vortex, Bukit Tambun', 'Temperature-sensitive shipment - maintain between 15-25 degrees Celsius.', 30, TO_DATE('2/23/2023', 'MM/DD/YYYY'), '3661.42 in³', 23, 4, 4, 4, 4,4)
    INTO Shipment VALUES (5, TO_DATE('2/28/2023', 'MM/DD/YYYY'), TO_DATE('3/5/2023', 'MM/DD/YYYY'), 'Dropshipping', 'JK455041001168', 'Completed', 'Merchandise', 'Skynet Express', 'Ayer Keroh, Melaka', 'Putrajaya Presint 15', 'Urgent delivery required - please expedite.', 18, TO_DATE('3/7/2023', 'MM/DD/YYYY'), '457.87 in³', 24, 5, 5, 5, 5,5)
    INTO Shipment VALUES (6, TO_DATE('3/11/2023', 'MM/DD/YYYY'), TO_DATE('3/26/2023', 'MM/DD/YYYY'), 'Online Order Shipping', 'LH128804670024', 'Completed', 'Machine', 'DHL Express', 'Pedas, Negeri Sembilan', 'Bukit Raja, Selangor', 'Shipment includes equipment - fragile items inside.', 25, TO_DATE('3/30/2023', 'MM/DD/YYYY'), '2938.83 in³', 15.6, 25, 6, 6, 6, 6)
    INTO Shipment VALUES (7, TO_DATE('3/19/2023', 'MM/DD/YYYY'), TO_DATE('3/27/2023', 'MM/DD/YYYY'), 'Local Delivery', 'RF100579741354', 'Completed', 'Beans', 'ABX Express', 'Bangi, Selangor', 'Semenyih, Selangor', 'Shipment contains coffee samples for marketing purposes.', 26, TO_DATE('3/29/2023', 'MM/DD/YYYY'), '3315.43 in³', 9.8, 26, 7, 7, 7, 7)
    INTO Shipment VALUES (8, TO_DATE('4/15/2023', 'MM/DD/YYYY'), TO_DATE('4/28/2023', 'MM/DD/YYYY'), 'Local Delivery', 'TV571104500487', 'Completed', 'Syrup', 'J&T Express', 'Gurun, Kedah', 'Dataran Pahlawan, Melaka', 'Perishable goods - store in cool, dry conditions.', 27, TO_DATE('4/28/2023', 'MM/DD/YYYY'), '915.35 in³', 10, 27, 8, 8, 8, 8)
    INTO Shipment VALUES (9, TO_DATE('5/20/2023', 'MM/DD/YYYY'), TO_DATE('6/1/2023', 'MM/DD/YYYY'), 'Express Courier', 'SD135590064047', 'Completed', 'Food', 'TA-Q-BIN', 'Ipoh, Perak', 'Parit Buntar, Perak', 'Temperature-sensitive shipment - maintain between 15-25 degrees Celsius.', 28, TO_DATE('6/1/2023', 'MM/DD/YYYY'), '915.35 in³', 56, 28, 9, 9, 9, 9)
    INTO Shipment VALUES (10, TO_DATE('6/2/2023', 'MM/DD/YYYY'), TO_DATE('6/2/2023', 'MM/DD/YYYY'), 'Sea Freight', 'QW75820010016', 'Shipping', 'Fragile', 'Citylink', 'Kuching, Sarawak', 'Plaza 333, Sabah', 'Fragile contents - handle with care.', 29, TO_DATE('6/6/2023', 'MM/DD/YYYY'), '2812.85 in³', 130, 29, 10, 10, 10, 10)
SELECT * FROM DUAL;



--start repair from here 

INSERT ALL
    INTO Item VALUES (1, 13, TO_DATE('05/09/23', 'MM/DD/YY'), 'Coffee beans (different varieties)', 1, 1, 1, 1)
    INTO Item VALUES (2, 50, TO_DATE('07/15/23', 'MM/DD/YY'), 'Berylls Chocolate bar', 2, 2, 2, 2)
    INTO Item VALUES (3, 200, TO_DATE('03/28/23', 'MM/DD/YY'), 'Saji Flour', 3, 3, 3, 3)
    INTO Item VALUES (4, 40, TO_DATE('10/06/23', 'MM/DD/YY'), 'Sweeteners (sugar, honey, syrup)', 4, 4, 4, 4)
    INTO Item VALUES (5, 60, TO_DATE('01/21/23', 'MM/DD/YY'), 'FarmFresh Milk', 5, 5, 5, 5)
    INTO Item VALUES (6, 20, TO_DATE('09/13/23', 'MM/DD/YY'), 'Nutripluss Eggs', 6, 6, 6, 6)
    INTO Item VALUES (7, 800, TO_DATE('04/02/23', 'MM/DD/YY'), 'Nelson-Masssey vanilla', 7, 7, 7, 7)
    INTO Item VALUES (8, 140, TO_DATE('11/18/23', 'MM/DD/YY'), 'Anchr salted butter', 8, 8, 8, 8)
    INTO Item VALUES (9, 70, TO_DATE('06/30/23', 'MM/DD/YY'), 'Master cocoa powder', 9, 9, 9, 9)
    INTO Item VALUES (10, 35, TO_DATE('12/25/23', 'MM/DD/YY'), 'Tatura Cheese', 10, 10, 10, 10)
    INTO Item VALUES (11, 76, TO_DATE('07/01/23', 'MM/DD/YY'), 'Lemonade', 3, 3, 9, 9)
    INTO Item VALUES (12, 84, TO_DATE('02/14/23', 'MM/DD/YY'), 'Hot tea', 5, 4, 7, 4)
    INTO Item VALUES (13, 92, TO_DATE('03/22/23', 'MM/DD/YY'), 'Zuss Chocolate Frappe', 7, 7, 1, 1)
    INTO Item VALUES (14, 63, TO_DATE('04/01/23', 'MM/DD/YY'), 'Zuss Iced Americano', 2, 1, 3, 6)
    INTO Item VALUES (15, 75, TO_DATE('05/19/23', 'MM/DD/YY'), 'Zuss Hot Latte', 10, 4, 5, 8)
    INTO Item VALUES (16, 98, TO_DATE('06/08/23', 'MM/DD/YY'), 'Zuss Cheese Croissant', 5, 6, 3, 3)
    INTO Item VALUES (17, 56, TO_DATE('07/02/23', 'MM/DD/YY'), 'Berries cheese cake', 1, 2, 2, 6)
    INTO Item VALUES (18, 85, TO_DATE('08/16/23', 'MM/DD/YY'), 'Burnt Coffee cake', 4, 10, 8, 4)
    INTO Item VALUES (19, 67, TO_DATE('10/09/23', 'MM/DD/YY'), 'ZUSS Steel Straw', 6, 2, 3, 2)
    INTO Item VALUES (20, 91, TO_DATE('10/28/23', 'MM/DD/YY'), 'Burnt Cheese Cake', 8, 5, 9, 5)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Recipe VALUES (1, 'Pink Lemonade', 'lemon, lychee, soda water', 'Mix soda water with a liquid base (such as flavor syrups) until blend it well.', 6, 0, 'large cup', 'Kitchen utensils', 'Measure the flavor syrup accurately', TO_DATE('06/15/2020', 'MM/DD/YYYY'))
    INTO Recipe VALUES (2, 'Hot Green Tea Latte', 'milk, green tea', 'Mix hot water with the mixture of green tea and add on milk.', 8, 0, 'medium cup', 'Green tea mixer, Espresso machine', 'Can change milk based', TO_DATE('07/10/2021', 'MM/DD/YYYY'))
    INTO Recipe VALUES (3, 'Caramel Cream Frappe', 'milk, caramel syrup', 'Pour into a cup and top with whipped cream or other garnishes if desired.', 12, 0, 'large cup', 'Blender', 'Add on caramel drizzle', TO_DATE('12/29/2022', 'MM/DD/YYYY'))
    INTO Recipe VALUES (4, 'Iced Americano', 'espresso', 'Brew coffee using your preferred method and let it cool.', 4, 0, 'medium cup', 'Coffee grinder, Espresso machine', 'No syrup', TO_DATE('09/02/2019', 'MM/DD/YYYY'))
    INTO Recipe VALUES (5, 'Hot Cappuccino', 'milk, espresso', 'Add milk, cream, or sweeteners as desired.', 4, 0, 'large cup', 'Coffee grinder, Espresso machine', NULL, TO_DATE('09/03/2019', 'MM/DD/YYYY'))
    INTO Recipe VALUES (6, 'Chicken Curry Puff', 'chicken', 'Preheat the oven to the recommended temperature.', 2, 45, '1 piece', 'Kitchen utensils, Stove, Mixer, Microwave', 'Prepare utensils for customer', TO_DATE('09/04/2019', 'MM/DD/YYYY'))
    INTO Recipe VALUES (7, 'Summer Berries Cheese Cake', 'egg', 'Let the cake cool before frosting or serving.', 2, 72, '1 slice', 'Kitchen utensils, Mixer, Chiller', 'Use a clean plate', TO_DATE('01/08/2022', 'MM/DD/YYYY'))
    INTO Recipe VALUES (8, 'Iced Buttercreme Latte', 'milk', 'Add flavored syrups, such as caramel or vanilla, to the espresso.', 12, 45, 'large cup', 'Coffee grinder, Espresso machine, Mixer, Blender', NULL, TO_DATE('04/03/2023', 'MM/DD/YYYY'))
    INTO Recipe VALUES (9, 'Iced Velvet Crème Mocha', 'espresso, milk, caramel syrup', 'Heat milk on the stovetop or using a steam wand until hot but not boiling.', 10, 45, 'large cup', 'Coffee grinder, Espresso machine, Mixer, Blender', NULL, TO_DATE('04/03/2023', 'MM/DD/YYYY'))
    INTO Recipe VALUES (10, 'Classic Mac & Cheese', 'macaroni, cheese, chicken', 'Cook the mac & cheese gravy on the pan until fully cooked.', 12, 15, '1 plate', 'Kitchen utensils, Stove, Microwave', 'Extra gravy', TO_DATE('10/28/2022', 'MM/DD/YYYY'))
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Product VALUES (1, 11, 8.5, 'Non-coffee', '16oz', 9.90, '61 kcal', 'Y', 'A pink twist on our Signature ZUS Lemonade. Perfect for those who need a bit of bright colors in their life.', 'lemon, lychee, soda water', '2-3 days when stored refrigerated.', 1)
    INTO Product VALUES (2, 12, 5.6, 'Tea', '12oz', 9.70, '366kcal', 'Y', 'DID YOU KNOW? "Green Tea Latte contains no coffee. Green Tea Latte = Green Tea with Milk."', 'milk, green tea', '1-2 days when stored refrigerated.', 2)
    INTO Product VALUES (3, 13, 9, 'Zus Frappe', '16oz', 14.90, '376kcal', 'Y', 'FYI: Caramel is made by boiling sugar and it has been a popular sweet treat since the 17th century!', 'milk, caramel syrup', '6-12 months when stored in a cool and dry place.', 3)
    INTO Product VALUES (4, 14, 7.5, 'Iced Coffee', '12oz', 6.90, '21kcal', 'Y', 'ZUS Blend is a 100% Specialty Grade Arabica hand-crafted blend consisting of Brazil, Papua New Guinea & Indonesia Single Origin Beans.', 'espresso', '1-3 months when stored refrigerated.', 4)
    INTO Product VALUES (5, 15, 5.5, 'Hot Coffee', '16oz', 9.70, '270kcal', 'Y', 'With lesser milk & more foam, if you like your coffee strong, the Cappuccino is the way to go.', 'milk, espresso', 'Best when consumed immediately after preparation.', 5)
    INTO Product VALUES (6, 16, 6.4, 'Pastries', '75g', 3.90, '295kcal', 'N', 'The fragrant spices and herbs spice UP your day a little moreeee.', 'chicken', '1-3 days when stored at room temperature in airtight packaging.', 6)
    INTO Product VALUES (7, 17, 8.5, 'Cakes', '125g', 13.50, '284kcal', 'Y', 'Deck your summer table with one of our light & luscious berries cheesecake!', 'egg', '3-5 days when refrigerated in a covered container.', 7)
    INTO Product VALUES (8, 18, 7, 'Cakes', '200g', 10.90, '594kcal', 'Y', 'Disclaimer: Contains a small amount of caffeine & dairy ingredients. Kindly consume at your own risk.', 'milk', 'Best when consumed immediately after preparation.', 8)
    INTO Product VALUES (9, 19, 9, 'Merchandise', '150g', 13.80, null, 'N', 'Steel straw', null, 'wholeLife', null)
    INTO Product VALUES (10, 20, 4, 'Cakes', '300g', 12.90, '130kcal', 'Y', 'Creamy burnt cheesecakes for sweet tooth', 'cheese', '1-3 days when refrigerated and reheated properly before consumption.', 10)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO RawMaterial VALUES (1, 1, 'Grade A', 'Arabica Coffee', 'kg', 10, 'Premium Arabica Coffee Beans', 'Cool, dry place', 5, 100, 'Kapal Api',1)
    INTO RawMaterial VALUES (2, 2, 'Premium', 'Chocolate', 'kg', 5, 'Dark Chocolate', 'Cool, dry place', 2, 50, 'Beryl''s',2)
    INTO RawMaterial VALUES (3, 3, 'Grade B', 'Flour', 'kg', 20, 'All-Purpose Flour', 'Dry, airtight container', 10, 200, 'Massimo',3)
    INTO RawMaterial VALUES (4, 4, 'Extra Fine', 'Sugar', 'kg', 15, 'Cane Sugar', 'Dry, airtight container', 5, 100, 'Gula Prai',4)
    INTO RawMaterial VALUES (5, 5, 'Organic', 'Milk', 'liter', 10, 'Fresh Whole Milk', 'Refrigerated', 2, 20, 'Farm Fresh',5)
    INTO RawMaterial VALUES (6, 6, 'Grade A', 'Eggs', 'piece', 100, 'Fresh Chicken Eggs', 'Refrigerated', 50, 500, 'Happy Eggs',6)
    INTO RawMaterial VALUES (7, 7, 'Premium', 'Vanilla Extract', 'ml', 500, 'Pure Vanilla Extract', 'Cool, dark place', 100, 1000, 'Jati',7)
    INTO RawMaterial VALUES (8, 8, 'Grade A', 'Butter', 'kg', 5, 'Salted Butter', 'Refrigerated', 1, 50, 'Anchor',8)
    INTO RawMaterial VALUES (9, 9, 'Extra Fine', 'Cocoa Powder', 'kg', 2, 'Dutch Process Cocoa Powder', 'Cool, dry place', 1, 20, 'JB Cocoa',9)
    INTO RawMaterial VALUES (10, 10, 'Premium', 'Cream Cheese', 'kg', 2, 'Creamy Cheese Spread', 'Refrigerated', 1, 10, 'Emborg',10)
SELECT * FROm DUAL;

INSERT ALL 
    INTO MarketingProgram VALUES (1, 'Morning Brew', TO_DATE('07/01/2023', 'MM/DD/YYYY'), TO_DATE('07/31/2023', 'MM/DD/YYYY'), 'Start your day with our delightful coffee blends!', 'Social media, email marketing', 15000, 'Engagement rate, coupon redemptions', 'Morning commuters, office workers', '20% increase in coupon redemptions', 'Promote morning coffee specials and increase customer engagement', 1)
    INTO MarketingProgram VALUES (2, 'Seasonal Flavors', TO_DATE('09/15/2023', 'MM/DD/YYYY'), TO_DATE('12/31/2023', 'MM/DD/YYYY'), 'Experience the taste of the season with our...', 'In-store displays, social media', 7000, 'Sales, customer feedback', 'Coffee enthusiasts, flavor lovers', '15% increase in sales of seasonal flavors', 'Introduce new seasonal flavors and boost sales during specific periods', 2)
    INTO MarketingProgram VALUES (3, 'Loyalty Program', TO_DATE('01/01/2023', 'MM/DD/YYYY'), TO_DATE('12/31/2023', 'MM/DD/YYYY'), 'Join our loyalty program and enjoy exclusive...', 'Mobile app notifications, email marketing', 1500, 'Enrollment rate, repeat visits', 'Regular customers, coffee aficionados', '30% increase in loyalty program enrollment', 'Retain and incentivize existing customers through a loyalty program', 3)
    INTO MarketingProgram VALUES (4, 'Coffee Tasting Event', TO_DATE('06/15/2023', 'MM/DD/YYYY'), TO_DATE('06/16/2023', 'MM/DD/YYYY'), 'Explore a variety of coffee flavors at our...', 'Event marketing, social media', 50000, 'Event attendance, customer feedback', 'Coffee enthusiasts, local community', '200 attendees, positive customer feedback', 'Promote brand awareness and engage coffee lovers through a tasting event', 4)
    INTO MarketingProgram VALUES (5, 'Happy Hour Specials', TO_DATE('08/01/2023', 'MM/DD/YYYY'), TO_DATE('08/31/2023', 'MM/DD/YYYY'), 'Enjoy discounted prices on your favorite...', 'In-store signage, social media', 82075, 'Sales, customer satisfaction', 'Afternoon and evening customers', '10% increase in sales during happy hour', 'Drive foot traffic during slower hours and increase sales through happy hour promotions', 5)
    INTO MarketingProgram VALUES (6, 'Community Partnership', TO_DATE('11/01/2023', 'MM/DD/YYYY'), TO_DATE('11/30/2023', 'MM/DD/YYYY'), 'Partnering with the local community for...', 'Community engagement, social media', 4002, 'Brand visibility, community engagement', 'Local community, coffee lovers', 'Increased brand awareness and community engagement', 'Foster positive relationships with the local community', 6)
    INTO MarketingProgram VALUES (7, 'Social Media Contest', TO_DATE('10/01/2023', 'MM/DD/YYYY'), TO_DATE('10/31/2023', 'MM/DD/YYYY'), 'Participate in our contest and win free coffee!', 'Social media platforms', 3600, 'Engagement rate, participant count', 'Social media followers', '500 contest entries', 'Boost social media presence and engage with customers', 7)
    INTO MarketingProgram VALUES (8, 'Sustainable Coffee Initiative', TO_DATE('05/15/2023', 'MM/DD/YYYY'), TO_DATE('06/15/2023', 'MM/DD/YYYY'), 'Supporting fair trade and environmentally-friendly practices', 'Community outreach, website', 1500, 'Brand visibility, community engagement', 'Environmentally-conscious consumers', 'Increased awareness of sustainable coffee practices', 'Promote ethical and sustainable coffee sourcing and production', 8 )
    INTO MarketingProgram VALUES (9, 'Office Coffee Program', TO_DATE('02/01/2023', 'MM/DD/YYYY'), TO_DATE('12/31/2023', 'MM/DD/YYYY'), 'Supplying quality coffee to local offices', 'B2B sales, direct marketing', 12000, 'Client acquisition, satisfaction', 'Local businesses, offices', 'Secured contracts with 10 new offices', 'Provide coffee solutions for local businesses and increase revenue', 9)
    INTO MarketingProgram VALUES (10, 'Cold Brew Promotion', TO_DATE('07/15/2023', 'MM/DD/YYYY'), TO_DATE('07/31/2023', 'MM/DD/YYYY'), 'Beat the heat with our refreshing cold brew beverages!', 'In-store promotions, social media', 2000, 'Sales, customer feedback', 'Coffee lovers', '25% increase in cold brew sales', 'Drive sales and awareness for cold brew coffee offerings', 10)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Promotion VALUES (1, 'ZUS COFFEE X TNG Ewallet', 'Wake up and taste perfection with Zuss Coffee by using Ewallet', 'Collaboration promo', 'Use TNG Ewallet', 'ZCODE20', 0.5, 'Minimum purchase RM12', TO_DATE('10/06/22', 'MM/DD/YY'), TO_DATE('10/07/22', 'MM/DD/YY'), 'Ongoing', 500000, 1, 1, 1)
    INTO Promotion VALUES (2, 'VOTE DAY', 'Indulge in the rich flavors of Zuss Coffee on the vote day', 'Special day promo', 'Must voting', 'ZCODE21', 0.3, 'Applicable for pickup via ZUS App only', TO_DATE('03/14/21', 'MM/DD/YY'), TO_DATE('03/15/21', 'MM/DD/YY'), 'Finished', 100000, 2, 2, 2)
    INTO Promotion VALUES (3, 'ZUS COFFEE WORLD CUP 2022', 'Elevate your coffee game with Zuss', 'Special day promo', 'Vote winners', 'ZCODE22', 0.15, 'Buy any 1 item & get 15% off for the 2nd item', TO_DATE('11/25/23', 'MM/DD/YY'), TO_DATE('11/26/23', 'MM/DD/YY'), 'Finished', 75000, 3, 3, 3)
    INTO Promotion VALUES (4, 'KENANGAN MERDEKA', 'Remember Merdeka with the smoothness of Zuss Coffee', 'Special day promo', 'Post in Social media', 'ZCODE23', 0.2, 'Applicable for pickup via ZUS App only', TO_DATE('04/08/22', 'MM/DD/YY'), TO_DATE('04/09/22', 'MM/DD/YY'), 'Planning', 200000, 4, 4, 4)
    INTO Promotion VALUES (5, '40% OFF WITH BonusLink BLINK App', 'Grab your discount with BLINK App', 'Collaboration promo', 'Use BLINK App', 'ZCODE24', 0.1, 'Make a payment using BonusLink App', TO_DATE('01/17/23', 'MM/DD/YY'), TO_DATE('01/18/23', 'MM/DD/YY'), 'Ongoing', 180000, 5, 5, 5)
    INTO Promotion VALUES (6, 'BUY 1 FREE 1', 'Dont let your chance to experience the art of coffee with Zuss', 'Weekly promo', 'Buy drinks more than RM20', 'ZCODE25', 0.5, 'The lowest-price drink will be free', TO_DATE('08/03/21', 'MM/DD/YY'), TO_DATE('08/04/21', 'MM/DD/YY'), 'On-going', 300000, 6, 6, 6)
    INTO Promotion VALUES (7, 'BREKKIE COMBO', 'Take your combos now !', 'Special promo', 'Buy more than RM20', 'ZCODE26', 0.4, 'Applicable for delivery & pickup via ZUS App & foodpanda only', TO_DATE('12/29/22', 'MM/DD/YY'), TO_DATE('12/30/22', 'MM/DD/YY'), 'Ongoing', 150000, 7, 7, 7)
    INTO Promotion VALUES (8, 'RAMADAN SWEET DEAL', 'Start your Ramadan with the sweetness of Zuss Coffee', 'Special day promo', 'Ramadhan mission', 'ZCODE27', 0.15, 'Applicable for selected outlets only', TO_DATE('06/11/23', 'MM/DD/YY'), TO_DATE('06/12/23', 'MM/DD/YY'), 'Finished', 600000, 8, 8, 8)
    INTO Promotion VALUES (9, 'NEW MEMBER', 'Grab your voucher as the new member of Zuss Coffee now !', 'Special promo', 'Use Zuss Coffee App', 'ZCODE28', 0.2, 'New register for ZUS App', TO_DATE('09/02/21', 'MM/DD/YY'), TO_DATE('09/03/21', 'MM/DD/YY'), 'Ongoing', 450000, 9, 9, 9)
    INTO Promotion VALUES (10, '11.11 SALE OFFER', 'Get your offer now before it''s too late !', 'Weekly promo', 'Customer Loyalty', 'ZCODE29', 0.1, 'Each user is limited to one(1) time purchase only', TO_DATE('02/21/22', 'MM/DD/YY'), TO_DATE('02/22/22', 'MM/DD/YY'), 'Planning', 190000, 10, 10, 10)
SELECT 1 FROM DUAL;


INSERT ALL 
    INTO Sale VALUES(1, TO_DATE('24/1/2022', 'DD/MM/YYYY'), 'Unlimited', TO_TIMESTAMP('2023-06-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'eWallet user', 6.00, 'Month-wise sale', 10000, 'Completed', 120, 1, 1)
    INTO Sale VALUES(2, TO_DATE('19/11/2022', 'DD/MM/YYYY'), '1000', TO_TIMESTAMP('2023-07-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Malaysian who show their inked finger', 7.25, 'Promotional Campaign sale', 8000, 'InProgress', 80, 2, 2)
    INTO Sale VALUES(3, TO_DATE('18/12/2022', 'DD/MM/YYYY'), '400', TO_TIMESTAMP('2023-08-10 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 8.25, 'Customer Segmentation sale', 2500, 'Cancelled', 50, 3, 3)
    INTO Sale VALUES(4, TO_DATE('31/8/2022', 'DD/MM/YYYY'), '8200', TO_TIMESTAMP('2023-09-20 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'BLINK membership', 5.55, 'Online sale', 2000, 'Completed', 30, 4, 4)
    INTO Sale VALUES(5, TO_DATE('27/3/2023', 'DD/MM/YYYY'), '1000000', TO_TIMESTAMP('2023-10-05 11:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 1.00, 'Loyalty Program sale', 5000, 'Completed', 20, 5, 5)
    INTO Sale VALUES(6, TO_DATE('5/3/2023', 'DD/MM/YYYY'), '2000', TO_TIMESTAMP('2023-11-15 16:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 5.00, 'Product Category sale', 3400, 'Completed', 80, 6, 6)
    INTO Sale VALUES(7, TO_DATE('1/6/2023', 'DD/MM/YYYY'), '100', TO_TIMESTAMP('2023-12-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 4.00, 'Product Category sale', 8000, 'Completed', 70, 7, 7)
    INTO Sale VALUES(8, TO_DATE('20/3/2023', 'DD/MM/YYYY'), '200', TO_TIMESTAMP('2024-01-10 13:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 6.25, 'Year-over-Year sale', 30000, 'Completed', 67, 8, 8)
    INTO Sale VALUES (9, TO_DATE('12/12/2022', 'DD/MM/YYYY'), '1000000', TO_TIMESTAMP('2024-02-20 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 1.30, 'Loyalty Program sale', 50000, 'Completed', 87, 9, 9)
    INTO Sale VALUES(10, TO_DATE('11/11/2022', 'DD/MM/YYYY'), '5200', TO_TIMESTAMP('2024-03-05 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Everyone', 5.50, 'Daily Sale', 5000, 'Completed', 93, 10, 10)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Delivery VALUES (1, DATE '2023-05-09', TIMESTAMP '2023-05-09 17:50:00', 'Foodpanda', DATE '2023-05-09', 'Tell me when arrive', 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '010-3156915', 1, 1, 1, 1,1)
    INTO Delivery VALUES (2, DATE '2023-05-11', TIMESTAMP '2023-05-11 13:15:00', 'GrabFood', DATE '2023-05-11', 'Put in the security guard', 'Coffee Tin', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Pending', '010-2190196', 2, 2, 2, 2,2)
    INTO Delivery VALUES (3, DATE '2023-05-12', TIMESTAMP '2023-05-12 12:45:00', 'Foodpanda', DATE '2023-05-12', null, 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '016-5023086', 3, 3, 3, 3,3)
    INTO Delivery VALUES (4, DATE '2023-05-23', TIMESTAMP '2023-05-23 15:25:00', 'ShoppeeFood', DATE '2023-05-23', 'Tell me when arrive', 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '013-4934856', 4, 4, 4, 4,4)
    INTO Delivery VALUES (5, DATE '2023-05-14', TIMESTAMP '2023-05-14 17:50:00', 'GrabFood', DATE '2023-05-14', null, 'Coffee Tin', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Pending', '019-5617895', 5, 5, 5, 5,5)
    INTO Delivery VALUES (6, DATE '2023-05-15', TIMESTAMP '2023-05-15 20:10:00', 'ShoppeeFood', DATE '2023-05-15', null, 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Pending', '018-4684687', 6, 6, 6, 6,6)
    INTO Delivery VALUES (7, DATE '2023-05-26', TIMESTAMP '2023-05-26 19:30:00', 'Foodpanda', DATE '2023-05-26', 'Put in the security guard', 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '016-4973588', 7, 7, 7, 7,7)
    INTO Delivery VALUES (8, DATE '2023-05-17', TIMESTAMP '2023-05-17 14:45:00', 'GrabFood', DATE '2023-05-17', null, 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '010-8321015', 8, 8, 8, 8,8)
    INTO Delivery VALUES (9, DATE '2023-05-08', TIMESTAMP '2023-05-08 21:15:00', 'ShoppeeFood', DATE '2023-05-08', null, 'Coffee Tin', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Completed', '018-4203508', 9, 9, 9, 9,9)
    INTO Delivery VALUES (10, DATE '2023-05-19', TIMESTAMP '2023-05-19 20:00:00', 'GrabFood', DATE '2023-05-19', null, 'Eco-Friendly', 'Refund Policy, Incorrect Order Policy, Customer Satisfaction Guarantee', 'Pending', '010-5023648', 10, 10, 10, 10,10)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO "Transaction" VALUES (1, TIMESTAMP '2023-01-06 13:00:00', 'Wholesale', 'RM', '450040164041', '649201373018', 'Credit card', 'Completed', 1, 30000, 1, 1, 1, 1, 1,1)
    INTO "Transaction" VALUES (2, TIMESTAMP '2023-01-28 08:30:00', 'Purchase', 'RM', '140067845102', '3764819027', 'Credit card', 'Completed', 0.5, 2000, 2, 2, 2, 2, 2,2)
    INTO "Transaction" VALUES (3, TIMESTAMP '2023-03-03 15:00:00', 'Dropshipping', 'RM', '130440480416', '92710932730', 'Debit card', 'Completed', 2, 7, 3, 3, 3, 3, 3,3)
    INTO "Transaction" VALUES (4, TIMESTAMP '2023-02-15 12:00:00', 'Wholesale', 'RM', '548412680047', '1087283702', 'Credit card', 'Completed', 1.5, 11, 4, 4, 4, 4, 4,4)
    INTO "Transaction" VALUES (5, TIMESTAMP '2023-02-25 11:45:00', 'Wholesale', 'RM', '650000489814', '10381981363', 'Debit card', 'Completed', 3, 20, 5, 5, 5, 5, 5,5)
    INTO "Transaction" VALUES (6, TIMESTAMP '2023-03-04 16:00:00', 'Stock', 'RM', '234044000117', '198320827', 'Debit card', 'Completed', 2.5, 4000, 6, 6, 6, 6, 6,6)
    INTO "Transaction" VALUES (7, TIMESTAMP '2023-03-16 10:20:00', 'Purchase', 'RM', '590000970707', '1893626392', 'Debit card', 'Completed', 6, 35, 7, 7, 7, 7, 7,7)
    INTO "Transaction" VALUES (8, TIMESTAMP '2023-04-10 14:00:00', 'Dropshipping', 'RM', '866840100134', '1093728482', 'Islamic banking', 'Completed', 6, 300, 8, 8, 8, 8, 8,8)
    INTO "Transaction" VALUES (9, TIMESTAMP '2023-05-12 09:00:00', 'Stock', 'RM', '785610012105', '1837209371', 'Credit card', 'Pending', 6, 14, 9, 9, 9, 9, 9,9)
    INTO "Transaction" VALUES (10, TIMESTAMP '2023-05-29 13:00:00', 'Wholesale', 'RM', '567904490001', '19839361276', 'Debit card', 'Pending', 6, 340, 10, 10, 10, 10, 10,10)
SELECT 1 FROM DUAL;




INSERT ALL
    INTO "Feedback" VALUES (1, 'A Flawless Coffee Experience: Superb Taste and Exceptional Service', TO_DATE('4/25/2022', 'MM/DD/YYYY'), 'Absolutely Amazing Coffee! The flavors are rich and distinct. The ordering process was seamless, and my order arrived on time. I''m a happy customer!', 5, 'Received', 'Thank you for your feedback!', 'General feedback', 'Online', 'https://example.com/feedback/image1.jpg', 1, 1, 1, 1, 1, 1)
    INTO "Feedback" VALUES (2, 'Disappointed with the Coffee Quality: Lacked Flavor and Freshness', TO_DATE('15/7/2019', 'DD/MM/YYYY'), 'Disappointed with the coffee quality. It lacked the promised flavor profile and freshness. I expected better based on the company''s reputation.', 3, 'Under consideration', 'We apologize for the inconvenience you experienced.', 'Product Quality', 'Online', 'https://example.com/feedback/image2.jpg', 2, 2, 2, 2, 2, 2)
    INTO "Feedback" VALUES (3, 'Delighted with Every Sip: Perfectly Brewed Coffee Delivered with Care', TO_DATE('21/1/2022', 'DD/MM/YYYY'), 'I''m thrilled with the coffee subscription service. Every month, I receive a selection of unique and delicious coffees. It''s a delightful surprise, and the quality is consistently excellent.', 4, 'Closed', 'Thank you for taking the time to provide feedback.', 'Service experience', 'Online', 'https://example.com/feedback/image3.jpg', 3, 3, 3, 3, 3, 3)
    INTO "Feedback" VALUES (4, 'Exceeded Expectations: Rich Flavor, Timely Delivery, and Excellent Packaging', TO_DATE('31/12/2021', 'DD/MM/YYYY'), 'Kudos to the customer support team! They promptly resolved an issue with my order and provided exceptional service. The coffee itself is outstanding, and I highly recommend this company.', 5, 'Escalated', 'Thank you for your feedback!', 'Product Quality', 'Mail', 'https://example.com/feedback/image4.jpg', 4, 4, 4, 4, 4, 4)
    INTO "Feedback" VALUES (5, 'Delayed Delivery and Damaged Packaging: A Frustrating Experience', TO_DATE('5/3/2023', 'DD/MM/YYYY'), 'The order arrived late, and the packaging was damaged. The customer service response was slow, and the overall experience was disappointing.', 2, 'Resolved', 'We apologize for the delay in service.', 'Waiting time', 'Online', 'https://example.com/feedback/image5.jpg', 5, 5, 5, 5, 5, 5)
    INTO "Feedback" VALUES (6, 'Inaccurate Order: Received the Wrong Coffee Blend', TO_DATE('4/6/2023', 'DD/MM/YYYY'), 'Received the wrong coffee blend in my order. The error caused inconvenience, and it took several attempts to get in touch with customer support for resolution.', 3, 'Closed', 'Thank you for bringing this matter to our attention.', 'Service experience', 'Physical', 'https://example.com/feedback/image6.jpg', 6, 6, 6, 6, 6, 6)
    INTO "Feedback" VALUES (7, 'Coffee Bliss: Unforgettable Aroma and Smooth Customer Experience', TO_DATE('8/7/2021', 'DD/MM/YYYY'), 'I''m impressed with the eco-friendly packaging used for my coffee order. The company''s commitment to sustainability is commendable, and the coffee tastes fantastic!', 4.5, 'Closed', 'Thank you for taking the time to provide feedback.', 'General feedback', 'Online', 'https://example.com/feedback/image7.jpg', 7, 7, 7, 7, 7, 7)
    INTO "Feedback" VALUES (8, 'Unresponsive Customer Support: Poor Communication and Issue Resolution', TO_DATE('11/22/2019', 'MM/DD/YYYY'), 'Overpriced for the quality received. The coffee didn''t meet my expectations in terms of taste and value. I won''t be ordering again.', 3.5, 'In progress', 'We''re sorry that our product did not meet your expectations.', 'Service experience', 'Online', 'https://example.com/feedback/image8.jpg', 8, 8, 8, 8, 8, 8)
    INTO "Feedback" VALUES (9, 'Subpar Taste and Overpriced: Not Worth the Hype or Expense', TO_DATE('9/18/2022', 'MM/DD/YYYY'), 'The customer support team was unhelpful and unresponsive. I encountered an issue with my order and struggled to get assistance. The lack of communication was frustrating.', 1, 'Escalated', 'We apologize for the misunderstanding and any inconvenience caused.', 'Pricing and value for money', 'Online', 'https://example.com/feedback/image9.jpg', 9, 9, 9, 9, 9, 9)
    INTO "Feedback" VALUES (10, 'A Coffee Lover''s Paradise: Outstanding Quality and Seamless Ordering Process', TO_DATE('4/13/2021', 'MM/DD/YYYY'), 'The coffee arrived fresh, and the aroma was captivating. The packaging was visually appealing, and the taste surpassed my expectations. This is my new go-to coffee brand!', 4.5, 'Closed', 'We''re glad to hear that you enjoyed your visit to our coffee shop!', 'General feedback', 'Mail', 'https://example.com/feedback/image10.jpg', 10, 10, 10, 10, 10, 10)
SELECT * FROM DUAL;

--data for EXPLOSION


INSERT ALL
    INTO Address_Person VALUES ('wanemir69@gmail.com', 1)
    INTO Address_Person VALUES ('aminah08@gmail.com', 2)
    INTO Address_Person VALUES ('harris89@gmail.com', 3)
    INTO Address_Person VALUES ('zariff13@gmail.com', 20)
    INTO Address_Person VALUES ('nayli47@gmail.com', 5)
    INTO Address_Person VALUES ('zulamzar43@gmail.com', 6)
    INTO Address_Person VALUES ('chua45@gmail.com', 4)
    INTO Address_Person VALUES ('jarinah12@gmail.com', 7)
    INTO Address_Person VALUES ('adamfeb28@gmail.com', 8)
    INTO Address_Person VALUES ('fasya51@gmail.com', 9)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Customer_Product VALUES (1, 4)
    INTO Customer_Product VALUES (2, 1)
    INTO Customer_Product VALUES (3, 8)
    INTO Customer_Product VALUES (3, 7)
    INTO Customer_Product VALUES (4, 10)
    INTO Customer_Product VALUES (5, 2)
    INTO Customer_Product VALUES (5, 8)
    INTO Customer_Product VALUES (7, 9)
    INTO Customer_Product VALUES (9, 9)
    INTO Customer_Product VALUES (10, 3)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Customer_Sale VALUES (1, 7)
    INTO Customer_Sale VALUES (2, 3)
    INTO Customer_Sale VALUES (5, 6)
    INTO Customer_Sale VALUES (5, 8)
    INTO Customer_Sale VALUES (5, 1)
    INTO Customer_Sale VALUES (7, 7)
    INTO Customer_Sale VALUES (8, 10)
    INTO Customer_Sale VALUES (8, 2)
    INTO Customer_Sale VALUES (9, 5)
    INTO Customer_Sale VALUES (10, 9)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Product_Sale VALUES (1, 6)
    INTO Product_Sale VALUES (2, 3)
    INTO Product_Sale VALUES (3, 10)
    INTO Product_Sale VALUES (4, 7)
    INTO Product_Sale VALUES (7, 9)
    INTO Product_Sale VALUES (7, 1)
    INTO Product_Sale VALUES (8, 5)
    INTO Product_Sale VALUES (8, 3)
    INTO Product_Sale VALUES (9, 2)
    INTO Product_Sale VALUES (10, 1)
SELECT 1 FROM DUAL;


INSERT ALL 
    INTO Employee_Supplier VALUES (1, 3)
    INTO Employee_Supplier VALUES (2, 5)
    INTO Employee_Supplier VALUES (3, 5)
    INTO Employee_Supplier VALUES (5, 3)
    INTO Employee_Supplier VALUES (5, 7)
    INTO Employee_Supplier VALUES (7, 9)
    INTO Employee_Supplier VALUES (8, 1)
    INTO Employee_Supplier VALUES (8, 10)
    INTO Employee_Supplier VALUES (9, 2)
    INTO Employee_Supplier VALUES (10, 7)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Employee_Vehicle VALUES (2, 1)
    INTO Employee_Vehicle VALUES (3, 1)
    INTO Employee_Vehicle VALUES (4, 8)
    INTO Employee_Vehicle VALUES (5, 4)
    INTO Employee_Vehicle VALUES (5, 10)
    INTO Employee_Vehicle VALUES (6, 1)
    INTO Employee_Vehicle VALUES (7, 9)
    INTO Employee_Vehicle VALUES (8, 3)
    INTO Employee_Vehicle VALUES (9, 5)
    INTO Employee_Vehicle VALUES (10, 9)
SELECT 1 FROM DUAL;

INSERT ALL 
    INTO Employee_Item VALUES (1, 15)
    INTO Employee_Item VALUES (2, 18)
    INTO Employee_Item VALUES (3, 8)
    INTO Employee_Item VALUES (4, 11)
    INTO Employee_Item VALUES (6, 1)
    INTO Employee_Item VALUES (7, 15)
    INTO Employee_Item VALUES (7, 8)
    INTO Employee_Item VALUES (8, 19)
    INTO Employee_Item VALUES (9, 7)
    INTO Employee_Item VALUES (10, 20)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO Employee_Product VALUES (1, 10)
    INTO Employee_Product VALUES (1, 9)
    INTO Employee_Product VALUES (3, 5)
    INTO Employee_Product VALUES (4, 2)
    INTO Employee_Product VALUES (4, 4)
    INTO Employee_Product VALUES (5, 7)
    INTO Employee_Product VALUES (8, 10)
    INTO Employee_Product VALUES (8, 5)
    INTO Employee_Product VALUES (9, 1)
    INTO Employee_Product VALUES (10, 3)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Employee_MarketingProgram VALUES (3, 1)
    INTO Employee_MarketingProgram VALUES (5, 5)
    INTO Employee_MarketingProgram VALUES (6, 10)
    INTO Employee_MarketingProgram VALUES (10, 9)
    INTO Employee_MarketingProgram VALUES (4, 7)
    INTO Employee_MarketingProgram VALUES (6, 8)
    INTO Employee_MarketingProgram VALUES (8, 1)
    INTO Employee_MarketingProgram VALUES (4, 5)
    INTO Employee_MarketingProgram VALUES (3, 3)
    INTO Employee_MarketingProgram VALUES (1, 10)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Employee_Recipe VALUES (1, 8)
    INTO Employee_Recipe VALUES (1, 7)
    INTO Employee_Recipe VALUES (3, 10)
    INTO Employee_Recipe VALUES (4, 5)
    INTO Employee_Recipe VALUES (5, 9)
    INTO Employee_Recipe VALUES (5, 6)
    INTO Employee_Recipe VALUES (8, 1)
    INTO Employee_Recipe VALUES (9, 4)
    INTO Employee_Recipe VALUES (10, 4)
    INTO Employee_Recipe VALUES (10, 3)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Employee_Training VALUES (1, 8)
    INTO Employee_Training VALUES (3, 10)
    INTO Employee_Training VALUES (4, 1)
    INTO Employee_Training VALUES (5, 4)
    INTO Employee_Training VALUES (5, 2)
    INTO Employee_Training VALUES (6, 2)
    INTO Employee_Training VALUES (7, 6)
    INTO Employee_Training VALUES (7, 9)
    INTO Employee_Training VALUES (9, 1)
    INTO Employee_Training VALUES (10, 10)
SELECT 1 FROM DUAL;



INSERT ALL
    INTO Department_Branch VALUES (1, 3)
    INTO Department_Branch VALUES (1, 2)
    INTO Department_Branch VALUES (2, 9)
    INTO Department_Branch VALUES (4, 5)
    INTO Department_Branch VALUES (5, 2)
    INTO Department_Branch VALUES (6, 1)
    INTO Department_Branch VALUES (7, 10)
    INTO Department_Branch VALUES (9, 5)
    INTO Department_Branch VALUES (9, 10)
    INTO Department_Branch VALUES (10, 4)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Promotion_Branch VALUES (1, 4)
    INTO Promotion_Branch VALUES (2, 9)
    INTO Promotion_Branch VALUES (2, 6)
    INTO Promotion_Branch VALUES (3, 7)
    INTO Promotion_Branch VALUES (3, 1)
    INTO Promotion_Branch VALUES (4, 4)
    INTO Promotion_Branch VALUES (4, 9)
    INTO Promotion_Branch VALUES (5, 10)
    INTO Promotion_Branch VALUES (8, 2)
    INTO Promotion_Branch VALUES (9, 5)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO MarketingProgram_Branch VALUES (1, 4)
    INTO MarketingProgram_Branch VALUES (1, 5)
    INTO MarketingProgram_Branch VALUES (2, 6)
    INTO MarketingProgram_Branch VALUES (3, 4)
    INTO MarketingProgram_Branch VALUES (4, 9)
    INTO MarketingProgram_Branch VALUES (4, 2)
    INTO MarketingProgram_Branch VALUES (7, 10)
    INTO MarketingProgram_Branch VALUES (8, 3)
    INTO MarketingProgram_Branch VALUES (8, 10)
    INTO MarketingProgram_Branch VALUES (10, 8)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Promotion_Product VALUES (1, 6)
    INTO Promotion_Product VALUES (3, 1)
    INTO Promotion_Product VALUES (3, 5)
    INTO Promotion_Product VALUES (4, 10)
    INTO Promotion_Product VALUES (4, 8)
    INTO Promotion_Product VALUES (5, 3)
    INTO Promotion_Product VALUES (5, 4)
    INTO Promotion_Product VALUES (7, 2)
    INTO Promotion_Product VALUES (10, 4)
    INTO Promotion_Product VALUES (10, 6)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Vehicle_Transaction VALUES (1, 10)
    INTO Vehicle_Transaction VALUES (2, 1)
    INTO Vehicle_Transaction VALUES (3, 6)
    INTO Vehicle_Transaction VALUES (4, 5)
    INTO Vehicle_Transaction VALUES (5, 7)
    INTO Vehicle_Transaction VALUES (7, 4)
    INTO Vehicle_Transaction VALUES (8, 3)
    INTO Vehicle_Transaction VALUES (8, 2)
    INTO Vehicle_Transaction VALUES (9, 3)
    INTO Vehicle_Transaction VALUES (10, 8)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO RawMaterial_Recipe VALUES (1, 4)
    INTO RawMaterial_Recipe VALUES (2, 3)
    INTO RawMaterial_Recipe VALUES (4, 7)
    INTO RawMaterial_Recipe VALUES (4, 10)
    INTO RawMaterial_Recipe VALUES (4, 8)
    INTO RawMaterial_Recipe VALUES (5, 6)
    INTO RawMaterial_Recipe VALUES (7, 9)
    INTO RawMaterial_Recipe VALUES (8, 6)
    INTO RawMaterial_Recipe VALUES (9, 1)
    INTO RawMaterial_Recipe VALUES (10, 5)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Inventory_Supplier VALUES (1, 9)
    INTO Inventory_Supplier VALUES (2, 4)
    INTO Inventory_Supplier VALUES (3, 1)
    INTO Inventory_Supplier VALUES (3, 8)
    INTO Inventory_Supplier VALUES (4, 7)
    INTO Inventory_Supplier VALUES (6, 4)
    INTO Inventory_Supplier VALUES (7, 5)
    INTO Inventory_Supplier VALUES (8, 6)
    INTO Inventory_Supplier VALUES (10, 6)
    INTO Inventory_Supplier VALUES (10, 3)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Inventory_Shipment VALUES (1, 10)
    INTO Inventory_Shipment VALUES (1, 4)
    INTO Inventory_Shipment VALUES (2, 9)
    INTO Inventory_Shipment VALUES (3, 1)
    INTO Inventory_Shipment VALUES (4, 5)
    INTO Inventory_Shipment VALUES (4, 8)
    INTO Inventory_Shipment VALUES (5, 2)
    INTO Inventory_Shipment VALUES (6, 4)
    INTO Inventory_Shipment VALUES (8, 6)
    INTO Inventory_Shipment VALUES (10, 2)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Inventory_Vehicle VALUES (1, 6)
    INTO Inventory_Vehicle VALUES (1, 2)
    INTO Inventory_Vehicle VALUES (2, 4)
    INTO Inventory_Vehicle VALUES (2, 7)
    INTO Inventory_Vehicle VALUES (5, 8)
    INTO Inventory_Vehicle VALUES (6, 1)
    INTO Inventory_Vehicle VALUES (8, 10)
    INTO Inventory_Vehicle VALUES (9, 8)
    INTO Inventory_Vehicle VALUES (10, 6)
    INTO Inventory_Vehicle VALUES (10, 5)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Delivery_Item VALUES (1, 10)
    INTO Delivery_Item VALUES (2, 13)
    INTO Delivery_Item VALUES (2, 2)
    INTO Delivery_Item VALUES (3, 19)
    INTO Delivery_Item VALUES (5, 1)
    INTO Delivery_Item VALUES (6, 5)
    INTO Delivery_Item VALUES (7, 15)
    INTO Delivery_Item VALUES (7, 16)
    INTO Delivery_Item VALUES (9, 14)
    INTO Delivery_Item VALUES (10, 16)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Inventory_Sale VALUES (1, 5)
    INTO Inventory_Sale VALUES (2, 6)
    INTO Inventory_Sale VALUES (3, 10)
    INTO Inventory_Sale VALUES (4, 4)
    INTO Inventory_Sale VALUES (4, 7)
    INTO Inventory_Sale VALUES (5, 2)
    INTO Inventory_Sale VALUES (6, 3)
    INTO Inventory_Sale VALUES (9, 5)
    INTO Inventory_Sale VALUES (10, 10)
    INTO Inventory_Sale VALUES (10, 1)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Item_Transaction VALUES (1, 7)
    INTO Item_Transaction VALUES (1, 3)
    INTO Item_Transaction VALUES (3, 10)
    INTO Item_Transaction VALUES (4, 2)
    INTO Item_Transaction VALUES (11, 8)
    INTO Item_Transaction VALUES (11, 4)
    INTO Item_Transaction VALUES (15, 9)
    INTO Item_Transaction VALUES (16, 1)
    INTO Item_Transaction VALUES (19, 3)
    INTO Item_Transaction VALUES (20, 8)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Address_Branch VALUES (2, 3)
    INTO Address_Branch VALUES (5, 6)
    INTO Address_Branch VALUES (5, 2)
    INTO Address_Branch VALUES (6, 4)
    INTO Address_Branch VALUES (10, 7)
    INTO Address_Branch VALUES (10, 1)
    INTO Address_Branch VALUES (16, 7)
    INTO Address_Branch VALUES (17, 10)
    INTO Address_Branch VALUES (19, 8)
    INTO Address_Branch VALUES (20, 10)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Address_Supplier VALUES (1, 1)
    INTO Address_Supplier VALUES (2, 3)
    INTO Address_Supplier VALUES (2, 9)
    INTO Address_Supplier VALUES (4, 10)
    INTO Address_Supplier VALUES (6, 10)
    INTO Address_Supplier VALUES (10, 4)
    INTO Address_Supplier VALUES (12, 5)
    INTO Address_Supplier VALUES (13, 8)
    INTO Address_Supplier VALUES (17, 5)
    INTO Address_Supplier VALUES (17, 1)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Address_Inventory VALUES (1, 5)
    INTO Address_Inventory VALUES (2, 4)
    INTO Address_Inventory VALUES (4, 4)
    INTO Address_Inventory VALUES (8, 8)
    INTO Address_Inventory VALUES (10, 1)
    INTO Address_Inventory VALUES (10, 6)
    INTO Address_Inventory VALUES (11, 1)
    INTO Address_Inventory VALUES (13, 10)
    INTO Address_Inventory VALUES (15, 2)
    INTO Address_Inventory VALUES (17, 3)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Applicant_Application VALUES (1, 3)
    INTO Applicant_Application VALUES (2, 4)
    INTO Applicant_Application VALUES (3, 10)
    INTO Applicant_Application VALUES (4, 2)
    INTO Applicant_Application VALUES (4, 8)
    INTO Applicant_Application VALUES (5, 7)
    INTO Applicant_Application VALUES (6, 4)
    INTO Applicant_Application VALUES (9, 10)
    INTO Applicant_Application VALUES (10, 1)
    INTO Applicant_Application VALUES (10, 9)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Delivery_Transaction VALUES (1, 7)
    INTO Delivery_Transaction VALUES (1, 9)
    INTO Delivery_Transaction VALUES (3, 8)
    INTO Delivery_Transaction VALUES (4, 3)
    INTO Delivery_Transaction VALUES (5, 10)
    INTO Delivery_Transaction VALUES (6, 3)
    INTO Delivery_Transaction VALUES (8, 2)
    INTO Delivery_Transaction VALUES (9, 1)
    INTO Delivery_Transaction VALUES (10, 4)
    INTO Delivery_Transaction VALUES (10, 10)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO MarketingProgram_Sale VALUES (1, 1)
    INTO MarketingProgram_Sale VALUES (1, 9)
    INTO MarketingProgram_Sale VALUES (2, 10)
    INTO MarketingProgram_Sale VALUES (4, 2)
    INTO MarketingProgram_Sale VALUES (5, 5)
    INTO MarketingProgram_Sale VALUES (5, 10)
    INTO MarketingProgram_Sale VALUES (6, 3)
    INTO MarketingProgram_Sale VALUES (6, 4)
    INTO MarketingProgram_Sale VALUES (7, 4)
    INTO MarketingProgram_Sale VALUES (7, 6)
SELECT 1 FROM DUAL;



INSERT ALL
    INTO Transaction_Shipment VALUES (1, 10)
    INTO Transaction_Shipment VALUES (2, 9)
    INTO Transaction_Shipment VALUES (2, 7)
    INTO Transaction_Shipment VALUES (4, 4)
    INTO Transaction_Shipment VALUES (4, 6)
    INTO Transaction_Shipment VALUES (5, 1)
    INTO Transaction_Shipment VALUES (6, 4)
    INTO Transaction_Shipment VALUES (7, 8)
    INTO Transaction_Shipment VALUES (9, 2)
    INTO Transaction_Shipment VALUES (10, 1)
SELECT 1 FROM DUAL;


INSERT ALL
    INTO Procurement_Supplier VALUES (1, 2)
    INTO Procurement_Supplier VALUES (2, 4)
    INTO Procurement_Supplier VALUES (3, 3)
    INTO Procurement_Supplier VALUES (3, 9)
    INTO Procurement_Supplier VALUES (4, 3)
    INTO Procurement_Supplier VALUES (6, 5)
    INTO Procurement_Supplier VALUES (8, 1)
    INTO Procurement_Supplier VALUES (9, 5)
    INTO Procurement_Supplier VALUES (10, 1)
    INTO Procurement_Supplier VALUES (10, 6)
SELECT 1 FROM DUAL;


