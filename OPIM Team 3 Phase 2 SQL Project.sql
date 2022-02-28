                                                             --OPIM 5272 PROJECT TEAM 3 Phase 2--
                                                             

--Deleting tables before, if they already existed before
    DROP TABLE Clients CASCADE CONSTRAINT;
    DROP TABLE Request CASCADE CONSTRAINT;
    DROP TABLE Request_Tracker CASCADE CONSTRAINT;
    DROP TABLE Operational_Manager CASCADE CONSTRAINT;
    DROP TABLE Employee CASCADE CONSTRAINT;
    DROP TABLE Campaign_Team CASCADE CONSTRAINT;
    DROP TABLE Social_Media_Handler CASCADE CONSTRAINT;    
    DROP TABLE Web_Developer CASCADE CONSTRAINT;
    DROP TABLE Content_Writer CASCADE CONSTRAINT;
    DROP TABLE Graphic_Designer CASCADE CONSTRAINT;
    DROP TABLE Deliverable CASCADE CONSTRAINT;
    DROP TABLE Evaluations CASCADE CONSTRAINT;


-- 1. Creation /DDL for Table Client

    CREATE TABLE Clients 
        ( 
         Client_ID Number (6) NOT NULL, 
         Client_Name VARCHAR (25 Byte) NOT NULL,  
         Client_Emailing_Address CHAR (30 Byte)
        ) LOGGING 
    ;
COMMENT ON COLUMN Clients.Client_ID IS 'Primary key of Clients table.' 
;

COMMENT ON COLUMN Clients.Client_Name IS ' Name of the Client' 
;

COMMENT ON COLUMN Clients.Client_Emailing_Address IS 'Email of the client where daily converstions happen.' 
;
    
    ALTER TABLE Clients 
        ADD CONSTRAINT PK_Client_ID PRIMARY KEY ( Client_ID ) ;


-- 2. Creation /DDL for Table Request

    
    CREATE TABLE Request 
        ( 
         Client_Request_ID Number (12) NOT NULL,
         Client_ID Number (6) NOT NULL, 
         Operational_Manager_ID Number (12) NOT NULL, 
         Is_Approved Char (1 BYTE) NOT NULL
        ) LOGGING 
    ;
COMMENT ON COLUMN Request.Client_Request_ID IS 'Primary key of Request table.This table consists of information where request history is tracked-basically whether the request is approved or not,etc' 
;

COMMENT ON COLUMN Request.Client_ID IS ' Foreign key of the request table referencing client table.' 
;

COMMENT ON COLUMN Request.Operational_Manager_ID IS 'Foreign Key of the request table referencing Operational Manager table. ' 
;

COMMENT ON COLUMN Request.Is_Approved IS 'It is the column which tells whether the request was approved or not. It includes value in BINARY  - Either Y means yes or N means no. ' 
; 
    
    ALTER TABLE Request 
        ADD CONSTRAINT PK_Client_Request_ID PRIMARY KEY ( Client_Request_ID ) ;
        
    ALTER TABLE Request 
        ADD CONSTRAINT FK_Client_ID FOREIGN KEY ( Client_ID ) REFERENCES Clients ( Client_ID ) NOT DEFERRABLE;
    
    --add this after operational manager table
    --ALTER TABLE Request 
      --  ADD CONSTRAINT FK_Operational_Manager_ID FOREIGN KEY ( Operational_Manager_ID ) REFERENCES Operational_Manager ( Operational_Manager_ID ) NOT DEFERRABLE;
        
-- 3. Creation /DDL for Table Request_Tracker
    
    
    CREATE TABLE Request_Tracker 
        ( 
         Tracking_ID Number (13) NOT NULL,
         Request_ID Number (12) NOT NULL,
         Request_Stage VARCHAR (30 BYTE), 
         Request_Stage_Timestamp TIMESTAMP NOT NULL  
        ) LOGGING 
    ;
COMMENT ON COLUMN Request_Tracker.Tracking_ID IS 'Primary key of Request_Tracker table.This table consists of the timestamp to help prioritise and track the request when or at what stage the request is currently at.' 
;

COMMENT ON COLUMN Request_Tracker.Request_ID IS ' Foreign key of the request_tracker table referencing to the Request table.' 
;

COMMENT ON COLUMN Request_Tracker.Request_Stage IS 'Foregn Key of the request table referencing Operational Manager table. ' 
;

