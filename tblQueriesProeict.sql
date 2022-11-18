CREATE SCHEMA `blooddonortable` ;
CREATE TABLE `blooddonortable`.`seeker` (
  `idseeker` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `age` SMALLINT UNSIGNED NULL,
  `city` VARCHAR(45) NULL,
  `bloodgroup` VARCHAR(45) NULL,
  `cnp` VARCHAR(45) NULL,
  PRIMARY KEY (`idseeker`));

CREATE TABLE `blooddonortable`.`hospital` (
  `idhospital` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `website` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idhospital`));

CREATE TABLE `blooddonortable`.`bloodbank` (
  `idbloodbank` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(255) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idbloodbank`));

CREATE TABLE `blooddonortable`.`bloodbag` (
  `idbloodbag` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bloodgroup` VARCHAR(45) NULL,
  `quantity` FLOAT NULL,
  `expirationdate` DATE NULL,
  `donor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idbloodbag`));

CREATE TABLE `blooddonortable`.`donor` (
  `iddonor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `age` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `phonenumber` VARCHAR(45) NULL,
  `cnp` VARCHAR(45) NULL,
  `bloodDonated` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`iddonor`),
  INDEX `fk_bloodbag_idx` (`bloodDonated` ASC) VISIBLE,
  CONSTRAINT `fk_bloodbag`
    FOREIGN KEY (`bloodDonated`)
    REFERENCES `blooddonortable`.`bloodbag` (`idbloodbag`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE `blooddonortable`.`request` (
  `idrequest` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `requestdate` DATE NULL,
  `hospital` INT UNSIGNED NOT NULL,
  `bloodbank` INT UNSIGNED NOT NULL,
  `bloodbag` INT UNSIGNED NOT NULL,
  `seeker` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idrequest`),
  INDEX `fk_hospital_idx` (`hospital` ASC) VISIBLE,
  INDEX `fk_bloodbank_idx` (`bloodbank` ASC) VISIBLE,
  INDEX `fk_bloodbag_idx` (`bloodbag` ASC) VISIBLE,
  INDEX `fk_seeker_idx` (`seeker` ASC) VISIBLE,
  CONSTRAINT `fk_hospital`
    FOREIGN KEY (`hospital`)
    REFERENCES `blooddonortable`.`hospital` (`idhospital`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bloodbank`
    FOREIGN KEY (`bloodbank`)
    REFERENCES `blooddonortable`.`bloodbank` (`idbloodbank`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bloodbag`
    FOREIGN KEY (`bloodbag`)
    REFERENCES `blooddonortable`.`bloodbag` (`idbloodbag`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_seeker`
    FOREIGN KEY (`seeker`)
    REFERENCES `blooddonortable`.`seeker` (`idseeker`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

ALTER TABLE `blooddonortable`.`donor` 
    DROP COLUMN `bloodDonated`,
    DROP INDEX `fk_bloodbag_idx` ;
;

ALTER TABLE `blooddonortable`.`bloodbag` 
ADD CONSTRAINT `fk_donor`
  FOREIGN KEY (`donor`)
  REFERENCES `blooddonortable`.`donor` (`iddonor`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `blooddonortable`.`bloodbag` 
DROP FOREIGN KEY `fk_donor`;
ALTER TABLE `blooddonortable`.`bloodbag` 
ADD COLUMN `bloodbankId` INT UNSIGNED NOT NULL AFTER `donor`,
DROP INDEX `fk_donor_idx` ;
;

ALTER TABLE `blooddonortable`.`bloodbag` 
ADD INDEX `fk_bloodbankId_idx` (`bloodbankId` ASC) VISIBLE;
;
ALTER TABLE `blooddonortable`.`bloodbag` 
ADD CONSTRAINT `fk_bloodbankId`
  FOREIGN KEY (`bloodbankId`)
  REFERENCES `blooddonortable`.`bloodbank` (`idbloodbank`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;