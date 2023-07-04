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
    Cust_usageTime INT,
    Cust_rewards DECIMAL(10, 2),
    Cust_loyalty DECIMAL(10, 2),
    Cust_totalPurchase DECIMAL(10, 2),
    Cust_points INT,
    Cust_username VARCHAR(50),
    Cust_membership VARCHAR(50),
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