COMMENT ON COLUMN Request_Tracker.Request_Stage_Timestamp IS 'Column tells at what specific time the request was made ' 
;     
    ALTER TABLE Request_Tracker 
        ADD CONSTRAINT PK_Tracking_ID PRIMARY KEY ( Tracking_ID ) ;
        
    ALTER TABLE Request_Tracker 
        ADD CONSTRAINT FK_Request_ID FOREIGN KEY ( Request_ID ) REFERENCES Request ( Client_Request_ID ) NOT DEFERRABLE;
            
-- 4. Creation /DDL for Table Operational_Manager
    
    
    CREATE TABLE Operational_Manager 
        ( 
         Operational_Manager_ID Number (12) NOT NULL, 
         Manager_Name CHAR (25 Byte) NOT NULL,  
         Email VARCHAR (30 Byte),
         Contact CHAR (10 Byte)
        ) LOGGING 
    ;
COMMENT ON COLUMN Operational_Manager.Operational_Manager_ID IS 'Primary key of Operational_Manager table.'
;

COMMENT ON COLUMN Operational_Manager.Manager_name IS ' Column consists of name of the Operational managers of the company.' 
;

COMMENT ON COLUMN Operational_manager.Email IS 'Consist of Operational Manager Email IDS ' 
;

COMMENT ON COLUMN Operational_Manager.Contact IS 'Column consist of contact of the Operational Managers ' 
;     
    ALTER TABLE Operational_Manager 
        ADD CONSTRAINT PK_Operational_Manager_ID PRIMARY KEY ( Operational_Manager_ID ) ;
    
    ALTER TABLE Request 
        ADD CONSTRAINT FK_Operational_Manager_ID FOREIGN KEY ( Operational_Manager_ID ) REFERENCES Operational_Manager ( Operational_Manager_ID ) NOT DEFERRABLE;    
-- 5. Creation /DDL for Table Employee

    
    CREATE TABLE Employee 
        ( 
        Employee_ID Number (8) NOT NULL,
        Employee_Name VARCHAR (20 BYTE) NOT NULL,
        Team_ID CHAR (10 Byte) NOT NULL, 
        Operational_Manager_ID Number (12) NOT NULL,
        Shift_Type CHAR (1 BYTE)
        ) LOGGING 
    ;
COMMENT ON COLUMN Employee.Employee_ID IS 'Primary key of Employee table.'
;

COMMENT ON COLUMN Employee.Employee_Name IS ' Column consists of name of the employees of the company.' 
;

COMMENT ON COLUMN Employee.Team_ID IS 'Is the foreign key of the Employee table which refers to Camapaign Team table. It consist of Team number the employee is usually part of. The value is contained in Char datatype with a #sign in the beginning ' 
;

COMMENT ON COLUMN Employee.Operational_Manager_ID IS 'Is the foreign key of the Employee table which refers to the Operational Manager table.Column gives the operational manager ID assigned to the employee)' 
;

COMMENT ON COLUMN Employee.Shift_Type IS 'Column tells about the type of shift the employee has. It can be either Morning(M), Evening(E) or Night(N)' 
;
    
ALTER TABLE Employee 
        ADD CONSTRAINT PK_Employee_ID PRIMARY KEY ( Employee_ID ) ;
ALTER TABLE Employee 
        ADD CONSTRAINT FK_Operational_Manager_ID_CF FOREIGN KEY ( Operational_Manager_ID ) REFERENCES Operational_Manager ( Operational_Manager_ID ) NOT DEFERRABLE;     
--Run the after campaign team table
--ALTER TABLE Employee 
  --      ADD CONSTRAINT FK_Team_ID_CF FOREIGN KEY ( Team_ID ) REFERENCES Campaign_Team ( Team_ID ) NOT DEFERRABLE;     
    


-- 6. Creation /DDL for Table Campaign_Team

    
    CREATE TABLE Campaign_Team 
        ( 
         Team_ID CHAR (10 Byte) NOT NULL, 
         Campaign_Team_Size Number (7) ,
         Project_Name CHAR (20 Byte)
        ) LOGGING 
    ;
COMMENT ON COLUMN Campaign_Team.Team_ID IS 'Primary key of the Camapign Team table.'
;

COMMENT ON COLUMN Campaign_Team.Campaign_Team_Size IS 'Column tells about the number of employees or team members in the particular team ' 
;

COMMENT ON COLUMN Campaign_Team.Project_Name IS 'It includes the field of the project or the name of the specific project the team is working on' 
;    
    ALTER TABLE Campaign_Team 
        ADD CONSTRAINT PK_Team_ID PRIMARY KEY ( Team_ID ) ;
ALTER TABLE Employee 
        ADD CONSTRAINT FK_Team_ID_CF FOREIGN KEY ( Team_ID ) REFERENCES Campaign_Team ( Team_ID ) NOT DEFERRABLE;         
    
