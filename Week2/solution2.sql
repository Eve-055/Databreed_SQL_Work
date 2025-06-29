vim solution.sql-- MySQL Workbench Forward Engineering

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
-- Table `mydb`.`Products_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products_table` (
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(50) NULL,
  `quantity_bought` INT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Components_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Components_table` (
  `component_id` INT NOT NULL,
  `component_name` VARCHAR(45) NULL,
  `component_description` VARCHAR(100) NULL,
  `suppliers_name` VARCHAR(50) NULL,
  `product_id` INT NULL,
  PRIMARY KEY (`component_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(100) NULL,
  `supplier_location` VARCHAR(100) NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_component`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_component` (
  `prod_comp_id` INT NOT NULL,
  `product_id` INT NULL,
  `component_id` INT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`prod_comp_id`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  INDEX `component_id_idx` (`component_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`Products_table` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `component_id`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Components_table` (`component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier_Component table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier_Component table` (
  `supplier-comp_id` INT NOT NULL,
  `component_id` INT NULL,
  `supplier_id` INT NULL,
  `price` INT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`supplier-comp_id`),
  INDEX `component_id_idx` (`component_id` ASC) VISIBLE,
  INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `component_id`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Components_table` (`component_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supplier_id`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `mydb`.`Supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

