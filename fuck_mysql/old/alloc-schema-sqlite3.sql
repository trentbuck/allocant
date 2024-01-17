CREATE TABLE product (
  productID INTEGER PRIMARY KEY,
  productName TEXT NOT NULL,
  sellPrice INTEGER,
  sellPriceCurrencyTypeID TEXT NOT NULL,
  sellPriceIncTax BOOLEAN NOT NULL DEFAULT 0,
  description TEXT,
  comment text,
  productActive BOOLEAN NOT NULL DEFAULT 1);


----------------------------------------------------------------------

CREATE TABLE tf (
  tfID INTEGER NOT NULL,
  tfName TEXT NOT NULL,
  tfComments text,
  tfModifiedTime datetime,
  tfModifiedUser INTEGER,
  qpEmployeeNum INTEGER,
  quickenAccount TEXT,
  tfActive BOOLEAN NOT NULL DEFAULT 1,
  PRIMARY KEY (tfID),
  CONSTRAINT tf_tfModifiedUser FOREIGN KEY (tfModifiedUser) REFERENCES person (personID)
);

CREATE TABLE person (
  personID INTEGER PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  perms TEXT,
  emailAddress TEXT,
  availability text,
  areasOfInterest text,
  comments text,
  managementComments text,
  lastLoginDate datetime,
  personModifiedUser INTEGER REFERENCES person (personID),
  firstName TEXT,
  surname TEXT,
  preferred_tfID INTEGER REFERENCES tf (tfID),
  personActive BOOLEAN,
  sessData text,
  phoneNo1 TEXT,
  phoneNo2 TEXT,
  emergencyContact TEXT,
  defaultTimeSheetRate bigint(20),
  defaultTimeSheetRateUnitID INTEGER REFERENCES timeUnit (timeUnitID));

CREATE TABLE project (
  projectID INTEGER PRIMARY KEY,
  projectName TEXT NOT NULL,
  projectComments text,
  clientID INTEGER REFERENCES client (clientID),
  clientContactID INTEGER REFERENCES clientContact (clientContactID),
  projectCreatedTime datetime,
  projectCreatedUser INTEGER,
  projectModifiedTime datetime,
  projectModifiedUser INTEGER REFERENCES person (personID),
  projectType TEXT REFERENCES projectType (projectTypeID) ON UPDATE CASCADE,
  projectClientName TEXT,
  projectClientPhone TEXT,
  projectClientMobile TEXT,
  projectClientEMail text,
  projectClientAddress text,
  dateTargetStart date,
  dateTargetCompletion date,
  dateActualStart date,
  dateActualCompletion date,
  projectBudget bigint(20),
  currencyTypeID TEXT NOT NULL REFERENCES currencyType (currencyTypeID),
  projectShortName TEXT UNIQUE,
  projectStatus TEXT NOT NULL REFERENCES projectStatus (projectStatusID) ON UPDATE CASCADE,
  projectPriority INTEGER,
  cost_centre_tfID INTEGER,
  customerBilledDollars bigint(20),
  defaultTaskLimit INTEGER,
  defaultTimeSheetRate bigint(20),
  defaultTimeSheetRateUnitID INTEGER REFERENCES timeUnit (timeUnitID));

CREATE TABLE task (
  taskID INTEGER NOT NULL,
  taskName TEXT NOT NULL,
  taskDescription text,
  creatorID INTEGER NOT NULL REFERENCES person (personID),
  closerID INTEGER REFERENCES person (personID),
  priority INTEGER NOT NULL DEFAULT 0,
  timeLimit INTEGER,
  timeBest INTEGER,
  timeExpected INTEGER,
  timeWorst INTEGER,
  dateCreated datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  dateAssigned datetime,
  dateClosed datetime,
  dateTargetCompletion date,
  projectID INTEGER REFERENCES project (projectID),
  dateActualCompletion date,
  dateActualStart date,
  dateTargetStart date,
  personID INTEGER REFERENCES person (personID),
  managerID INTEGER REFERENCES person (personID),
  parentTaskID INTEGER REFERENCES task (taskID),
  taskTypeID TEXT NOT NULL REFERENCES taskType (taskTypeID),
  taskModifiedUser INTEGER REFERENCES person (personID),
  duplicateTaskID INTEGER REFERENCES task (taskID),
  estimatorID INTEGER REFERENCES person (personID),
  taskStatus TEXT NOT NULL REFERENCES taskStatus (taskStatusID)
);



----------------------------------------------------------------------

CREATE TABLE absence (
  absenceID INTEGER PRIMARY KEY,
  dateFrom DATE,
  dateTo DATE,
  absenceType TEXT REFERENCES absenceType (absenceTypeID) ON UPDATE CASCADE,
  contactDetails TEXT,
  personID INTEGER NOT NULL REFERENCES person (personID),
  CONSTRAINT absence_date_fuck_check CHECK ((dateFrom IS NULL) OR (dateTo IS NULL) OR (dateFrom < dateTo)));

CREATE TABLE absenceType (
  absenceTypeID TEXT PRIMARY KEY,
  absenceTypeSeq INTEGER NOT NULL,
  absenceTypeActive BOOLEAN DEFAULT 1);

CREATE TABLE announcement (
  announcementID INTEGER PRIMARY KEY,
  heading TEXT,
  body TEXT,
  personID INTEGER NOT NULL REFERENCES person (personID),
  displayFromDate date,
  displayToDate date);

CREATE TABLE audit (
  auditID INTEGER PRIMARY KEY,
  taskID INTEGER REFERENCES task (taskID),
  projectID INTEGER REFERENCES project (projectID),
  personID INTEGER NOT NULL REFERENCES person (personID),
  dateChanged datetime NOT NULL,
  field TEXT,
  value text);

CREATE TABLE client (
  clientID INTEGER PRIMARY KEY,
  clientName TEXT NOT NULL,
  clientStreetAddressOne TEXT,
  clientStreetAddressTwo TEXT,
  clientSuburbOne TEXT,
  clientSuburbTwo TEXT,
  clientStateOne TEXT,
  clientStateTwo TEXT,
  clientPostcodeOne TEXT,
  clientPostcodeTwo TEXT,
  clientPhoneOne TEXT,
  clientFaxOne TEXT,
  clientCountryOne TEXT,
  clientCountryTwo TEXT,
  clientModifiedTime datetime,
  clientModifiedUser INTEGER REFERENCES person (personID),
  clientStatus TEXT NOT NULL DEFAULT 'current' REFERENCES clientStatus (clientStatusID) ON UPDATE CASCADE,
  clientCategory INTEGER DEFAULT 1,
  clientCreatedTime datetime,
  clientURL text);

CREATE TABLE clientContact (
  clientContactID INTEGER PRIMARY KEY,
  clientID INTEGER NOT NULL REFERENCES client (clientID),
  clientContactName TEXT,
  clientContactStreetAddress TEXT,
  clientContactSuburb TEXT,
  clientContactState TEXT,
  clientContactPostcode TEXT,
  clientContactPhone TEXT,
  clientContactMobile TEXT,
  clientContactFax TEXT,
  clientContactEmail TEXT,
  clientContactOther text,
  clientContactCountry TEXT,
  primaryContact BOOLEAN DEFAULT 0,
  clientContactActive BOOLEAN DEFAULT 1);

CREATE TABLE clientStatus (
  clientStatusID TEXT PRIMARY KEY,
  clientStatusSeq INTEGER NOT NULL,
  clientStatusActive BOOLEAN);

CREATE TABLE comment (
  commentID INTEGER PRIMARY KEY,
  commentMaster TEXT NOT NULL,
  commentMasterID INTEGER NOT NULL DEFAULT 0,
  commentType TEXT NOT NULL,
  commentLinkID INTEGER NOT NULL DEFAULT 0,
  commentCreatedTime datetime,
  commentCreatedUser INTEGER REFERENCES person (personID),
  commentModifiedTime datetime,
  commentModifiedUser INTEGER REFERENCES person (personID),
  commentCreatedUserClientContactID INTEGER REFERENCES clientContact (clientContactID),
  commentCreatedUserText TEXT,
  commentEmailRecipients text,
  commentEmailUID TEXT,
  commentEmailMessageID text,
  commentMimeParts text,
  comment text,
  commentEmailUIDORIG TEXT);

CREATE TABLE commentTemplate (
  commentTemplateID INTEGER PRIMARY KEY,
  commentTemplateName TEXT,
  commentTemplateText text,
  commentTemplateType TEXT,
  commentTemplateModifiedTime datetime);

CREATE TABLE config (
  configID INTEGER PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  value text NOT NULL,
  type TEXT NOT NULL DEFAULT 'text',
  CONSTRAINT config_configType FOREIGN KEY (type) REFERENCES configType (configTypeID) ON UPDATE CASCADE
);

CREATE TABLE configType (
  configTypeID TEXT PRIMARY KEY,
  configTypeSeq INTEGER NOT NULL DEFAULT 0,
  configTypeActive BOOLEAN DEFAULT 1);

CREATE TABLE currencyType (
  currencyTypeID TEXT NOT NULL,
  currencyTypeLabel TEXT,
  currencyTypeName TEXT,
  numberToBasic INTEGER DEFAULT 0,
  currencyTypeSeq INTEGER NOT NULL DEFAULT 0,
  currencyTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (currencyTypeID)
);