-- 7. Creation /DDL for Table Social_Media_Handler
    
    
   CREATE TABLE Social_Media_Handler 
        (
        Employee_Code CHAR(1) NOT NULL,
        Employee_ID NUMBER (8) NOT NULL,
        Employee_Name CHAR (20) NOT NULL,
        Tools CHAR (80),
        Skills CHAR (80)
        ) LOGGING
        ;
COMMENT ON COLUMN Social_Media_Handler.Employee_Code IS 'Contains the specific code which along with Employee_ID acts as the composite primary key of the table. All the codes for this table is S'
;

COMMENT ON COLUMN Social_Media_Handler.Employee_ID IS 'The foreign key of the Social Media Handler table which refers to the Employee table. It along with Employee Code acts as the Primary Key of this table' 
;

COMMENT ON COLUMN Social_Media_Handler.Employee_name IS  'Contains name of the employee' 
;   

COMMENT ON COLUMN Social_Media_Handler.Tools IS  'Tools the employee works on or has the expertise in.' 
;  

COMMENT ON COLUMN Social_Media_Handler.Skills IS  'Tell the skills the particular employee has for which he has been chosen for the task.' 
;  
    ALTER TABLE Social_Media_Handler 
        ADD CONSTRAINT PK_S_CODE_ID PRIMARY KEY (Employee_Code, Employee_ID) ;
        
    ALTER TABLE Social_Media_Handler 
        ADD CONSTRAINT FK_S_Employee_ID FOREIGN KEY ( Employee_ID ) REFERENCES Employee ( Employee_ID ) NOT DEFERRABLE;
        
-- 8. Creation /DDL for Table Web_Developer
    
    
    CREATE TABLE Web_Developer 
      (
        Employee_Code CHAR(5 BYTE) NOT NULL,
        Employee_ID Number (8) NOT NULL,
        Employee_Name CHAR (25 BYTE) NOT NULL,
        Tools CHAR (80),
        Skills CHAR (80)
        ) LOGGING 
    ;
COMMENT ON COLUMN Web_Developer.Employee_Code IS 'Contains the specific code which along with Employee_ID acts as the composite primary key of the table. All the codes for this table is W'
;

COMMENT ON COLUMN Web_Developer.Employee_ID IS 'The foreign key of the Web Developer table which refers to the Employee table. It along with Employee Code acts as the Primary Key of this table' 
;

COMMENT ON COLUMN Web_Developer.Employee_name IS  'Contains name of the employee' 
;   

COMMENT ON COLUMN Web_Developer.Tools IS  'Tools the employee works on or has the expertise in.' 
;  

COMMENT ON COLUMN Web_Developer.Skills IS  'Tell the skills the particular employee has for which he has been chosen for the task.' 
;     
    ALTER TABLE Web_Developer 
        ADD CONSTRAINT PK_W_Code_ID PRIMARY KEY (Employee_Code,Employee_ID ) ;
        
    ALTER TABLE Web_Developer 
        ADD CONSTRAINT FK_W_Employee_ID FOREIGN KEY ( Employee_ID ) REFERENCES Employee ( Employee_ID ) NOT DEFERRABLE;
        
-- 9. Creation /DDL for Table Content_Writer 

    
    CREATE TABLE Content_Writer 
      (
        Employee_Code CHAR(5 BYTE) NOT NULL,
        Employee_ID Number (8) NOT NULL,
        Employee_Name CHAR (25 BYTE) NOT NULL,
        Tools CHAR (80),
        Skills CHAR (80)
        ) LOGGING 
    ;

COMMENT ON COLUMN Content_Writer.Employee_Code IS 'Contains the specific code which along with Employee_ID acts as the composite primary key of the table. All the codes for this table is C'
;

COMMENT ON COLUMN Content_Writer.Employee_ID IS 'The foreign key of the Content Writer table which refers to the Employee table. It along with Employee Code acts as the Primary Key of this table' 
;

COMMENT ON COLUMN Content_Writer.Employee_name IS  'Contains name of the employee' 
;   

COMMENT ON COLUMN Content_Writer.Tools IS  'Tools the employee works on or has the expertise in.' 
;  

COMMENT ON COLUMN Content_Writer.Skills IS  'Tell the skills the particular employee has for which he has been chosen for the task.' 
;
    
    ALTER TABLE Content_Writer 
        ADD CONSTRAINT PK_C_Code_ID PRIMARY KEY ( Employee_Code, Employee_ID ) ;
    
    ALTER TABLE Content_Writer 
        ADD CONSTRAINT FK_C_Employee_ID FOREIGN KEY ( Employee_ID ) REFERENCES Employee ( Employee_ID ) NOT DEFERRABLE;
            
