-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema logeo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema logeo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `logeo` DEFAULT CHARACTER SET utf8 ;
USE `logeo` ;

-- -----------------------------------------------------
-- Table `logeo`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logeo`.`administrador` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logeo`.`atentificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logeo`.`atentificacion` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `administrador_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_atentificacion_administrador1_idx` (`administrador_id` ASC) VISIBLE,
  CONSTRAINT `fk_atentificacion_administrador1`
    FOREIGN KEY (`administrador_id`)
    REFERENCES `logeo`.`administrador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logeo`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logeo`.`usuarios` (
  `name` VARCHAR(50) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `atentificacion_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_usuarios_atentificacion1_idx` (`atentificacion_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_atentificacion1`
    FOREIGN KEY (`atentificacion_id`)
    REFERENCES `logeo`.`atentificacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `logeo`.`usuario_regular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logeo`.`usuario_regular` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logeo`.`usuario_regular_has_atentificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logeo`.`usuario_regular_has_atentificacion` (
  `usuario_regular_id` INT NOT NULL,
  `atentificacion_id` INT NOT NULL,
  PRIMARY KEY (`usuario_regular_id`, `atentificacion_id`),
  INDEX `fk_usuario_regular_has_atentificacion_atentificacion1_idx` (`atentificacion_id` ASC) VISIBLE,
  INDEX `fk_usuario_regular_has_atentificacion_usuario_regular1_idx` (`usuario_regular_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_regular_has_atentificacion_usuario_regular1`
    FOREIGN KEY (`usuario_regular_id`)
    REFERENCES `logeo`.`usuario_regular` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_regular_has_atentificacion_atentificacion1`
    FOREIGN KEY (`atentificacion_id`)
    REFERENCES `logeo`.`atentificacion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