CREATE TABLE error (
  errorID TEXT PRIMARY KEY);

CREATE TABLE exchangeRate (
  exchangeRateID INTEGER PRIMARY KEY,
  exchangeRateCreatedDate date NOT NULL DEFAULT '0000-00-00',
  exchangeRateCreatedTime datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  fromCurrency TEXT NOT NULL,
  toCurrency TEXT NOT NULL,
  exchangeRate REAL NOT NULL DEFAULT 0.00000,
  UNIQUE (exchangeRateCreatedDate, fromCurrency, toCurrency)
);

CREATE TABLE expenseForm (
  expenseFormID INTEGER NOT NULL,
  clientID INTEGER,
  expenseFormModifiedUser INTEGER,
  expenseFormModifiedTime datetime,
  paymentMethod TEXT,
  reimbursementRequired BOOLEAN NOT NULL DEFAULT 0,
  expenseFormCreatedUser INTEGER,
  expenseFormCreatedTime datetime,
  transactionRepeatID INTEGER,
  expenseFormFinalised BOOLEAN NOT NULL DEFAULT 0,
  seekClientReimbursement BOOLEAN NOT NULL DEFAULT 0,
  expenseFormComment text,
  PRIMARY KEY (expenseFormID),
  CONSTRAINT expenseForm_clientID FOREIGN KEY (clientID) REFERENCES client (clientID),
  CONSTRAINT expenseForm_expenseFormCreatedUser FOREIGN KEY (expenseFormCreatedUser) REFERENCES person (personID),
  CONSTRAINT expenseForm_expenseFormModifiedUser FOREIGN KEY (expenseFormModifiedUser) REFERENCES person (personID),
  CONSTRAINT expenseForm_transactionRepeatID FOREIGN KEY (transactionRepeatID) REFERENCES transactionRepeat (transactionRepeatID)
);

CREATE TABLE history (
  historyID INTEGER PRIMARY KEY,
  the_time datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  the_place TEXT NOT NULL,
  the_args TEXT,
  personID INTEGER NOT NULL REFERENCES person (personID),
  the_label TEXT);

CREATE TABLE indexQueue (
  indexQueueID INTEGER PRIMARY KEY,
  entity TEXT NOT NULL,
  entityID INTEGER NOT NULL,
  UNIQUE (entity,entityID)
);

CREATE TABLE interestedParty (
  interestedPartyID INTEGER NOT NULL,
  entity TEXT NOT NULL,
  entityID INTEGER NOT NULL DEFAULT 0,
  fullName text,
  emailAddress text NOT NULL,
  personID INTEGER,
  clientContactID INTEGER,
  external BOOLEAN,
  interestedPartyCreatedUser INTEGER,
  interestedPartyCreatedTime datetime,
  interestedPartyActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (interestedPartyID),
  CONSTRAINT interestedParty_clientContactID FOREIGN KEY (clientContactID) REFERENCES clientContact (clientContactID),
  CONSTRAINT interestedParty_personID FOREIGN KEY (personID) REFERENCES person (personID)
);

CREATE TABLE invoice (
  invoiceID INTEGER PRIMARY KEY,
  invoiceRepeatID INTEGER,
  invoiceRepeatDate date,
  clientID INTEGER NOT NULL DEFAULT 0,
  projectID INTEGER,
  tfID INTEGER NOT NULL,
  invoiceDateFrom date,
  invoiceDateTo date,
  invoiceNum INTEGER UNIQUE NOT NULL,
  invoiceName TEXT NOT NULL,
  invoiceStatus TEXT NOT NULL DEFAULT 'edit',
  currencyTypeID TEXT NOT NULL,
  maxAmount bigint(20) DEFAULT 0,
  invoiceCreatedTime datetime,
  invoiceCreatedUser INTEGER,
  invoiceModifiedTime datetime,
  invoiceModifiedUser INTEGER,
  CONSTRAINT invoice_clientID FOREIGN KEY (clientID) REFERENCES client (clientID),
  CONSTRAINT invoice_currencyTypeID FOREIGN KEY (currencyTypeID) REFERENCES currencyType (currencyTypeID),
  CONSTRAINT invoice_invoiceRepeatID FOREIGN KEY (invoiceRepeatID) REFERENCES invoiceRepeat (invoiceRepeatID),
  CONSTRAINT invoice_invoiceStatus FOREIGN KEY (invoiceStatus) REFERENCES invoiceStatus (invoiceStatusID) ON UPDATE CASCADE,
  CONSTRAINT invoice_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT invoice_tfID FOREIGN KEY (tfID) REFERENCES tf (tfID)
);

CREATE TABLE invoiceEntity (
  invoiceEntityID INTEGER NOT NULL,
  invoiceID INTEGER NOT NULL,
  timeSheetID INTEGER,
  expenseFormID INTEGER,
  productSaleID INTEGER,
  useItems BOOLEAN DEFAULT 0,
  PRIMARY KEY (invoiceEntityID),
  CONSTRAINT invoiceEntity_expenseFormID FOREIGN KEY (expenseFormID) REFERENCES expenseForm (expenseFormID),
  CONSTRAINT invoiceEntity_invoiceID FOREIGN KEY (invoiceID) REFERENCES invoice (invoiceID),
  CONSTRAINT invoiceEntity_productSaleID FOREIGN KEY (productSaleID) REFERENCES productSale (productSaleID),
  CONSTRAINT invoiceEntity_timeSheetID FOREIGN KEY (timeSheetID) REFERENCES timeSheet (timeSheetID)
);

CREATE TABLE invoiceItem (
  invoiceItemID INTEGER NOT NULL,
  invoiceID INTEGER NOT NULL DEFAULT 0,
  timeSheetID INTEGER,
  timeSheetItemID INTEGER,
  expenseFormID INTEGER,
  transactionID INTEGER,
  productSaleID INTEGER,
  productSaleItemID INTEGER,
  iiMemo text,
  iiQuantity decimal(19,2),
  iiUnitPrice bigint(20),
  iiAmount bigint(20),
  iiTax decimal(9,2) DEFAULT 0.00,
  iiDate date,
  PRIMARY KEY (invoiceItemID),
  CONSTRAINT invoiceItem_expenseFormID FOREIGN KEY (expenseFormID) REFERENCES expenseForm (expenseFormID),
  CONSTRAINT invoiceItem_invoiceID FOREIGN KEY (invoiceID) REFERENCES invoice (invoiceID),
  CONSTRAINT invoiceItem_productSaleID FOREIGN KEY (productSaleID) REFERENCES productSale (productSaleID),
  CONSTRAINT invoiceItem_productSaleItemID FOREIGN KEY (productSaleItemID) REFERENCES productSaleItem (productSaleItemID),
  CONSTRAINT invoiceItem_timeSheetID FOREIGN KEY (timeSheetID) REFERENCES timeSheet (timeSheetID),
  CONSTRAINT invoiceItem_timeSheetItemID FOREIGN KEY (timeSheetItemID) REFERENCES timeSheetItem (timeSheetItemID),
  CONSTRAINT invoiceItem_transactionID FOREIGN KEY (transactionID) REFERENCES "transaction" (transactionID)
);

CREATE TABLE invoiceRepeat (
  invoiceRepeatID INTEGER NOT NULL,
  invoiceID INTEGER NOT NULL,
  personID INTEGER NOT NULL,
  message text,
  active BOOLEAN DEFAULT 1,
  PRIMARY KEY (invoiceRepeatID),
  CONSTRAINT invoiceRepeat_invoiceID FOREIGN KEY (invoiceID) REFERENCES invoice (invoiceID),
  CONSTRAINT invoiceRepeat_personID FOREIGN KEY (personID) REFERENCES person (personID)
);

CREATE TABLE invoiceRepeatDate (
  invoiceRepeatDateID INTEGER NOT NULL,
  invoiceRepeatID INTEGER NOT NULL,
  invoiceDate date NOT NULL,
  PRIMARY KEY (invoiceRepeatDateID),
  CONSTRAINT invoiceRepeat_invoiceRepeatID FOREIGN KEY (invoiceRepeatID) REFERENCES invoiceRepeat (invoiceRepeatID)
);

CREATE TABLE invoiceStatus (
  invoiceStatusID TEXT NOT NULL,
  invoiceStatusSeq INTEGER NOT NULL DEFAULT 0,
  invoiceStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (invoiceStatusID)
);

CREATE TABLE item (
  itemID INTEGER NOT NULL,
  itemName TEXT,
  itemNotes text,
  itemModifiedTime datetime,
  itemModifiedUser INTEGER,
  itemType TEXT NOT NULL DEFAULT 'cd',
  itemAuthor TEXT,
  personID INTEGER,
  PRIMARY KEY (itemID),
  CONSTRAINT item_itemModifiedUser FOREIGN KEY (itemModifiedUser) REFERENCES person (personID),
  CONSTRAINT item_itemType FOREIGN KEY (itemType) REFERENCES itemType (itemTypeID) ON UPDATE CASCADE,
  CONSTRAINT item_personID FOREIGN KEY (personID) REFERENCES person (personID)
);

CREATE TABLE itemType (
  itemTypeID TEXT NOT NULL,
  itemTypeSeq INTEGER NOT NULL DEFAULT 0,
  itemTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (itemTypeID)
);