-- 10. Creation /DDL for Table Graphic_Designer 
    
    
    CREATE TABLE Graphic_Designer 
        (
        Employee_Code CHAR(5 BYTE) NOT NULL,
        Employee_ID Number (8) NOT NULL,
        Employee_Name CHAR (25 BYTE) NOT NULL,
        Tools CHAR (80),
        Skills CHAR (80)
        ) LOGGING 
    ;
COMMENT ON COLUMN Graphic_Designer.Employee_Code IS 'Contains the specific code which along with Employee_ID acts as the composite primary key of the table. All the codes for this table is G'
;

COMMENT ON COLUMN Graphic_Designer.Employee_ID IS 'The foreign key of the Graphic Designer table which refers to the Employee table. It along with Employee Code acts as the Primary Key of this table' 
;

COMMENT ON COLUMN Graphic_Designer.Employee_name IS  'Contains name of the employee' 
;   

COMMENT ON COLUMN Graphic_Designer.Tools IS  'Tools the employee works on or has the expertise in.' 
;  

COMMENT ON COLUMN Graphic_Designer.Skills IS  'Tell the skills the particular employee has for which he has been chosen for the task.'  
;

ALTER TABLE Graphic_Designer 
        ADD CONSTRAINT PK_G_Code_ID PRIMARY KEY ( Employee_Code, Employee_ID ) ;
        
ALTER TABLE Graphic_Designer 
        ADD CONSTRAINT FK_G_Employee_ID FOREIGN KEY ( Employee_ID ) REFERENCES Employee ( Employee_ID ) NOT DEFERRABLE;
          
          
-- 11. Creation /DDL for Table Deliverable
    
    CREATE TABLE Deliverable 
        ( 
         Deliverable_ID Number (8) NOT NULL, 
         Client_ID Number (6) NOT NULL,
         Team_ID CHAR (10) NOT NULL,
         Request_ID Number (12) NOT NULL,
         Scheduled_Post_Date Date,
         Actual_Post_Date Date,
         Deliverable_Type CHAR (50 BYTE) NOT NULL,
         Employee_ID Number (8) NOT NULL,
         Deliverable_Platform CHAR (30 BYTE),
         Promotion_Type CHAR (1 BYTE),
         Promotion_Cost Number (6),
         Is_Approved CHAR (1 BYTE)NOT NULL
        ) LOGGING 
    ;
COMMENT ON COLUMN Deliverable.Deliverable_ID IS 'Deliverable_ID is the primary key of the Deliverable table'
;

COMMENT ON COLUMN Deliverable.Client_ID IS 'The foreign key of the Deliverable table which refers to the Client table from where the campaign request came from.' 
;

COMMENT ON COLUMN Deliverable.Team_ID IS  'The foreign key of the Deliverable table which refers to the Campaign Team table which tells about the team that has been working on this deliverable.' 
;   

COMMENT ON COLUMN Deliverable.Request_ID IS  'The foreign key of the Deliverable table which refers to the request ID table in order to include the request type and time of the deliverable.' 
;  

COMMENT ON COLUMN Deliverable.Scheduled_Post_Date IS  'Column gives the target date of the particular deliverable for which it was decided to be posted.'  
;

COMMENT ON COLUMN Deliverable.Actual_Post_Date IS 'Column gives the actual date of the particular deliverable completed.'
;

COMMENT ON COLUMN Deliverable.Deliverable_Type IS 'The column includes what kind of deliverable is required. Whether it goes on a social media,is a blog, design, website, android app etc. ' 
;

COMMENT ON COLUMN Deliverable.Employee_ID IS  'The foreign key of the Deliverable table which refers to the Employee table.' 
;   

COMMENT ON COLUMN Deliverable.Deliverable_Platform IS  'The column tells what kind of platform is used for the particular deliverable. E.g. if the deliverable type is social media, the column will include entries like facebook, instagram, youtube, twitter etc. depending upon the particular deliverable' 
;  

COMMENT ON COLUMN Deliverable.Promotion_Type IS  'Includes whether the Promotion is Inorganic(I) that means paid or Organic(O) without any promotion.'  
;

COMMENT ON COLUMN Deliverable.Promotion_Cost IS  'The value is contained in Dollar units. If the Promotion Type is Organic then it will be 0 or null otherwise it will contain a numeric value.'  
;

