---Example to execute --> '@C:\Users\LENOVO\Documents\ADS\assignment1\ZUS_create.sql'
--just example path to execute script
--drop table code 
@@ZUS_drop.sql

--create table  code

CREATE TABLE Person (
    Per_email VARCHAR(255) NOT NULL PRIMARY KEY ,
    Per_firstname VARCHAR(50),
    Per_middleName VARCHAR(50),
    Per_lastname VARCHAR(50),
    Per_phoneNum VARCHAR(20),
    Per_gender VARCHAR(10),
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
    Cust_usageTime TIMESTAMP,
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
  E_performanceEvaluation NUMBER,
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
  Application_Time VARCHAR2(50),
  Application_Availability VARCHAR2(100),
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
  Proc_batch VARCHAR2(50),
  Proc_date DATE,
  Proc_item VARCHAR2(100),
  Proc_budget NUMBER,
  Proc_method VARCHAR2(50),
  Proc_approvalstatus VARCHAR2(50),
  Proc_remarks VARCHAR2(255),
  Proc_totalCost NUMBER,
  E_ID INT,
  B_ID INT,
  S_ID INT,
  CONSTRAINT fk_Proc_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Proc_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Proc_Supplier FOREIGN KEY (S_ID) REFERENCES Supplier (S_ID)
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
  R_ServingSize NUMBER,
  R_tools VARCHAR2(255),
  R_remarks VARCHAR2(255),
  R_dateCreated DATE
);
CREATE TABLE Product (
  P_ID INT NOT NULL PRIMARY KEY,
  Itm_ID INT,
  P_rating NUMBER,
  P_category VARCHAR2(100),
  P_weight NUMBER,
  P_retailPrice NUMBER,
  P_nutritionInfo VARCHAR2(255),
  P_availability VARCHAR2(50),
  P_description VARCHAR2(255),
  P_allergenInfo VARCHAR2(255),
  P_shelfLife NUMBER,
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
  Rm_minimumQuantity NUMBER,
  CONSTRAINT fk_Rm_Item FOREIGN KEY (Itm_ID) REFERENCES Item (Itm_ID)
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
  promo_status VARCHAR2(50),
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
  Promo_ID INT,
  Proc_ID INT,
  S_ID INT,
  CONSTRAINT fk_Trans_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Trans_Employee FOREIGN KEY (E_ID) REFERENCES Employee (E_ID),
  CONSTRAINT fk_Trans_Promotion FOREIGN KEY (Promo_ID) REFERENCES Promotion (Promo_ID),
  CONSTRAINT fk_Trans_Procurement FOREIGN KEY (Proc_ID) REFERENCES Procurement (Proc_ID),
  CONSTRAINT fk_Trans_Supplier FOREIGN KEY (S_ID) REFERENCES Supplier (S_ID)
);

CREATE TABLE Delivery (
  Dlvr_ID INT PRIMARY KEY,
  Dlvr_date DATE,
  Dlvr_time TIMESTAMP,
  Dlvr_method VARCHAR2(50),
  Dlvr_eta DATE,
  Dlvr_notes VARCHAR2(255),
  Dlvr_packagingdetails VARCHAR2(255),
  Dlvr_dimensions VARCHAR2(100),
  Dlvr_details VARCHAR2(255),
  Dlvr_contact VARCHAR2(100),
  A_ID INT,
  Cust_ID INT,
  Vec_ID INT,
  B_ID INT,
  CONSTRAINT fk_Dlvr_Address FOREIGN KEY (A_ID) REFERENCES Address (A_ID),
  CONSTRAINT fk_Dlvr_Customer FOREIGN KEY (Cust_ID) REFERENCES Customer (Cust_ID),
  CONSTRAINT fk_Dlvr_Vehicle FOREIGN KEY (Vec_ID) REFERENCES Vehicle (Vec_ID),
  CONSTRAINT fk_Dlvr_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID)
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
  Dlvr_ID INT,
  B_ID INT,
  Trans_refnum INT,
  Promo_ID INT,
  CONSTRAINT fk_Sale_Delivery FOREIGN KEY (Dlvr_ID) REFERENCES Delivery (Dlvr_ID),
  CONSTRAINT fk_Sale_Branch FOREIGN KEY (B_ID) REFERENCES Branch (B_ID),
  CONSTRAINT fk_Sale_Transaction FOREIGN KEY (Trans_refnum) REFERENCES "Transaction" (Trans_refnum),
  CONSTRAINT fk_Sale_Promotion FOREIGN KEY (Promo_ID) REFERENCES Promotion (Promo_ID)
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
SELECT 1 FROM DUAL;

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
SELECT 1 FROM DUAL;


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
SELECT 1 FROM DUAL;


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
SELECT 1 FROM DUAL;

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
SELECT 1 FROM DUAL;