CREATE TABLE loan (
  loanID INTEGER NOT NULL,
  itemID INTEGER NOT NULL DEFAULT 0,
  personID INTEGER NOT NULL DEFAULT 0,
  loanModifiedUser INTEGER,
  loanModifiedTime datetime,
  dateBorrowed date NOT NULL DEFAULT '0000-00-00',
  dateToBeReturned date,
  dateReturned date,
  PRIMARY KEY (loanID),
  CONSTRAINT loan_itemID FOREIGN KEY (itemID) REFERENCES item (itemID),
  CONSTRAINT loan_loanModifiedUser FOREIGN KEY (loanModifiedUser) REFERENCES person (personID),
  CONSTRAINT loan_personID FOREIGN KEY (personID) REFERENCES person (personID)
);

CREATE TABLE patchLog (
  patchLogID INTEGER NOT NULL,
  patchName TEXT NOT NULL,
  patchDesc text,
  patchDate datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (patchLogID)
);

CREATE TABLE pendingTask (
  taskID INTEGER REFERENCES task (taskID),
  pendingTaskID INTEGER REFERENCES task (taskID));

CREATE TABLE permission (
  permissionID INTEGER PRIMARY KEY,
  tableName TEXT,
  entityID INTEGER,
  roleName TEXT,
  sortKey INTEGER DEFAULT 100,
  actions INTEGER,
  comment text);



CREATE TABLE productCost (
  productCostID INTEGER NOT NULL,
  productID INTEGER NOT NULL DEFAULT 0,
  tfID INTEGER,
  amount bigint(20) NOT NULL DEFAULT 0,
  currencyTypeID TEXT NOT NULL,
  isPercentage BOOLEAN NOT NULL DEFAULT 0,
  description TEXT,
  tax BOOLEAN,
  productCostActive BOOLEAN NOT NULL DEFAULT 1,
  PRIMARY KEY (productCostID),
  CONSTRAINT productCost_currencyTypeID FOREIGN KEY (currencyTypeID) REFERENCES currencyType (currencyTypeID),
  CONSTRAINT productCost_productID FOREIGN KEY (productID) REFERENCES product (productID)
);

CREATE TABLE productSale (
  productSaleID INTEGER NOT NULL,
  clientID INTEGER,
  projectID INTEGER,
  personID INTEGER,
  tfID INTEGER NOT NULL,
  status TEXT NOT NULL,
  productSaleCreatedTime datetime,
  productSaleCreatedUser INTEGER,
  productSaleModifiedTime datetime,
  productSaleModifiedUser INTEGER,
  productSaleDate date,
  extRef TEXT,
  extRefDate date,
  PRIMARY KEY (productSaleID),
  CONSTRAINT productSale_clientID FOREIGN KEY (clientID) REFERENCES client (clientID),
  CONSTRAINT productSale_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT productSale_productSaleCreatedUser FOREIGN KEY (productSaleCreatedUser) REFERENCES person (personID),
  CONSTRAINT productSale_productSaleModifiedUser FOREIGN KEY (productSaleModifiedUser) REFERENCES person (personID),
  CONSTRAINT productSale_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT productSale_status FOREIGN KEY (status) REFERENCES productSaleStatus (productSaleStatusID) ON UPDATE CASCADE,
  CONSTRAINT productSale_tfID FOREIGN KEY (tfID) REFERENCES tf (tfID)
);

CREATE TABLE productSaleItem (
  productSaleItemID INTEGER NOT NULL,
  productID INTEGER NOT NULL DEFAULT 0,
  productSaleID INTEGER NOT NULL DEFAULT 0,
  sellPrice bigint(20) DEFAULT 0,
  sellPriceCurrencyTypeID TEXT NOT NULL,
  sellPriceIncTax BOOLEAN NOT NULL DEFAULT 0,
  quantity decimal(19,2) NOT NULL DEFAULT 1.00,
  description TEXT,
  PRIMARY KEY (productSaleItemID),
  CONSTRAINT productSaleItem_productID FOREIGN KEY (productID) REFERENCES product (productID),
  CONSTRAINT productSaleItem_productSaleID FOREIGN KEY (productSaleID) REFERENCES productSale (productSaleID)
);

CREATE TABLE productSaleStatus (
  productSaleStatusID TEXT NOT NULL,
  productSaleStatusSeq INTEGER NOT NULL DEFAULT 0,
  productSaleStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (productSaleStatusID)
);

CREATE TABLE proficiency (
  proficiencyID INTEGER NOT NULL,
  personID INTEGER NOT NULL DEFAULT 0,
  skillID INTEGER NOT NULL DEFAULT 0,
  skillProficiency TEXT NOT NULL DEFAULT 'Novice',
  PRIMARY KEY (proficiencyID),
  CONSTRAINT proficiency_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT proficiency_skillID FOREIGN KEY (skillID) REFERENCES skill (skillID),
  CONSTRAINT proficiency_skillProficiency FOREIGN KEY (skillProficiency) REFERENCES skillProficiency (skillProficiencyID) ON UPDATE CASCADE
);


CREATE TABLE projectCommissionPerson (
  projectCommissionPersonID INTEGER NOT NULL,
  projectID INTEGER NOT NULL DEFAULT 0,
  personID INTEGER,
  commissionPercent decimal(5,3) DEFAULT 0.000,
  tfID INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (projectCommissionPersonID),
  CONSTRAINT projectCommissionPerson_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT projectCommissionPerson_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT projectCommissionPerson_tfID FOREIGN KEY (tfID) REFERENCES tf (tfID)
);

CREATE TABLE projectPerson (
  projectPersonID INTEGER NOT NULL,
  projectID INTEGER NOT NULL DEFAULT 0,
  personID INTEGER NOT NULL DEFAULT 0,
  roleID INTEGER NOT NULL DEFAULT 0,
  emailType TEXT,
  rate bigint(20),
  rateUnitID INTEGER,
  projectPersonModifiedUser INTEGER,
  emailDateRegex TEXT,
  PRIMARY KEY (projectPersonID),
  CONSTRAINT projectPerson_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT projectPerson_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT projectPerson_projectPersonModifiedUser FOREIGN KEY (projectPersonModifiedUser) REFERENCES person (personID),
  CONSTRAINT projectPerson_roleID FOREIGN KEY (roleID) REFERENCES role (roleID)
);

CREATE TABLE projectStatus (
  projectStatusID TEXT NOT NULL,
  projectStatusSeq INTEGER NOT NULL DEFAULT 0,
  projectStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (projectStatusID)
);

CREATE TABLE projectType (
  projectTypeID TEXT NOT NULL,
  projectTypeSeq INTEGER NOT NULL DEFAULT 0,
  projectTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (projectTypeID)
);

CREATE TABLE reminder (
  reminderID INTEGER NOT NULL,
  reminderType TEXT,
  reminderLinkID INTEGER NOT NULL DEFAULT 0,
  reminderTime datetime,
  reminderHash TEXT,
  reminderRecuringInterval TEXT NOT NULL DEFAULT 'No',
  reminderRecuringValue INTEGER NOT NULL DEFAULT 0,
  reminderAdvNoticeSent BOOLEAN NOT NULL DEFAULT 0,
  reminderAdvNoticeInterval TEXT NOT NULL DEFAULT 'No',
  reminderAdvNoticeValue INTEGER NOT NULL DEFAULT 0,
  reminderSubject TEXT NOT NULL,
  reminderContent text,
  reminderCreatedTime datetime NOT NULL,
  reminderCreatedUser INTEGER NOT NULL,
  reminderModifiedTime datetime,
  reminderModifiedUser INTEGER,
  reminderActive BOOLEAN NOT NULL DEFAULT 1,
  PRIMARY KEY (reminderID),
  CONSTRAINT reminder_reminderAdvNoticeInterval FOREIGN KEY (reminderAdvNoticeInterval) REFERENCES reminderAdvNoticeInterval (reminderAdvNoticeIntervalID) ON UPDATE CASCADE,
  CONSTRAINT reminder_reminderCreatedUser FOREIGN KEY (reminderCreatedUser) REFERENCES person (personID),
  CONSTRAINT reminder_reminderHash FOREIGN KEY (reminderHash) REFERENCES token (tokenHash),
  CONSTRAINT reminder_reminderModifiedUser FOREIGN KEY (reminderModifiedUser) REFERENCES person (personID),
  CONSTRAINT reminder_reminderRecuringInterval FOREIGN KEY (reminderRecuringInterval) REFERENCES reminderRecuringInterval (reminderRecuringIntervalID) ON UPDATE CASCADE
);

CREATE TABLE reminderAdvNoticeInterval (
  reminderAdvNoticeIntervalID TEXT NOT NULL,
  reminderAdvNoticeIntervalSeq INTEGER NOT NULL DEFAULT 0,
  reminderAdvNoticeIntervalActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (reminderAdvNoticeIntervalID)
);

CREATE TABLE reminderRecipient (
  reminderRecipientID INTEGER NOT NULL,
  reminderID INTEGER NOT NULL,
  personID INTEGER,
  metaPersonID INTEGER,
  PRIMARY KEY (reminderRecipientID),
  CONSTRAINT reminderRecipient_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT reminderRecipient_reminderID FOREIGN KEY (reminderID) REFERENCES reminder (reminderID)
);