COMMENT ON COLUMN Deliverable.Is_Approved IS  'Column gives information whether the Deliverable was Accpeted(Y) or Rejected(N) by the client'  
;


    ALTER TABLE Deliverable 
        ADD CONSTRAINT PK_Deliverable_ID PRIMARY KEY ( Deliverable_ID ) ;
    
    ALTER TABLE Deliverable 
        ADD CONSTRAINT FK_Client_ID_DF  FOREIGN KEY ( Client_ID ) REFERENCES Clients ( Client_ID ) NOT DEFERRABLE;
    
    ALTER TABLE Deliverable 
        ADD CONSTRAINT FK_Team_ID_DF  FOREIGN KEY ( Team_ID ) REFERENCES Campaign_Team ( Team_ID ) NOT DEFERRABLE;
    
    ALTER TABLE Deliverable 
        ADD CONSTRAINT FK_Request_ID_DF  FOREIGN KEY ( Request_ID ) REFERENCES Request ( Client_Request_ID ) NOT DEFERRABLE;
    
    ALTER TABLE Deliverable 
        ADD CONSTRAINT FK_Employee_ID_DF FOREIGN KEY ( Employee_ID ) REFERENCES Employee ( Employee_ID ) NOT DEFERRABLE;
    
-- 12. Creation /DDL for Table Evaluation
    
    
    CREATE TABLE Evaluations 
        ( 
         Evaluation_ID CHAR (8) NOT NULL,
         Deliverable_ID Number (8) NOT NULL,
         Report_Type CHAR (10 BYTE) NOT NULL,
         Likes Number (10) NOT NULL,
         Shares Number (10) NOT NULL,
         Comments CHAR (500 BYTE) NOT NULL,
         Reach Number (15),
         Lead_Conversions Number (8)
        ) LOGGING 
    ;
 
COMMENT ON COLUMN Evaluations.Evaluation_ID IS 'Evaluation_ID is the primary key of the Evaluations table'
;

COMMENT ON COLUMN Evaluations.Deliverable_ID IS 'The foreign key of the Evaluations table which refers to the Deliverble table.' 
;

COMMENT ON COLUMN Evaluations.Report_Type IS  'This column tell values whether the report shared is digitally or through paper' 
;   

COMMENT ON COLUMN Evaluations.Likes IS  'Number of Likes if applicable, a particular deliverable has.' 
;  

COMMENT ON COLUMN Evaluations.Shares IS  'Number of Shares if applicable, a particular deliverable has.'  
;   

COMMENT ON COLUMN Evaluations.Comments IS  'Comments on the evaluation while analysing the reports along with feedback from the employees, operational manager,and clients'  
;  

COMMENT ON COLUMN Evaluations.Reach IS  'reach a particular deliverable has depending upon its type.'  
;  

COMMENT ON COLUMN Evaluations.Lead_Conversions IS  'Number of leads that were actually converted.'  
;  
    ALTER TABLE Evaluations 
        ADD CONSTRAINT PK_Evaluation_ID_EP PRIMARY KEY ( Evaluation_ID ) ;
        
    ALTER TABLE Evaluations 
        ADD CONSTRAINT FK_Deliverable_ID  FOREIGN KEY ( Deliverable_ID ) REFERENCES Deliverable ( Deliverable_ID ) NOT DEFERRABLE;


-- -- Inserting Values in Clients Table

INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000001, 'Manisha Kharche', 'manisha.kharche@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000002, 'Sahibpreet Singh', 'sahibpreetkakkar@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000003, 'Kavisree Mariappan', 'kavisree.mariappan@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000004, 'Hassan Kani', 'hassan.kani@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000005, 'Nandan Adlakha', 'nandan.adlakha@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000006, 'Aishwary Bodhale', 'aishwary.bodhale@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000007, 'Bhavya Bansal', 'bhavya.bansal@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000008, 'Abhinav Dubey', 'abhinav.dubey@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000009, 'Himanshu Dubey', 'himanshu.dubey@gmail.com');
INSERT INTO Clients ( Client_ID, Client_Name, Client_Emailing_Address )
                   VALUES ( 000010, 'Mayank Patidar', 'mayank.patidar@gmail.com');                   
                   
                   
                    
                               
                   
Select * from clients;   

-- Inserting Values in Operational Manager Table

INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0110454, 'Charles_Andy_Edwards','charles.edwards@gmail.com', '8602345670');
INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0110515, 'Shakeel_Saleem','shakeel.saleem@gmail.com', '8602224578');
INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0110299, 'Karishma_Ramchandani','karishma.ramchandani@gmail.com', '8600003829');
INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0110999, 'Zackery_Tefteller','teftellers_zack@gmail.com', '8604440002');
INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0110645, 'Anna_Radziwillowicz','anna.radziwillowicz@uconn.edu', '8602394682');
INSERT INTO Operational_Manager ( Operational_Manager_ID, Manager_Name, Email, Contact )
                   VALUES ( 0120777, 'Pankaj_Prakash','pankaj.prakash@uconn.edu', '8602103859');
                   
