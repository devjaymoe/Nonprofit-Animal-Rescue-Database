-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema NonprofitAnimalShelter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NonprofitAnimalShelter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NonprofitAnimalShelter` DEFAULT CHARACTER SET utf8 ;
USE `NonprofitAnimalShelter` ;

-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Persons` (
  `idPersons` INT NOT NULL AUTO_INCREMENT,
  `FName` VARCHAR(45) NOT NULL,
  `LName` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(20) NULL,
  `BackgroundCheck` TINYINT NULL,
  `Address` VARCHAR(105) NULL,
  PRIMARY KEY (`idPersons`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Adoptors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Adoptors` (
  `AdoptorID` INT NOT NULL,
  `PersonID` INT NOT NULL,
  PRIMARY KEY (`AdoptorID`),
  INDEX `PersonsID_idx` (`PersonID` ASC) VISIBLE,
  CONSTRAINT `PersonsID`
    FOREIGN KEY (`PersonID`)
    REFERENCES `NonprofitAnimalShelter`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Employees` (
  `idEmployee` INT NOT NULL,
  `PersonID` INT NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `PersonsID_idx` (`PersonID` ASC) VISIBLE,
  CONSTRAINT `PersonID`
    FOREIGN KEY (`PersonID`)
    REFERENCES `NonprofitAnimalShelter`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Fosters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Fosters` (
  `idFoster` INT NOT NULL,
  `PersonsID` INT NOT NULL,
  PRIMARY KEY (`idFoster`),
  INDEX `PersonsID_idx` (`PersonsID` ASC) VISIBLE,
  CONSTRAINT `PID`
    FOREIGN KEY (`PersonsID`)
    REFERENCES `NonprofitAnimalShelter`.`Persons` (`idPersons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Adoptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Adoptions` (
  `idAdoptions` INT NOT NULL,
  `AdoptorID` INT NOT NULL,
  `AdoptionDate` DATETIME NOT NULL,
  PRIMARY KEY (`idAdoptions`),
  INDEX `AdoptorID_idx` (`AdoptorID` ASC) VISIBLE,
  CONSTRAINT `AdoptorID`
    FOREIGN KEY (`AdoptorID`)
    REFERENCES `NonprofitAnimalShelter`.`Adoptors` (`AdoptorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Fostering`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Fostering` (
  `idFostering` INT NOT NULL,
  `FosterDate` DATETIME NOT NULL,
  `FosterID` INT NOT NULL,
  PRIMARY KEY (`idFostering`),
  INDEX `FosterID_idx` (`FosterID` ASC) VISIBLE,
  CONSTRAINT `FosterID`
    FOREIGN KEY (`FosterID`)
    REFERENCES `NonprofitAnimalShelter`.`Fosters` (`idFoster`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`Dogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`Dogs` (
  `idDog` INT NOT NULL,
  `FosterPlacement` INT NOT NULL,
  `AdoptionStatus` INT NULL,
  `Intake Reason` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDog`),
  INDEX `FosterPlacement_idx` (`FosterPlacement` ASC) VISIBLE,
  INDEX `AdoptionStatus_idx` (`AdoptionStatus` ASC) VISIBLE,
  CONSTRAINT `FosterPlacement`
    FOREIGN KEY (`FosterPlacement`)
    REFERENCES `NonprofitAnimalShelter`.`Fostering` (`idFostering`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AdoptionStatus`
    FOREIGN KEY (`AdoptionStatus`)
    REFERENCES `NonprofitAnimalShelter`.`Adoptions` (`idAdoptions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NonprofitAnimalShelter`.`MedicalRecords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NonprofitAnimalShelter`.`MedicalRecords` (
  `idMedicalRecords` INT NOT NULL,
  `DogID` INT NOT NULL,
  `SpayStatus` TINYINT NULL,
  `Age` INT NULL,
  `Breed` VARCHAR(45) NULL,
  `Treatments` VARCHAR(105) NULL,
  `Microchip` INT NULL,
  PRIMARY KEY (`idMedicalRecords`),
  INDEX `DogID_idx` (`DogID` ASC) VISIBLE,
  CONSTRAINT `DogID`
    FOREIGN KEY (`DogID`)
    REFERENCES `NonprofitAnimalShelter`.`Dogs` (`idDog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