CREATE TABLE reminderRecuringInterval (
  reminderRecuringIntervalID TEXT NOT NULL,
  reminderRecuringIntervalSeq INTEGER NOT NULL DEFAULT 0,
  reminderRecuringIntervalActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (reminderRecuringIntervalID)
);

CREATE TABLE role (
  roleID INTEGER NOT NULL,
  roleName TEXT,
  roleHandle TEXT,
  roleLevel TEXT NOT NULL,
  roleSequence INTEGER,
  PRIMARY KEY (roleID),
  CONSTRAINT role_roleLevel FOREIGN KEY (roleLevel) REFERENCES roleLevel (roleLevelID) ON UPDATE CASCADE
);

CREATE TABLE roleLevel (
  roleLevelID TEXT NOT NULL,
  roleLevelSeq INTEGER NOT NULL DEFAULT 0,
  roleLevelActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (roleLevelID)
);

CREATE TABLE sentEmailLog (
  sentEmailLogID INTEGER NOT NULL,
  sentEmailTo text NOT NULL,
  sentEmailSubject TEXT,
  sentEmailBody text,
  sentEmailHeader text,
  sentEmailType TEXT,
  sentEmailLogCreatedTime datetime,
  sentEmailLogCreatedUser INTEGER,
  PRIMARY KEY (sentEmailLogID),
  CONSTRAINT sentEmailLog_sentEmailLogCreatedUser FOREIGN KEY (sentEmailLogCreatedUser) REFERENCES person (personID),
  CONSTRAINT sentEmailLog_sentEmailType FOREIGN KEY (sentEmailType) REFERENCES sentEmailType (sentEmailTypeID) ON UPDATE CASCADE
);

CREATE TABLE sentEmailType (
  sentEmailTypeID TEXT NOT NULL,
  sentEmailTypeSeq INTEGER NOT NULL DEFAULT 0,
  sentEmailTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (sentEmailTypeID)
);

CREATE TABLE sess (
  sessID varchar(32) NOT NULL,
  personID INTEGER NOT NULL DEFAULT 0,
  sessData text,
  PRIMARY KEY (sessID),
  CONSTRAINT sess_personID FOREIGN KEY (personID) REFERENCES person (personID)
);

CREATE TABLE skill (
  skillID INTEGER NOT NULL,
  skillName varchar(40) NOT NULL,
  skillDescription text,
  skillClass varchar(40) NOT NULL,
  PRIMARY KEY (skillID)
);

CREATE TABLE skillProficiency (
  skillProficiencyID TEXT PRIMARY KEY,
  skillProficiencySeq INTEGER NOT NULL DEFAULT 0,
  skillProficiencyActive BOOLEAN DEFAULT 1);

CREATE TABLE tag (
  taskID INTEGER NOT NULL REFERENCES task (taskID),
  name TEXT NOT NULL,
  PRIMARY KEY (taskID, name));


CREATE TABLE taskStatus (
  taskStatusID TEXT NOT NULL,
  taskStatusLabel TEXT,
  taskStatusColour TEXT,
  taskStatusSeq INTEGER NOT NULL DEFAULT 0,
  taskStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (taskStatusID)
);

CREATE TABLE taskType (
  taskTypeID TEXT NOT NULL,
  taskTypeSeq INTEGER NOT NULL DEFAULT 0,
  taskTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (taskTypeID)
);

CREATE TABLE tfPerson (
  tfPersonID INTEGER PRIMARY KEY,
  tfID INTEGER NOT NULL REFERENCES tf (tfID),
  personID INTEGER NOT NULL REFERENCES person (personID));

CREATE TABLE timeSheet (
  timeSheetID INTEGER NOT NULL,
  projectID INTEGER NOT NULL DEFAULT 0,
  dateFrom date,
  dateTo date,
  status TEXT,
  personID INTEGER NOT NULL DEFAULT 0,
  approvedByManagerPersonID INTEGER,
  approvedByAdminPersonID INTEGER,
  dateSubmittedToManager date,
  dateSubmittedToAdmin date,
  dateRejected date,
  invoiceDate date,
  billingNote text,
  recipient_tfID INTEGER,
  customerBilledDollars bigint(20),
  currencyTypeID TEXT NOT NULL,
  PRIMARY KEY (timeSheetID),
  CONSTRAINT timeSheet_approvedByAdminPersonID FOREIGN KEY (approvedByAdminPersonID) REFERENCES person (personID),
  CONSTRAINT timeSheet_approvedByManagerPersonID FOREIGN KEY (approvedByManagerPersonID) REFERENCES person (personID),
  CONSTRAINT timeSheet_currencyTypeID FOREIGN KEY (currencyTypeID) REFERENCES currencyType (currencyTypeID),
  CONSTRAINT timeSheet_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT timeSheet_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT timeSheet_recipient_tfID FOREIGN KEY (recipient_tfID) REFERENCES tf (tfID),
  CONSTRAINT timeSheet_status FOREIGN KEY (status) REFERENCES timeSheetStatus (timeSheetStatusID) ON UPDATE CASCADE
);

CREATE TABLE timeSheetItem (
  timeSheetItemID INTEGER NOT NULL,
  timeSheetID INTEGER NOT NULL DEFAULT 0,
  dateTimeSheetItem date,
  timeSheetItemDuration decimal(9,2) DEFAULT 0.00,
  timeSheetItemDurationUnitID INTEGER,
  description text,
  location text,
  personID INTEGER NOT NULL DEFAULT 0,
  taskID INTEGER,
  rate bigint(20) DEFAULT 0,
  commentPrivate BOOLEAN DEFAULT 0,
  comment text,
  multiplier decimal(9,2) NOT NULL DEFAULT 1.00,
  emailUID TEXT,
  emailMessageID TEXT,
  timeSheetItemCreatedTime datetime,
  timeSheetItemCreatedUser INTEGER,
  timeSheetItemModifiedTime datetime,
  timeSheetItemModifiedUser INTEGER,
  PRIMARY KEY (timeSheetItemID),
  CONSTRAINT timeSheetItem_multiplier FOREIGN KEY (multiplier) REFERENCES timeSheetItemMultiplier (timeSheetItemMultiplierID) ON UPDATE CASCADE,
  CONSTRAINT timeSheetItem_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT timeSheetItem_taskID FOREIGN KEY (taskID) REFERENCES task (taskID),
  CONSTRAINT timeSheetItem_timeSheetID FOREIGN KEY (timeSheetID) REFERENCES timeSheet (timeSheetID),
  CONSTRAINT timeSheetItem_timeSheetItemDurationUnitID FOREIGN KEY (timeSheetItemDurationUnitID) REFERENCES timeUnit (timeUnitID)
);

CREATE TABLE timeSheetItemMultiplier (
  timeSheetItemMultiplierID decimal(9,2) NOT NULL DEFAULT 0.00,
  timeSheetItemMultiplierName TEXT,
  timeSheetItemMultiplierSeq INTEGER NOT NULL DEFAULT 0,
  timeSheetItemMultiplierActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (timeSheetItemMultiplierID)
);

CREATE TABLE timeSheetStatus (
  timeSheetStatusID TEXT NOT NULL,
  timeSheetStatusSeq INTEGER NOT NULL DEFAULT 0,
  timeSheetStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (timeSheetStatusID)
);

CREATE TABLE timeUnit (
  timeUnitID INTEGER NOT NULL,
  timeUnitName varchar(30),
  timeUnitLabelA varchar(30),
  timeUnitLabelB varchar(30),
  timeUnitSeconds INTEGER,
  timeUnitActive BOOLEAN DEFAULT 0,
  timeUnitSequence INTEGER,
  PRIMARY KEY (timeUnitID)
);

CREATE TABLE token (
  tokenID INTEGER NOT NULL,
  tokenHash TEXT NOT NULL,
  tokenEntity varchar(32),
  tokenEntityID INTEGER,
  tokenActionID INTEGER NOT NULL DEFAULT 0,
  tokenExpirationDate datetime,
  tokenUsed INTEGER DEFAULT 0,
  tokenMaxUsed INTEGER DEFAULT 0,
  tokenActive BOOLEAN DEFAULT 0,
  tokenCreatedBy INTEGER NOT NULL DEFAULT 0,
  tokenCreatedDate datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (tokenID),
  UNIQUE (tokenHash),
  CONSTRAINT token_tokenActionID FOREIGN KEY (tokenActionID) REFERENCES tokenAction (tokenActionID),
  CONSTRAINT token_tokenCreatedBy FOREIGN KEY (tokenCreatedBy) REFERENCES person (personID)
);

CREATE TABLE tokenAction (
  tokenActionID INTEGER NOT NULL,
  tokenAction varchar(32) NOT NULL,
  tokenActionType varchar(32),
  tokenActionMethod varchar(32),
  PRIMARY KEY (tokenActionID)
);