select * from Operational_Manager;


-- Inserting Values in Request Table

INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 101, 000001, 0110454, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 102, 000002, 0110454, 'N');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 103, 000003, 0110454, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 104, 000004, 0110515, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 105, 000005, 0110515, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 106, 000006, 0110999, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 107, 000007, 0110999, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 108, 000008, 0110645, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 109, 000009, 0120777, 'Y');
INSERT INTO Request ( Client_Request_ID, Client_ID, Operational_Manager_ID, Is_Approved )
                   VALUES ( 110, 000010, 0120777, 'Y');                   

select * from Request;


-- Inserting Values in Request_Tracker Table
    
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9000, 101, 'Initialize', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9010, 102, 'Campaign_Revise', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9020, 103, 'Designing', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9030, 104, 'Posting', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9040, 105, 'Content_Creation', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9050, 106, 'Reporting', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9060, 107, 'Initialize', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9070, 108, 'Initialize', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9080, 109, 'Sharing', CURRENT_TIMESTAMP);
INSERT INTO Request_Tracker ( Tracking_ID,Request_ID, Request_Stage, Request_Stage_Timestamp )
                   VALUES ( 9090, 110, 'Paid_Promotions', CURRENT_TIMESTAMP);
                   
select * from Request_Tracker;

-- Inserting Values in Campaign_Team Table

INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#123',10, 'Restaurants');
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#124',5, 'Cryptocurrency');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#125',3, 'Fashion');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#126',2, 'Politics');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#127',1, 'Furniture');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#128',10, 'Manufacturers');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#129',8, 'Construction');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#130',3, 'Clothing');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#131',7, 'Shoes');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#132',10, 'Liquor_and_Wine');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#133',11, 'Brand_Building');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#134',3, '3D_Workshops');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#135',5, 'Startup_Event');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#136',5, 'Mobile_Launch');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#137',4, 'Nyce_Startup');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#138',7, 'Car_Showroon');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#139',2, 'Celebrating_Startups');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#140',8, 'Cafe_Opening');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#141',5, 'Diwali_Discount');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#142',4, '2022_Sports_Cup');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#143',4, 'Crypto_Launch');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#144',6, 'Summer_After_Sale');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#145',9, 'Tastesutra');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#146',2, 'Evening_at_Elgin');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#147',6, 'Singing_with_Stars');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#148',6, 'Gameboy');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#149',8, 'Shakes_For_Life');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#150',5, 'Amritsar_Founders');  
INSERT INTO Campaign_Team (Team_ID, Campaign_Team_Size, Project_Name)
                   VALUES ( '#151',10, 'ScifiEvents');
                  
select * from Campaign_Team;


-- Inserting Values in Employee Table


INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000015,'Shashank_Malready', '#151',0110454, 'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000014,'Sukhmani_Jolly', '#124',0120777, 'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000013,'Simran_Kaur', '#123',0110999, 'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000012,'Sonu_Kumar', '#126',0110454, 'E');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000011,'Gundeep_Wadhawan', '#151',0120777, 'E');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000010,'Saloni_Verma', '#144',0110515, 'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000009,'Harry_Dhillon', '#134',0110999, 'E');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000008,'Satinder_Singh', '#143',0110515, 'E');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000007,'Raghav_Khanna', '#134',0110515, 'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000006,'Anurag_Byala', '#124',0110515, 'E');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000005,'Ragghav_Aggarwal', '#127',0110299, 'N');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000004,'Amit_Madaan', '#127',0110299, 'N');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000003,'Mandeep_Kaur_Sidhu', '#128',0110999, 'N');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000002,'Gaganpreet_Singh', '#141', 0110645,'M');
INSERT INTO Employee (Employee_ID, Employee_Name, Team_ID,Operational_Manager_ID, Shift_Type)
                   VALUES ( 10000001,'Rouble_Tuli', '#144',0110645, 'E');
                   
select * from Employee;




-- Inserting Values in Social_media_Handler Table

