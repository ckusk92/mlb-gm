-- MySQL Script generated by MySQL Workbench
-- Tue Nov 10 17:58:44 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `league_test` DEFAULT CHARACTER SET utf8 ;
drop database if exists league_test;
create database league_test;
USE `league_test` ;

-- -----------------------------------------------------
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player` ;

CREATE TABLE IF NOT EXISTS `player` (
  `player_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `position_id` INT NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `player_position_id`
    FOREIGN KEY (`position_id`)
    REFERENCES `position` (`position_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `user_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_team` ;

CREATE TABLE IF NOT EXISTS `user_team` (
  `user_team_id` INT NOT NULL AUTO_INCREMENT,
  `app_user_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `user_controlled` TINYINT NOT NULL DEFAULT 0,
  `rating` INT NOT NULL,
  INDEX `app_user_id_idx` (`app_user_id` ASC) VISIBLE,
  INDEX `team_id_idx` (`team_id` ASC) VISIBLE,
  PRIMARY KEY (`user_team_id`),
  CONSTRAINT `app_user_id`
    FOREIGN KEY (`app_user_id`)
    REFERENCES `app_user` (`app_user_id`),
  CONSTRAINT `team_id`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`team_id`)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `game_id` INT NOT NULL AUTO_INCREMENT,
  `home_team_id` INT NOT NULL,
  `away_team_id` INT NOT NULL,
  `game_number` INT NOT NULL,
  `home_score` INT NULL,
  `away_score` INT NULL,
  `played` TINYINT NOT NULL,
  INDEX `home_team_id_idx` (`away_team_id` ASC, `home_team_id` ASC) VISIBLE,
  PRIMARY KEY (`game_id`),
  CONSTRAINT `home_team_id`
    FOREIGN KEY (`home_team_id`)
    REFERENCES `user_team` (`user_team_id`),
  CONSTRAINT `away_team_id`
    FOREIGN KEY (`away_team_id`)
    REFERENCES `user_team` (`user_team_id`)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team_player` ;

CREATE TABLE IF NOT EXISTS `team_player` (
  `team_player_id` INT NOT NULL AUTO_INCREMENT,
  `user_team_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`team_player_id`),
  INDEX `user_team_id_idx` (`user_team_id` ASC) VISIBLE,
  INDEX `player_id_idx` (`player_id` ASC) VISIBLE,
  CONSTRAINT `user_team_id`
    FOREIGN KEY (`user_team_id`)
    REFERENCES `user_team` (`user_team_id`),
  CONSTRAINT `player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `player` (`player_id`)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `record` ;

CREATE TABLE IF NOT EXISTS `record` (
  `user_team_id` INT NOT NULL,
  `win` INT NOT NULL,
  `loss` INT NOT NULL,
  CONSTRAINT `record_user_team_id`
    FOREIGN KEY (`user_team_id`)
    REFERENCES `user_team` (`user_team_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `position` ;

CREATE TABLE IF NOT EXISTS `position` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`position_id`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `app_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_user` ;

CREATE TABLE IF NOT EXISTS `app_user` (
  `app_user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password_hash` VARCHAR(2048) NOT NULL,
  `disabled` boolean not null default(0),
  PRIMARY KEY (`app_user_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `app_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_role` ;

CREATE TABLE IF NOT EXISTS `app_role` (
  `app_role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (`app_role_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `app_user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_user_role` ;

CREATE TABLE IF NOT EXISTS `app_user_role` (
  `app_user_id` INT NOT NULL,
  `app_role_id` INT NOT NULL,
  CONSTRAINT pk_app_user_role
    PRIMARY KEY (app_user_id, app_role_id),
  CONSTRAINT fk_app_user_role_user_id
    FOREIGN KEY (app_user_id)
    REFERENCES app_user(app_user_id),
  CONSTRAINT fk_app_user_role_app_role_id
    FOREIGN KEY (app_role_id)
    REFERENCES app_role(app_role_id))
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


delimiter //
create procedure set_known_good_state()
begin

  delete from game;
  alter table game auto_increment = 1;

  delete from record;
  -- alter table record auto_increment = 1;

  delete from team_player;
  alter table team_player auto_increment = 1;

  delete from user_team;
  alter table user_team auto_increment = 1;

  delete from team;
  alter table team auto_increment = 1;

  delete from player;
  alter table player auto_increment = 1;

  delete from position;
  alter table position auto_increment = 1;

  delete from app_user_role;
  -- alter table app_user_role auto_increment = 1;

  delete from app_user;
  alter table app_user auto_increment = 1;

  delete from app_role;
  alter table app_role auto_increment = 1;

  insert into app_user (app_user_id, username, password_hash, disabled)
    values (1, 'username', 'password', 0);

  insert into app_role(`name`)
    values ('USER'),
           ('ADMIN');

  insert into app_user_role(app_user_id, app_role_id)
	values (1, 1);

  insert into position (position_id, position)
    values (1, 'P'),
           (2, 'C'),
           (3, '1B'),
           (4, '2B'),
           (5, '3B'),
           (6, 'SS'),
           (7, 'LF'),
           (8, 'CF'),
           (9, 'RF');

  insert into team (name)
  values ('Atlanta Braves'),
       ('Florida Marlins'),
       ('Philadelphia Phillies'),
       ('Washington Nationals'),
       ('New York Mets'),
       ('Chicago Cubs'),
       ('St. Louis Cardinals'),
       ('Cincinatti Reds');

  insert into player (first_name, last_name, position_id, rating)
  values ('Chance', 'Macfarlane', 1, 52),     
         ('Mitch', 'Garver', 2, 82),
         ('Christian', 'Vasquez', 2, 82),
         ('Tom', 'Murphy', 2, 82),
         ('Yadier', 'Molina', 2, 81),
         ('Salvador', 'Perez', 2, 81),
         ('Willson', 'Conteras', 2, 81),
         ('Yasir', 'Grey', 3, 51),
         ('Connor', 'Rasmussen', 3, 63),
         ('Isaak', 'English', 3, 83),
         ('Johnny', 'Wilkinson', 3, 68);

  insert into app_user (username, password_hash, disabled)
  values ('user1', 'password', 0),
         ('user2', 'password', 0);

  insert into user_team (app_user_id, team_id, user_controlled, rating)
  values (1, 1, true, 80), (1, 2, false, 75), (1, 3, false, 82), (1, 4, false, 69),
         (2, 5, true, 73), (2, 6, false, 77), (2, 7, false, 85), (2, 8, false, 61);

  insert into game (game_id, home_team_id, away_team_id, game_number, home_score, away_score, played)
  values (1, 1, 1, 1, 0, 0, false), (2, 3, 4, 1, 0, 0, false), (3, 1, 3, 2, 0, 0, false), (4, 2, 4, 2, 0, 0, false);

  insert into team_player (user_team_id, player_id, rating)
  values (1, 1, 50), (1, 2, 50), (1, 3, 50), (1, 4, 50), (1, 5, 50),
         (2, 6, 50), (2, 7, 50), (2, 8, 50), (2, 9, 50), (2, 10, 50);

  insert into record (user_team_id, win, loss)
  values (1, 5, 4), (2, 4, 5), (3, 9, 0), (4, 0, 9);

end //

delimiter ;  