CREATE TABLE "transaction" (
  transactionID INTEGER NOT NULL,
  companyDetails text NOT NULL,
  product TEXT NOT NULL,
  amount bigint(20) NOT NULL DEFAULT 0,
  currencyTypeID TEXT NOT NULL,
  destCurrencyTypeID TEXT NOT NULL,
  exchangeRate decimal(14,5) NOT NULL DEFAULT 1.00000,
  status TEXT NOT NULL DEFAULT 'pending',
  dateApproved date,
  expenseFormID INTEGER,
  tfID INTEGER NOT NULL DEFAULT 0,
  fromTfID INTEGER NOT NULL DEFAULT 0,
  projectID INTEGER,
  transactionModifiedUser INTEGER,
  transactionModifiedTime datetime,
  quantity INTEGER NOT NULL DEFAULT 1,
  transactionCreatedUser INTEGER,
  transactionCreatedTime datetime,
  transactionDate date NOT NULL DEFAULT '0000-00-00',
  invoiceID INTEGER,
  invoiceItemID INTEGER,
  transactionType TEXT NOT NULL,
  timeSheetID INTEGER,
  productSaleID INTEGER,
  productSaleItemID INTEGER,
  productCostID INTEGER,
  transactionRepeatID INTEGER,
  transactionGroupID INTEGER,
  PRIMARY KEY (transactionID),
  CONSTRAINT transaction_currencyTypeID FOREIGN KEY (currencyTypeID) REFERENCES currencyType (currencyTypeID),
  CONSTRAINT transaction_expenseFormID FOREIGN KEY (expenseFormID) REFERENCES expenseForm (expenseFormID),
  CONSTRAINT transaction_fromTfID FOREIGN KEY (fromTfID) REFERENCES tf (tfID),
  CONSTRAINT transaction_invoiceID FOREIGN KEY (invoiceID) REFERENCES invoice (invoiceID),
  CONSTRAINT transaction_invoiceItemID FOREIGN KEY (invoiceItemID) REFERENCES invoiceItem (invoiceItemID),
  CONSTRAINT transaction_productCostID FOREIGN KEY (productCostID) REFERENCES productCost (productCostID),
  CONSTRAINT transaction_productSaleID FOREIGN KEY (productSaleID) REFERENCES productSale (productSaleID),
  CONSTRAINT transaction_productSaleItemID FOREIGN KEY (productSaleItemID) REFERENCES productSaleItem (productSaleItemID),
  CONSTRAINT transaction_projectID FOREIGN KEY (projectID) REFERENCES project (projectID),
  CONSTRAINT transaction_status FOREIGN KEY (status) REFERENCES transactionStatus (transactionStatusID) ON UPDATE CASCADE,
  CONSTRAINT transaction_tfID FOREIGN KEY (tfID) REFERENCES tf (tfID),
  CONSTRAINT transaction_timeSheetID FOREIGN KEY (timeSheetID) REFERENCES timeSheet (timeSheetID),
  CONSTRAINT transaction_transactionCreatedUser FOREIGN KEY (transactionCreatedUser) REFERENCES person (personID),
  CONSTRAINT transaction_transactionModifiedUser FOREIGN KEY (transactionModifiedUser) REFERENCES person (personID),
  CONSTRAINT transaction_transactionRepeatID FOREIGN KEY (transactionRepeatID) REFERENCES transactionRepeat (transactionRepeatID),
  CONSTRAINT transaction_transactionType FOREIGN KEY (transactionType) REFERENCES transactionType (transactionTypeID) ON UPDATE CASCADE
);

CREATE TABLE transactionRepeat (
  transactionRepeatID INTEGER NOT NULL,
  tfID INTEGER NOT NULL DEFAULT 0,
  fromTfID INTEGER NOT NULL DEFAULT 0,
  payToName text NOT NULL,
  payToAccount text NOT NULL,
  companyDetails text NOT NULL,
  emailOne TEXT,
  emailTwo TEXT,
  transactionRepeatModifiedUser INTEGER,
  transactionRepeatModifiedTime datetime,
  transactionRepeatCreatedUser INTEGER,
  transactionRepeatCreatedTime datetime,
  transactionStartDate date NOT NULL DEFAULT '0000-00-00',
  transactionFinishDate date NOT NULL DEFAULT '0000-00-00',
  paymentBasis TEXT NOT NULL,
  amount bigint(20) NOT NULL DEFAULT 0,
  currencyTypeID TEXT NOT NULL,
  product TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  transactionType TEXT NOT NULL,
  reimbursementRequired BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (transactionRepeatID),
  CONSTRAINT transactionRepeat_currencyTypeID FOREIGN KEY (currencyTypeID) REFERENCES currencyType (currencyTypeID),
  CONSTRAINT transactionRepeat_fromTfID FOREIGN KEY (fromTfID) REFERENCES tf (tfID),
  CONSTRAINT transactionRepeat_tfID FOREIGN KEY (tfID) REFERENCES tf (tfID),
  CONSTRAINT transactionRepeat_transactionRepeatCreatedUser FOREIGN KEY (transactionRepeatCreatedUser) REFERENCES person (personID),
  CONSTRAINT transactionRepeat_transactionRepeatModifiedUser FOREIGN KEY (transactionRepeatModifiedUser) REFERENCES person (personID),
  CONSTRAINT transactionRepeat_transactionType FOREIGN KEY (transactionType) REFERENCES transactionType (transactionTypeID) ON UPDATE CASCADE
);

CREATE TABLE transactionStatus (
  transactionStatusID TEXT NOT NULL,
  transactionStatusSeq INTEGER NOT NULL DEFAULT 0,
  transactionStatusActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (transactionStatusID)
);

CREATE TABLE transactionType (
  transactionTypeID TEXT NOT NULL,
  transactionTypeSeq INTEGER NOT NULL DEFAULT 0,
  transactionTypeActive BOOLEAN DEFAULT 1,
  PRIMARY KEY (transactionTypeID)
);

CREATE TABLE tsiHint (
  tsiHintID INTEGER NOT NULL,
  date date,
  duration decimal(9,2) DEFAULT 0.00,
  personID INTEGER NOT NULL,
  taskID INTEGER,
  comment text,
  tsiHintCreatedTime datetime,
  tsiHintCreatedUser INTEGER,
  tsiHintModifiedTime datetime,
  tsiHintModifiedUser INTEGER,
  PRIMARY KEY (tsiHintID),
  CONSTRAINT tsiHint_personID FOREIGN KEY (personID) REFERENCES person (personID),
  CONSTRAINT tsiHint_taskID FOREIGN KEY (taskID) REFERENCES task (taskID)
);

-- FIXME: TRIGGER BULLSHIT.