INSERT INTO Social_Media_Handler (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('S',10000001,'Rouble_Tuli', 'Facebook Analytics, Instagram Analytics', 'Reach Analyst, Creates Reports');
INSERT INTO Social_Media_Handler (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('S',10000002,'Gaganpreet_Singh', 'Hubspot,Constant Contact, Mailchimp', 'Email Marketing');
INSERT INTO Social_Media_Handler (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('S',10000003,'Mandeep_Kaur_Sidhu', 'Semrush,Buffer', 'SEO(Search Engine Optimization)');
INSERT INTO Social_Media_Handler (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('S',10000004,'Amit_Madaan', 'Google Analytics,Semrush,Generate Reports', 'Running Ads,Marketing Analyst');
INSERT INTO Social_Media_Handler (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('S',10000005,'Ragghav_Aggarwal', 'Hootsuite,Agorapulse,Social Sprout', 'Posting on Social Media, handling Clients,Report Creation');
        
select * from Social_Media_Handler;

-- Inserting Values in Web Developer Table

INSERT INTO Web_Developer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('W',10000006,'Anurag_Byala', 'PHP', 'Web Developer');
INSERT INTO Web_Developer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('W',10000007,'Raghav_Khanna', 'CSS', 'Proper Working of the Website');
INSERT INTO Web_Developer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('W',10000008,'Satinder_Singh', 'CSS,Javascript', 'Web Development');
INSERT INTO Web_Developer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('W',10000009,'Harry_Dhillon', 'Sitespect,Mixpanel,Crazyegg,Hotjar', 'A/B Testing');
INSERT INTO Web_Developer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('W',10000010,'Saloni_Verma', 'Wordpress,SEO Yoast', 'SEO and Keyword Active Website');
        
select * from Web_Developer;  

-- Inserting Values in Content_Writer Table

INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000002,'Gaganpreet_Singh', 'Agorapulse', 'Content Research and Writing');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000003,'Mandeep_Kaur_Sidhu', 'Social Sprout', 'CRM, Blog Writing');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000005,'Ragghav_Aggarwal', 'Scoop.it', 'Web and Graphic Content');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000007,'Raghav_Khanna', 'Feedly', 'Food Content');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000009,'Harry_Dhillon', 'Medium,Feedly', 'Daily Blogs and Politics');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000011,'Gundeep_Wadhawan', 'GetPocket.com', 'Tech savy Content');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000013,'Simran_Kaur', 'Scribly.io', 'Crypto, Stock and Banking');
INSERT INTO Content_Writer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('C',10000015,'Shashank_Malready', 'Pearl Trees', 'SEO pecific content writing');                   
        
select * from Content_Writer; 

-- Inserting Values in Graphic_Designer Table

INSERT INTO Graphic_Designer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('G',10000011,'Gundeep_Wadhawan', 'Photoshop, Canva', 'SM Basic and Complex graphic designing');
INSERT INTO Graphic_Designer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('G',10000012,'Sonu_Kumar', 'Corel Draw', 'Brochure, pamphlet, hardcopy designing');
INSERT INTO Graphic_Designer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('G',10000013,'Simran_Kaur', 'Photoshop, Adobe Illustrator,Corel Draw', 'Experience graphic desgning,web designing templates');
INSERT INTO Graphic_Designer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('G',10000014,'Sukhmani_Jolly', 'Photoshop, Adobe Effects, Adobe Illustrator', 'SM experienced GD, Video and Motion Designer');
INSERT INTO Graphic_Designer (Employee_Code, Employee_ID, Employee_Name, Tools, Skills)
                   VALUES ('G',10000015,'Shashank_Malready', 'Canva', 'Basic Social Media Creatives');
        
select * from Graphic_Designer;  


-- Inserting Values in Deliverabale Table

INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50000,000001, '#125', 101, TO_DATE('03/03/2021','DD/MM/YYYY'), SYSDATE,'Social Media',10000015,'Facebook','O',0,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50001,000002, '#126', 102, TO_DATE('03/04/2021','DD/MM/YYYY'), SYSDATE,'Website',10000014,'Wix','I',500,'N');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50002,000003, '#127', 103, TO_DATE('03/05/2021','DD/MM/YYYY'), SYSDATE,'Pamphlets',10000013,'Paper','O',0,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50003,000004, '#128', 104, TO_DATE('03/06/2021','DD/MM/YYYY'), SYSDATE,'Mobile Development',10000012,'java','O',0,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50004,000005, '#129', 105, TO_DATE('03/07/2021','DD/MM/YYYY'), SYSDATE,'Website',10000011,'Wordpress','I',1000,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50005,000006, '#130', 106, TO_DATE('03/08/2021','DD/MM/YYYY'), SYSDATE,'Social Media',10000010,'Instagram','I',3000,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50006,000007, '#131', 107, TO_DATE('13/07/2021','DD/MM/YYYY'), SYSDATE,'Social Media',10000009,'Youtube','I',1500,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50007,000008, '#132', 108, TO_DATE('07/09/2021','DD/MM/YYYY'), SYSDATE,'Social Media',10000008,'Twitter','O',0,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50008,000009, '#133', 109, TO_DATE('27/03/2021','DD/MM/YYYY'), SYSDATE,'Social Media',10000007,'Linkedin','O',0,'Y');
                   INSERT INTO Deliverable (Deliverable_ID, Client_ID, Team_ID, Request_ID, Scheduled_Post_Date, Actual_Post_Date, Deliverable_Type, Employee_ID,Deliverable_Platform,Promotion_Type,Promotion_Cost,Is_Approved)
                   VALUES (50009,000010, '#134', 110, TO_DATE('27/03/2021','DD/MM/YYYY'), SYSDATE,'Blogs',10000006,'Wordpress','O',0,'Y');
                   
