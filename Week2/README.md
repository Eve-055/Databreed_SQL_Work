-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Team` (
  `team_id` INT NOT NULL,
  `team_name` VARCHAR(100) NULL,
  `team_stadium` VARCHAR(100) NULL,
  `team_city` VARCHAR(100) NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Match` (
  `match_id` INT NOT NULL,
  `match_date` DATE NULL,
  `host_team_id` INT NULL,
  `guest_team_id` INT NULL,
  `stadium` VARCHAR(100) NULL,
  `final_result` INT NULL,
  PRIMARY KEY (`match_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Referee` (
  `referee_id` INT NOT NULL,
  `referee_name` VARCHAR(100) NULL,
  `DOB` DATE NULL,
  `year_of_experience` DATE NULL,
  PRIMARY KEY (`referee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Match_referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Match_referee` (
  `match_id/referee_id` INT NOT NULL,
  `match_id` INT NULL,
  `referee_id` INT NULL,
  `role` VARCHAR(50) NULL,
  PRIMARY KEY (`match_id/referee_id`),
  INDEX `match_id_idx` (`match_id` ASC) VISIBLE,
  INDEX `referee_id_idx` (`referee_id` ASC) VISIBLE,
  CONSTRAINT `match_id`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`Match` (`match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `referee_id`
    FOREIGN KEY (`referee_id`)
    REFERENCES `mydb`.`Referee` (`referee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Players` (
  `player_id` INT NOT NULL,
  `player_name` VARCHAR(100) NULL,
  `team_id` INT NULL,
  `player_DOB` DATE NULL,
  `player_shirt_no` INT NULL,
  `player_start_year` DATE NULL,
  PRIMARY KEY (`player_id`),
  INDEX `team_id_idx` (`team_id` ASC) VISIBLE,
  CONSTRAINT `team_id`
    FOREIGN KEY (`team_id`)
    REFERENCES `mydb`.`Team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Substitution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Substitution` (
  `substitution_id` INT NOT NULL,
  `match_id` INT NULL,
  `player_out_id` INT NULL,
  `player_in_id` INT NULL,
  `Substitution_time` TIME NULL,
  PRIMARY KEY (`substitution_id`),
  UNIQUE INDEX `idtable1_UNIQUE` (`substitution_id` ASC) VISIBLE,
  INDEX `match_id_idx` (`match_id` ASC) VISIBLE,
  CONSTRAINT `match_id`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`Match` (`match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Player_Match_PPN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Player_Match_PPN` (
  `player_match_ppnID` INT NOT NULL,
  `player_id` INT NULL,
  `match_id` INT NULL,
  `goals_scored` INT NULL,
  `yellow_card` INT NULL,
  `red_card` INT NULL,
  PRIMARY KEY (`player_match_ppnID`),
  INDEX `player_id_idx` (`player_id` ASC) VISIBLE,
  INDEX `match_id_idx` (`match_id` ASC) VISIBLE,
  CONSTRAINT `player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `mydb`.`Players` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `match_id`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`Match` (`match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