-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_insert_interestedParty AFTER INSERT ON interestedParty
-- FOR EACH ROW
-- BEGIN
--   call audit_interested_parties(NEW.entity,NEW.entityID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_update_interestedParty AFTER UPDATE ON interestedParty
-- FOR EACH ROW
-- BEGIN
--   call audit_interested_parties(NEW.entity,NEW.entityID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_delete_interestedParty AFTER DELETE ON interestedParty
-- FOR EACH ROW
-- BEGIN
--   call audit_interested_parties(OLD.entity,OLD.entityID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_insert_pendingTask BEFORE INSERT ON pendingTask
-- FOR EACH ROW
-- BEGIN
--   DECLARE pID INTEGER;
--   SELECT projectID INTO pID FROM task WHERE taskID = NEW.taskID;
--   call check_edit_task(pID);
--   IF (NEW.taskID = NEW.pendingTaskID) THEN
--     call alloc_error('Task cannot be pending itself.');
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_insert_pendingTask AFTER INSERT ON pendingTask
-- FOR EACH ROW
-- BEGIN
--   DECLARE num_rows INTEGER;
--   DECLARE t1status TEXT;
--   DECLARE t2status TEXT;

  
--   SELECT taskStatus INTO t1status FROM task WHERE taskID = NEW.taskID;
--   SELECT taskStatus INTO t2status FROM task WHERE taskID = NEW.pendingTaskID;
--   IF (neq(t1status,"pending_tasks") AND neq(SUBSTRING(t2status,1,6),"closed")) THEN
--     call change_task_status(NEW.taskID,"pending_tasks");
--   END IF;

  
--   IF (t1status = "pending_tasks") THEN
--     SELECT count(pendingTask.taskID) INTO num_rows FROM pendingTask
--  LEFT JOIN task ON task.taskID = pendingTask.pendingTaskID
--      WHERE pendingTask.taskID = NEW.taskID
--        AND SUBSTRING(task.taskStatus,1,6) != "closed";
  
--     IF (num_rows = 0) THEN
--       call change_task_status(NEW.taskID,"open_notstarted");
--     END IF;
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_update_pendingTask BEFORE UPDATE ON pendingTask
-- FOR EACH ROW
-- BEGIN
--   DECLARE pID INTEGER;
--   SELECT projectID INTO pID FROM task WHERE taskID = NEW.taskID;
--   call check_edit_task(pID);

--   IF (NEW.taskID = NEW.pendingTaskID) THEN
--     call alloc_error('Task cannot be pending itself.');
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_delete_pendingTask BEFORE DELETE ON pendingTask
-- FOR EACH ROW
-- BEGIN
--   DECLARE pID INTEGER;
--   SELECT projectID INTO pID FROM task WHERE taskID = OLD.taskID;
--   call check_edit_task(pID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_delete_pendingTask AFTER DELETE ON pendingTask
-- FOR EACH ROW
-- BEGIN
--   DECLARE num_rows INTEGER;
--   DECLARE t1status TEXT;

--   SELECT taskStatus INTO t1status FROM task WHERE taskID = OLD.taskID;
--   IF (t1status = "pending_tasks") THEN

    
--     SELECT count(pendingTask.taskID) INTO num_rows FROM pendingTask
--  LEFT JOIN task ON task.taskID = pendingTask.pendingTaskID
--      WHERE pendingTask.taskID = OLD.taskID
--        AND SUBSTRING(task.taskStatus,1,6) != "closed";
  
--     IF (num_rows = 0) THEN
--       call change_task_status(OLD.taskID,"open_notstarted");
--     END IF;
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_insert_project AFTER INSERT ON project
-- FOR EACH ROW
-- BEGIN
--   call alloc_log("project", NEW.projectID, "created",                   NULL, "The project was created.");
--   call alloc_log("project", NEW.projectID, "projectName",               NULL, NEW.projectName);
--   call alloc_log("project", NEW.projectID, "projectShortName",          NULL, NEW.projectShortName);
--   call alloc_log("project", NEW.projectID, "projectComments",           NULL, NEW.projectComments);
--   call alloc_log("project", NEW.projectID, "clientID",                  NULL, NEW.clientID);
--   call alloc_log("project", NEW.projectID, "clientContactID",           NULL, NEW.clientContactID);
--   call alloc_log("project", NEW.projectID, "projectType",               NULL, NEW.projectType);
--   call alloc_log("project", NEW.projectID, "dateTargetStart",           NULL, NEW.dateTargetStart);
--   call alloc_log("project", NEW.projectID, "dateTargetCompletion",      NULL, NEW.dateTargetCompletion);
--   call alloc_log("project", NEW.projectID, "dateActualStart",           NULL, NEW.dateActualStart);
--   call alloc_log("project", NEW.projectID, "dateActualCompletion",      NULL, NEW.dateActualCompletion);
--   call alloc_log("project", NEW.projectID, "projectBudget",             NULL, NEW.projectBudget);
--   call alloc_log("project", NEW.projectID, "currencyTypeID",            NULL, NEW.currencyTypeID);
--   call alloc_log("project", NEW.projectID, "projectStatus",             NULL, NEW.projectStatus);
--   call alloc_log("project", NEW.projectID, "projectPriority",           NULL, NEW.projectPriority);
--   call alloc_log("project", NEW.projectID, "cost_centre_tfID",          NULL, NEW.cost_centre_tfID);
--   call alloc_log("project", NEW.projectID, "customerBilledDollars",     NULL, NEW.customerBilledDollars);
--   call alloc_log("project", NEW.projectID, "defaultTaskLimit",          NULL, NEW.defaultTaskLimit);
--   call alloc_log("project", NEW.projectID, "defaultTimeSheetRate",      NULL, NEW.defaultTimeSheetRate);
--   call alloc_log("project", NEW.projectID, "defaultTimeSheetRateUnitID",NULL, NEW.defaultTimeSheetRateUnitID);
--   call update_search_index("project",NEW.projectID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_update_project AFTER UPDATE ON project
-- FOR EACH ROW
-- BEGIN
--   call alloc_log("project", OLD.projectID, "projectName",             OLD.projectName,             NEW.projectName);
--   call alloc_log("project", OLD.projectID, "projectShortName",        OLD.projectShortName,        NEW.projectShortName);
--   call alloc_log("project", OLD.projectID, "projectComments",         OLD.projectComments,         NEW.projectComments);
--   call alloc_log("project", OLD.projectID, "clientID",                OLD.clientID,                NEW.clientID);
--   call alloc_log("project", OLD.projectID, "clientContactID",         OLD.clientContactID,         NEW.clientContactID);
--   call alloc_log("project", OLD.projectID, "projectType",             OLD.projectType,             NEW.projectType);
--   call alloc_log("project", OLD.projectID, "dateTargetStart",         OLD.dateTargetStart,         NEW.dateTargetStart);
--   call alloc_log("project", OLD.projectID, "dateTargetCompletion",    OLD.dateTargetCompletion,    NEW.dateTargetCompletion);
--   call alloc_log("project", OLD.projectID, "dateActualStart",         OLD.dateActualStart,         NEW.dateActualStart);
--   call alloc_log("project", OLD.projectID, "dateActualCompletion",    OLD.dateActualCompletion,    NEW.dateActualCompletion);
--   call alloc_log("project", OLD.projectID, "projectBudget",           OLD.projectBudget,           NEW.projectBudget);
--   call alloc_log("project", OLD.projectID, "currencyTypeID",          OLD.currencyTypeID,          NEW.currencyTypeID);
--   call alloc_log("project", OLD.projectID, "projectStatus",           OLD.projectStatus,           NEW.projectStatus);
--   call alloc_log("project", OLD.projectID, "projectPriority",         OLD.projectPriority,         NEW.projectPriority);
--   call alloc_log("project", OLD.projectID, "cost_centre_tfID",        OLD.cost_centre_tfID,        NEW.cost_centre_tfID);
--   call alloc_log("project", OLD.projectID, "customerBilledDollars",   OLD.customerBilledDollars,   NEW.customerBilledDollars);
--   call alloc_log("project", OLD.projectID, "defaultTaskLimit",        OLD.defaultTaskLimit,        NEW.defaultTaskLimit);
--   call alloc_log("project", OLD.projectID, "defaultTimeSheetRate",    OLD.defaultTimeSheetRate,    NEW.defaultTimeSheetRate);
--   call alloc_log("project", OLD.projectID, "defaultTimeSheetRateUnitID",OLD.defaultTimeSheetRateUnitID,NEW.defaultTimeSheetRateUnitID);
--   call update_search_index("project",NEW.projectID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_delete_reminder BEFORE DELETE ON reminder
-- FOR EACH ROW
-- BEGIN
--   IF (has_perm(personID(),4,"reminder")) THEN
--     DELETE FROM reminderRecipient WHERE reminderID = OLD.reminderID;
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- /*!50003 SET @saved_cs_client      = @@character_set_client */ ;
-- /*!50003 SET @saved_cs_results     = @@character_set_results */ ;
-- /*!50003 SET @saved_col_connection = @@collation_connection */ ;
-- /*!50003 SET character_set_client  = utf8mb3 */ ;
-- /*!50003 SET character_set_results = utf8mb3 */ ;
-- /*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
-- /*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
-- /*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_insert_task BEFORE INSERT ON task
-- FOR EACH ROW
-- BEGIN
--   DECLARE defTaskLimit INTEGER;
--   call check_edit_task(NEW.projectID);

--   IF (NEW.parentTaskID) THEN CALL check_for_parent_task_loop(NEW.parentTaskID, NULL); END IF;

--   SET NEW.creatorID = personID();
--   SET NEW.dateCreated = current_timestamp();

  
--   IF (substring(NEW.taskStatus,1,6) = 'closed') THEN
--     SET NEW.dateActualCompletion = current_date();
--   END IF;

--   IF (emptyXXX(NEW.taskStatus)) THEN SET NEW.taskStatus = 'open_notstarted'; END IF;
--   IF (emptyXXX(NEW.priority)) THEN SET NEW.priority = 3; END IF;
--   IF (emptyXXX(NEW.taskTypeID)) THEN SET NEW.taskTypeID = 'Task'; END IF;
--   IF (NEW.personID) THEN SET NEW.dateAssigned = current_timestamp(); END IF;
--   IF (NEW.closerID) THEN SET NEW.dateClosed = current_timestamp(); END IF;
--   IF (emptyXXX(NEW.timeLimit)) THEN SET NEW.timeLimit = NEW.timeExpected; END IF;
  
--   IF (emptyXXX(NEW.timeLimit) AND NEW.projectID) THEN
--     SELECT defaultTaskLimit INTO defTaskLimit FROM project WHERE projectID = NEW.projectID;
--     SET NEW.timeLimit = defTaskLimit;
--   END IF;
 
--   IF (emptyXXX(NEW.estimatorID) AND (NEW.timeWorst OR NEW.timeBest OR NEW.timeExpected)) THEN
--     SET NEW.estimatorID = personID();
--   END IF;

--   IF (emptyXXX(NEW.timeWorst) AND emptyXXX(NEW.timeBest) AND emptyXXX(NEW.timeExpected)) THEN
--     SET NEW.estimatorID = NULL;
--   END IF;

--   IF (NEW.taskStatus = 'open_inprogress' AND emptyXXX(NEW.dateActualStart)) THEN
--     SET NEW.dateActualStart = current_date();
--   END IF;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_insert_task AFTER INSERT ON task
-- FOR EACH ROW
-- BEGIN
--   call alloc_log("task", NEW.taskID, "created",              NULL, "The task was created.");
--   call alloc_log("task", NEW.taskID, "taskName",             NULL, NEW.taskName);
--   call alloc_log("task", NEW.taskID, "taskDescription",      NULL, NEW.taskDescription);
--   call alloc_log("task", NEW.taskID, "priority",             NULL, NEW.priority);
--   call alloc_log("task", NEW.taskID, "timeLimit",            NULL, NEW.timeLimit);
--   call alloc_log("task", NEW.taskID, "timeBest",             NULL, NEW.timeBest);
--   call alloc_log("task", NEW.taskID, "timeWorst",            NULL, NEW.timeWorst);
--   call alloc_log("task", NEW.taskID, "timeExpected",         NULL, NEW.timeExpected);
--   call alloc_log("task", NEW.taskID, "dateTargetStart",      NULL, NEW.dateTargetStart);
--   call alloc_log("task", NEW.taskID, "dateActualStart",      NULL, NEW.dateActualStart);
--   call alloc_log("task", NEW.taskID, "projectID",            NULL, NEW.projectID);
--   call alloc_log("task", NEW.taskID, "parentTaskID",         NULL, NEW.parentTaskID);
--   call alloc_log("task", NEW.taskID, "taskTypeID",           NULL, NEW.taskTypeID);
--   call alloc_log("task", NEW.taskID, "personID",             NULL, NEW.personID);
--   call alloc_log("task", NEW.taskID, "managerID",            NULL, NEW.managerID);
--   call alloc_log("task", NEW.taskID, "estimatorID",          NULL, NEW.estimatorID);
--   call alloc_log("task", NEW.taskID, "duplicateTaskID",      NULL, NEW.duplicateTaskID);
--   call alloc_log("task", NEW.taskID, "dateTargetCompletion", NULL, NEW.dateTargetCompletion);
--   call alloc_log("task", NEW.taskID, "dateActualCompletion", NULL, NEW.dateActualCompletion);
--   call alloc_log("task", NEW.taskID, "taskStatus",           NULL, NEW.taskStatus);
--   call update_search_index("task",NEW.taskID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- /*!50003 SET @saved_cs_client      = @@character_set_client */ ;
-- /*!50003 SET @saved_cs_results     = @@character_set_results */ ;
-- /*!50003 SET @saved_col_connection = @@collation_connection */ ;
-- /*!50003 SET character_set_client  = utf8mb3 */ ;
-- /*!50003 SET character_set_results = utf8mb3 */ ;
-- /*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
-- /*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
-- /*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_update_task BEFORE UPDATE ON task
-- FOR EACH ROW
-- BEGIN
--   call check_edit_task(OLD.projectID);

--   IF (neq(@in_change_task_status,1) AND neq(OLD.taskStatus,NEW.taskStatus)) THEN
--     call alloc_error('Must use: call change_task_status(taskID,status)');
--   END IF;

--   IF (NEW.parentTaskID) THEN CALL check_for_parent_task_loop(NEW.parentTaskID, OLD.taskID); END IF;

--   SET NEW.taskID = OLD.taskID;
--   SET NEW.creatorID = OLD.creatorID;
--   SET NEW.dateCreated = OLD.dateCreated;
--   SET NEW.taskModifiedUser = personID();

--   IF (emptyXXX(NEW.taskStatus)) THEN
--     SET NEW.taskStatus = OLD.taskStatus;
--   END IF;

--   IF (emptyXXX(NEW.taskStatus)) THEN
--     SET NEW.taskStatus = 'open_notstarted';
--   END IF;

--   IF (NEW.taskStatus = 'open_inprogress' AND neq(NEW.taskStatus, OLD.taskStatus) AND emptyXXX(NEW.dateActualStart)) THEN
--     SET NEW.dateActualStart = current_date();
--   END IF;

--   IF ((SUBSTRING(NEW.taskStatus,1,4) = 'open' OR SUBSTRING(NEW.taskStatus,1,4) = 'pend')) THEN
--     SET NEW.closerID = NULL;  
--     SET NEW.dateClosed = NULL;  
--     SET NEW.dateActualCompletion = NULL;  
--     SET NEW.duplicateTaskID = NULL;  
--   ELSEIF (SUBSTRING(NEW.taskStatus,1,6) = 'closed' AND neq(NEW.taskStatus, OLD.taskStatus)) THEN
--     IF (emptyXXX(NEW.dateActualStart)) THEN SET NEW.dateActualStart = current_date(); END IF;
--     IF (emptyXXX(NEW.dateClosed)) THEN SET NEW.dateClosed = current_timestamp(); END IF;
--     IF (emptyXXX(NEW.closerID)) THEN SET NEW.closerID = personID(); END IF;
--     SET NEW.dateActualCompletion = current_date();
--   END IF;

--   IF (NEW.personID AND neq(NEW.personID, OLD.personID)) THEN
--     SET NEW.dateAssigned = current_timestamp();
--   ELSEIF (emptyXXX(NEW.personID)) THEN
--     SET NEW.dateAssigned = NULL;
--   END IF;

--   IF (NEW.closerID AND neq(NEW.closerID, OLD.closerID)) THEN
--     SET NEW.dateClosed = current_timestamp();
--   ELSEIF (emptyXXX(NEW.closerID)) THEN
--     SET NEW.dateClosed = NULL;
--   END IF;

--   IF ((neq(NEW.timeWorst, OLD.timeWorst) OR neq(NEW.timeBest, OLD.timeBest) OR neq(NEW.timeExpected, OLD.timeExpected))
--   AND emptyXXX(NEW.estimatorID)) THEN
--     SET NEW.estimatorID = personID();
--   END IF;

--   IF (emptyXXX(NEW.timeWorst) AND emptyXXX(NEW.timeBest) AND emptyXXX(NEW.timeExpected)) THEN
--     SET NEW.estimatorID = NULL;
--   END IF;

-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_update_task AFTER UPDATE ON task
-- FOR EACH ROW
-- BEGIN
--   call alloc_log("task", OLD.taskID, "taskName",             OLD.taskName,             NEW.taskName);
--   call alloc_log("task", OLD.taskID, "taskDescription",      OLD.taskDescription,      NEW.taskDescription);
--   call alloc_log("task", OLD.taskID, "priority",             OLD.priority,             NEW.priority);
--   call alloc_log("task", OLD.taskID, "timeLimit",            OLD.timeLimit,            NEW.timeLimit);
--   call alloc_log("task", OLD.taskID, "timeBest",             OLD.timeBest,             NEW.timeBest);
--   call alloc_log("task", OLD.taskID, "timeWorst",            OLD.timeWorst,            NEW.timeWorst);
--   call alloc_log("task", OLD.taskID, "timeExpected",         OLD.timeExpected,         NEW.timeExpected);
--   call alloc_log("task", OLD.taskID, "dateTargetStart",      OLD.dateTargetStart,      NEW.dateTargetStart);
--   call alloc_log("task", OLD.taskID, "dateActualStart",      OLD.dateActualStart,      NEW.dateActualStart);
--   call alloc_log("task", OLD.taskID, "projectID",            OLD.projectID,            NEW.projectID);
--   call alloc_log("task", OLD.taskID, "parentTaskID",         OLD.parentTaskID,         NEW.parentTaskID);
--   call alloc_log("task", OLD.taskID, "taskTypeID",           OLD.taskTypeID,           NEW.taskTypeID);
--   call alloc_log("task", OLD.taskID, "personID",             OLD.personID,             NEW.personID);
--   call alloc_log("task", OLD.taskID, "managerID",            OLD.managerID,            NEW.managerID);
--   call alloc_log("task", OLD.taskID, "estimatorID",          OLD.estimatorID,          NEW.estimatorID);
--   call alloc_log("task", OLD.taskID, "duplicateTaskID",      OLD.duplicateTaskID,      NEW.duplicateTaskID);
--   call alloc_log("task", OLD.taskID, "dateTargetCompletion", OLD.dateTargetCompletion, NEW.dateTargetCompletion);
--   call alloc_log("task", OLD.taskID, "dateActualCompletion", OLD.dateActualCompletion, NEW.dateActualCompletion);
--   call alloc_log("task", OLD.taskID, "taskStatus",           OLD.taskStatus,           NEW.taskStatus);
--   call update_search_index("task",NEW.taskID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_delete_task BEFORE DELETE ON task
-- FOR EACH ROW
-- BEGIN
--   call check_edit_task(OLD.projectID);
--   call check_delete_task(OLD.taskID);
--   DELETE FROM pendingTask WHERE taskID = OLD.taskID OR pendingTaskID = OLD.taskID;
--   DELETE FROM audit WHERE taskID = OLD.taskID;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_insert_timeSheet BEFORE INSERT ON timeSheet
-- FOR EACH ROW
-- BEGIN
--   DECLARE pref_tfID INTEGER;
--   DECLARE cbd BIGINT(20);
--   DECLARE cur VARTEXT;
--   SET NEW.personID = personID();
--   SET NEW.status = 'edit';
--   SELECT preferred_tfID INTO pref_tfID FROM person WHERE personID = personID();
--   SET NEW.recipient_tfID = pref_tfID;
--   SELECT customerBilledDollars,currencyTypeID INTO cbd,cur FROM project WHERE projectID = NEW.projectID;
--   SET NEW.customerBilledDollars = cbd;
--   SET NEW.currencyTypeID = cur;
--   SET NEW.dateFrom = null;
--   SET NEW.dateTo = null;
--   SET NEW.approvedByManagerPersonID = null;
--   SET NEW.approvedByAdminPersonID = null;
--   SET NEW.dateSubmittedToManager = null;
--   SET NEW.dateSubmittedToAdmin = null;
--   SET NEW.dateRejected = null;
--   SET NEW.invoiceDate = null;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_update_timeSheet BEFORE UPDATE ON timeSheet
-- FOR EACH ROW
-- BEGIN
--   DECLARE has_bastard_tasks INTEGER;
--   DECLARE cbd BIGINT(20);
--   DECLARE cur VARTEXT;

--   IF (has_perm(personID(),512,"timeSheet")) THEN
--     SELECT 1 INTO @null;
--   ELSEIF (OLD.status = 'manager' AND NEW.status = 'rejected' AND has_perm(personID(),256,"timeSheet")) THEN
--     SELECT 1 INTO @null;
--   ELSEIF (OLD.status = 'manager' AND NEW.status = 'admin' AND has_perm(personID(),256,"timeSheet")) THEN
--     SELECT 1 INTO @null;
--   ELSEIF (neq(OLD.status, 'edit') AND neq(OLD.status, 'rejected')) THEN
--     call alloc_error('Time sheet is not editable(2).');
--   ELSEIF (neq(NEW.status, 'edit') AND neq(OLD.status, 'rejected') AND using_views()) THEN
--     call alloc_error('Not permitted to change time sheet status.');
--   ELSEIF (using_views()) THEN
    
--     SET NEW.timeSheetID = OLD.timeSheetID;
--     SET NEW.personID = OLD.personID;
--     SET NEW.status = 'edit';
--     SET NEW.recipient_tfID = OLD.recipient_tfID;
--     SET NEW.customerBilledDollars = OLD.customerBilledDollars;
--     SET NEW.currencyTypeID = OLD.currencyTypeID;
--     SET NEW.dateFrom = OLD.dateFrom;
--     SET NEW.dateTo = OLD.dateTo;
--     SET NEW.approvedByManagerPersonID = OLD.approvedByManagerPersonID;
--     SET NEW.approvedByAdminPersonID = OLD.approvedByAdminPersonID;
--     SET NEW.dateSubmittedToManager = OLD.dateSubmittedToManager;
--     SET NEW.dateSubmittedToAdmin = OLD.dateSubmittedToAdmin;
--     SET NEW.dateRejected = OLD.dateRejected;
--     SET NEW.invoiceDate = OLD.invoiceDate;
--   END IF;

--   IF ((OLD.status = 'edit' AND NEW.status = 'edit') OR (OLD.status = 'rejected' AND NEW.status = 'rejected')) AND neq(OLD.projectID,NEW.projectID) THEN
--     SELECT count(*) INTO has_bastard_tasks FROM timeSheetItem
--  LEFT JOIN timeSheet ON timeSheet.timeSheetID = timeSheetItem.timeSheetID
--  LEFT JOIN task ON timeSheetItem.taskID = task.taskID
--      WHERE task.projectID != NEW.projectID
--        AND timeSheetItem.timeSheetID = OLD.timeSheetID;
--     IF has_bastard_tasks THEN
--       call alloc_error("Task belongs to wrong project.");
--     END IF;

--     SELECT customerBilledDollars,currencyTypeID INTO cbd,cur FROM project WHERE projectID = NEW.projectID;
--     SET NEW.customerBilledDollars = cbd;
--     SET NEW.currencyTypeID = cur;
--     UPDATE timeSheetItem
--        SET rate = (SELECT rate FROM projectPerson WHERE projectID = NEW.projectID AND personID = personID() LIMIT 1)
--      WHERE timeSheetID = OLD.timeSheetID;

--   END IF;
-- END */;;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_delete_timeSheet BEFORE DELETE ON timeSheet
-- FOR EACH ROW
-- BEGIN
--   DECLARE num_timeSheetItems INTEGER;

--   IF (neq(OLD.status, 'edit') AND neq(OLD.status, 'rejected')) THEN
--     call alloc_error('Not permitted to delete time sheet unless status is edit.');
--   END IF;

--   SELECT count(timeSheetID) INTO num_timeSheetItems FROM timeSheetItem WHERE timeSheetID = OLD.timeSheetID;
--   IF (num_timeSheetItems > 0) THEN
--     call alloc_error('Not permitted to delete time sheet that has items.');
--   END IF;
-- END */;;
-- DELIMITER ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_insert_timeSheetItem BEFORE INSERT ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   DECLARE validDate DATE;
--   DECLARE pID INTEGER;
--   DECLARE r BIGINT(20);
--   DECLARE rUnitID INTEGER;
--   DECLARE description TEXT;
--   DECLARE dClosed DATETIME;
--   DECLARE taskWindow INTEGER;
--   call check_edit_timeSheet(NEW.timeSheetID);

--   SET NEW.timeSheetItemCreatedUser = personID();
--   SET NEW.timeSheetItemCreatedTime = current_timestamp();

--   SELECT IFNULL(value,0) INTO taskWindow FROM config WHERE name = 'taskWindow';
--   SELECT dateClosed INTO dClosed FROM task WHERE taskID = NEW.taskID;

--   IF NEW.taskID AND taskWindow AND dClosed THEN
--     IF now() > DATE_ADD(dClosed, INTERVAL taskWindow DAY) THEN
--       call alloc_error("Time not recorded. Task has been closed for too long.");
--     END IF;
--   END IF;

--   SELECT DATE(NEW.dateTimeSheetItem) INTO validDate;
--   IF (validDate = '0000-00-00') THEN
--     call alloc_error("Invalid date.");
--   END IF;

--   IF (NEW.timeSheetItemDuration IS NULL OR NEW.timeSheetItemDuration < 0) THEN
--     call alloc_error("Invalid time duration.");
--   END IF;

--   SET NEW.personID = personID();
--   SELECT projectID INTO pID FROM timeSheet WHERE timeSheet.timeSheetID = NEW.timeSheetID;
--   SELECT rate,rateUnitID INTO r,rUnitID FROM projectPerson WHERE projectID = pID AND personID = personID() LIMIT 1;

  
--   IF (neq(NEW.rate,r) AND NOT can_edit_rate(personID(),pID)) THEN
--     call alloc_error("Time sheet's rate is not editable.");
--   END IF;

--   IF (NEW.rate IS NULL AND r) THEN
--     SET NEW.rate = r;
--     SET NEW.timeSheetItemDurationUnitID = rUnitID;
--   END IF;

--   IF (NEW.taskID) THEN
--     SELECT taskName INTO description FROM task WHERE taskID = NEW.taskID;
--     SET NEW.description = description;
--   END IF;

-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_insert_timeSheetItem AFTER INSERT ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   DECLARE isTask BOOLEAN;
--   call updateTimeSheetDates(NEW.timeSheetID);

--   SELECT count(*) INTO isTask FROM task WHERE taskID = NEW.taskID AND taskStatus = 'open_notstarted';
--   IF (isTask) THEN
--     call change_task_status(NEW.taskID,'open_inprogress');
--   END IF;
--   UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = NEW.taskID)
--    WHERE taskID = NEW.taskID;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_update_timeSheetItem BEFORE UPDATE ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   DECLARE validDate DATE;
--   DECLARE pID INTEGER;
--   DECLARE r BIGINT(20);
--   DECLARE rUnitID INTEGER;
--   DECLARE taskTitle TEXT;
--   call check_edit_timeSheet(OLD.timeSheetID);

--   SET NEW.timeSheetItemModifiedUser = personID();
--   SET NEW.timeSheetItemModifiedTime = current_timestamp();

--   SELECT DATE(NEW.dateTimeSheetItem) INTO validDate;
--   IF (validDate = '0000-00-00') THEN
--     call alloc_error("Invalid date.");
--   END IF;

--   IF (NEW.timeSheetItemDuration IS NULL OR NEW.timeSheetItemDuration < 0) THEN
--     call alloc_error("Invalid time duration.");
--   END IF;

--   SET NEW.timeSheetItemID = OLD.timeSheetItemID;
--   SET NEW.personID = OLD.personID;
--   SELECT projectID INTO pID FROM timeSheet WHERE timeSheet.timeSheetID = NEW.timeSheetID;
--   SELECT rate,rateUnitID INTO r,rUnitID FROM projectPerson WHERE projectID = pID AND personID = OLD.personID LIMIT 1;

  
--   IF (neq(NEW.rate,r) AND NOT can_edit_rate(personID(),pID)) THEN
--     call alloc_error("Time sheet's rate is not editable.");
--   END IF;

--   IF (NEW.rate IS NULL AND r) THEN
--     SET NEW.rate = r;
--     SET NEW.timeSheetItemDurationUnitID = rUnitID;
--   END IF;
--   SELECT taskName INTO taskTitle FROM task WHERE taskID = NEW.taskID;
--   SET NEW.description = taskTitle;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_update_timeSheetItem AFTER UPDATE ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   IF (neq(OLD.dateTimeSheetItem, NEW.dateTimeSheetItem)) THEN
--     call updateTimeSheetDates(NEW.timeSheetID);
--   END IF;
--   UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = NEW.taskID)
--    WHERE taskID = NEW.taskID;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER before_delete_timeSheetItem BEFORE DELETE ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   call check_edit_timeSheet(OLD.timeSheetID);
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER after_delete_timeSheetItem AFTER DELETE ON timeSheetItem
-- FOR EACH ROW
-- BEGIN
--   call updateTimeSheetDates(OLD.timeSheetID);
--   UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = OLD.taskID)
--    WHERE taskID = OLD.taskID;
-- END */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