select * from Deliverable;

-- Inserting Values in Evaluation Table
INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11111',50000,'Electronic', 500000,189,'Goal Achieved, client happy and looks to extend work',600000, 30 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11112',50001,'Electronic', 5000,19,'Basic Goal Achieved but not satisfactory, conversions could have been more',600, 3 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11113',50002,'Paper', 0,0,'Client happy with designs but want different color variation',0, 90 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11114',50003,'Electronic', 30000,110,'Client unsatisfied, but budget must be increased for better results',56666, 79 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11115',50004,'Paper', 5000000,500,'Benchmark results for the company',3000000, 6567 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11116',50005,'Paper', 2000,189,'Great Improvement from last time',5000, 26 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11117',50006,'Electronic', 45000,309,'Better results required',600000, 390 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11118',50007,'Electronic', 500000,189,'Target Achieved',90000, 30 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11119',50008,'Electronic', 5000,11,'Basic Goal Achieved, client input required',900, 2 ); 
                   INSERT INTO Evaluations (Evaluation_ID, Deliverable_ID, Report_Type, Likes, Shares, Comments, Reach, Lead_Conversions)
                   VALUES ('WOA11120',50009,'Electronic', 500000,189,'Basic Goal Achieved but not satisfactory',600000, 30 ); 
select * from Evaluations;            


-- Report 1 - 
-- create a report to find the total promotion cost, the likes and shares for every platform. 
-- Also find the cost of promotion per like and cost of promotion per share

select 
Deliverable_platform
, sum(promotion_cost) total_promotion_cost
, sum(likes) total_likes
, sum(shares) total_shares
, case 
    when sum(promotion_cost) = 0 or sum(likes) = 0 then 0
    else sum(promotion_cost)/sum(likes)
  end as promotion_cost_per_like
, case 
    when sum(promotion_cost) = 0 or sum(shares) = 0 then 0
    else sum(promotion_cost)/sum(shares)
  end as promotion_cost_per_shares
from 
    Evaluations a
inner join 
deliverable b
on a.deliverable_id = b.deliverable_id
having sum(likes) > 0 
and sum(shares) > 0
group by 
Deliverable_platform
; 

-- Report 2 - 
-- Create a report to summarize the status of all the requests in the Request tracker
-- The report should summarize the numbers by approval status of the request
select 
    request_stage
    , count(*) requests
    , count(case when b.is_approved = 'Y' then 1 else null end) as approved_projects
    , count(case when b.is_approved = 'N' then 1 else null end) as rejected_projects
from    
    request_tracker a
inner join 
    request b 
on a.request_id = b.client_request_id
group by 
request_stage;

-- Report 3
-- Create a report of employees, showing their a list of all the tools the employee has knowledge about
select 
a.employee_id
, a.employee_name 
, nvl(b.tools, '-') as grpahic_designing_tools
, nvl(c.tools, '-') as content_writing_tools
, nvl(d.tools, '-') as social_media_tools
, nvl(e.tools, '-') as web_handling_tools
from 
employee a
left join 
graphic_designer b
on a.employee_id = b.employee_id
left join 
content_writer c
on a.employee_id = c.employee_id
left join 
social_media_handler d
on a.employee_id = d.employee_id
left join
web_developer e
on a.employee_id = e.employee_id;

-- Create a report of teams and number of employes by shift time
-- Report 4
select
Team_id
, count(distinct (case when shift_type = 'M' then 1 else null end)) Morning_shift_employees
, count(distinct (case when shift_type = 'E' then 1 else null end)) Evening_shift_employees
from employee b
group by 
Team_id;


-- Report 5 
-- create a summary of the deliverables by the deliverable type  by month of the year. 
select 
EXTRACT(month FROM scheduled_post_date) as month_year
, deliverable_type 
, count(*) as deliverable
from 
deliverable
group by
EXTRACT(month FROM scheduled_post_date)
, deliverable_type ;