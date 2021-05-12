-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema final
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema final
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `final` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `final` ;
-- -----------------------------------------------------
-- Table `final`.`vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`vendor` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`stock` (
  `id` INT NOT NULL,
  `cost` INT NOT NULL,
  `num_stock` INT NOT NULL,
  `vendor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `vendor_stock_idx` (`vendor` ASC) ,
  CONSTRAINT `vendor_stock`
    FOREIGN KEY (`vendor`)
    REFERENCES `final`.`vendor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`drinks` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `drink_size` VARCHAR(10) NOT NULL,
  `stock_id` INT NOT NULL,
  PRIMARY KEY (`id`, `stock_id`),
  INDEX `fk_drinks_stock1_idx` (`stock_id` ASC) ,
  CONSTRAINT `fk_drinks_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `final`.`stock` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`food` (
  `id` INT NOT NULL,
  `food` VARCHAR(255) NOT NULL,
  `stock_id` INT NOT NULL,
  PRIMARY KEY (`id`, `stock_id`),
  INDEX `ingrediants_stock_idx` (`stock_id` ASC) ,
  CONSTRAINT `ingrediants_stock`
    FOREIGN KEY (`stock_id`)
    REFERENCES `final`.`stock` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`combos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`combos` (
  `id` INT NOT NULL,
  `drink` INT NOT NULL,
  `food` INT NOT NULL,
  `combos_name` VARCHAR(45) NOT NULL,
  `combo_cost` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `drinks_combos_fk_idx` (`drink` ASC) ,
  INDEX `ingrediatns_comdos_fk_idx` (`food` ASC) ,
  UNIQUE INDEX `unigue_combo` (`drink` ASC, `food` ASC) ,
  CONSTRAINT `drinks_combos_fk`
    FOREIGN KEY (`drink`)
    REFERENCES `final`.`drinks` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ingrediatns_comdos_fk`
    FOREIGN KEY (`food`)
    REFERENCES `final`.`food` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`customers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `payment_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`employee_ranks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`employee_ranks` (
  `id` INT NOT NULL,
  `employee_rank` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '			';


-- -----------------------------------------------------
-- Table `final`.`salaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`salaries` (
  `id` INT NOT NULL,
  `pay_week` DATE NULL,
  `pay_wage` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`schedules` (
  `id` INT NOT NULL,
  `next_shift_start` TIMESTAMP NOT NULL,
  `next_shift_end` TIMESTAMP NOT NULL,
  `total_weekly_houres` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`employment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`employment_history` (
  `id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_date` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`employees` (
  `id` INT NOT NULL,
  `salary` INT NOT NULL,
  `employee_rank` INT NOT NULL,
  `employee_schedule` INT NOT NULL,
  `employee_history` INT NOT NULL,
  `employee_name` VARCHAR(45) NOT NULL,
  INDEX `rank_employee_fk_idx` (`employee_rank` ASC) ,
  INDEX `salary_employee_idx` (`salary` ASC) ,
  INDEX `scedules_employee_idx` (`employee_schedule` ASC) ,
  INDEX `history_employees_fk_idx` (`employee_history` ASC) ,
  PRIMARY KEY (`id`),
  CONSTRAINT `rank_employee_fk`
    FOREIGN KEY (`employee_rank`)
    REFERENCES `final`.`employee_ranks` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `salary_employee`
    FOREIGN KEY (`salary`)
    REFERENCES `final`.`salaries` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `scedules_employee`
    FOREIGN KEY (`employee_schedule`)
    REFERENCES `final`.`schedules` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `history_employees_fk`
    FOREIGN KEY (`employee_history`)
    REFERENCES `final`.`employment_history` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`orders` (
  `id` INT NOT NULL,
  `total_cost` DOUBLE NOT NULL DEFAULT 0.0,
  `customer_id` INT NOT NULL,
  `combo_quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `customer_order_idx` (`customer_id` ASC) ,
  CONSTRAINT `customer_order`
    FOREIGN KEY (`customer_id`)
    REFERENCES `final`.`customers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`combos_has_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`combos_has_orders` (
  `combos_id` INT NOT NULL,
  `orders_id` INT NOT NULL,
  PRIMARY KEY (`combos_id`, `orders_id`),
  INDEX `fk_combos_has_orders_orders1_idx` (`orders_id` ASC) ,
  INDEX `fk_combos_has_orders_combos1_idx` (`combos_id` ASC) ,
  CONSTRAINT `fk_combos_has_orders_combos1`
    FOREIGN KEY (`combos_id`)
    REFERENCES `final`.`combos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_combos_has_orders_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `final`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`employees_has_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`employees_has_orders` (
  `employees_id` INT NOT NULL,
  `orders_id` INT NOT NULL,
  PRIMARY KEY (`employees_id`, `orders_id`),
  INDEX `fk_employees_has_orders_orders1_idx` (`orders_id` ASC) ,
  INDEX `fk_employees_has_orders_employees1_idx` (`employees_id` ASC) ,
  CONSTRAINT `fk_employees_has_orders_employees1`
    FOREIGN KEY (`employees_id`)
    REFERENCES `final`.`employees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employees_has_orders_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `final`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `final`.`vendor`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (1, 'Pepsi', '3453 Jackson St, Dubuque, IA 52001', '6082453348');
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (2, 'Tyson', '5218 Elm St, Dubuque, IA 52001', '6084459821');
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (3, 'General Mills', '3453 45 St, Dubuque, IA 52001', '6083421776');

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`stock`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (1, 2, 14, 1);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (3, 2, 10, 1);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (5, 2, 8, 1);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (2, 4, 50, 2);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (4, 5, 45, 2);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (6, 6, 35, 3);
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (8, 3, 25, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`drinks`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (1, 'Coke', 'Small', 1);
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (2, 'Coke', 'Large', 1);
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (3, 'Sprite', 'Small', 3);
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (4, 'Sprite', 'Large', 3);
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (5, 'Water', 'Small', 5);
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (6, 'Water', 'Large', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`food`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`food` (`id`, `food`, `stock_id`) VALUES (1, 'Burger', 2);
INSERT INTO `final`.`food` (`id`, `food`, `stock_id`) VALUES (2, 'Chicken Strips', 4);
INSERT INTO `final`.`food` (`id`, `food`, `stock_id`) VALUES (3, 'Burrito', 6);
INSERT INTO `final`.`food` (`id`, `food`, `stock_id`) VALUES (4, 'Pancakes', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`combos`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (id, drink, food, 'combos_name', combo_cost);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (1, 1, 1, 'Burger 1', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (2, 2, 1, 'Burger 2', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (3, 3, 1, 'Burger 3', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (4, 4, 1, 'Burger 4', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (5, 5, 1, 'Burger 5', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (6, 6, 1, 'Burger 6', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (7, 1, 2, 'Chicken Strips 1', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (8, 2, 2, 'Chicken Strips 2', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (9, 3, 2, 'Chicken Strips 3', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (10, 4, 2, 'Chicken Strips 4', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (11, 5, 2, 'Chicken Strips 5', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (12, 6, 2, 'Chicken Strips 6', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (13, 1, 3, 'Burrito 1', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (14, 2, 3, 'Burrito 2', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (15, 3, 3, 'Burrito 3', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (16, 4, 3, 'Burrito 4', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (17, 5, 3, 'Burrito 5', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (18, 6, 3, 'Burrito 6', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (19, 1, 4, 'Pancakes 1', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (20, 2, 4, 'Pancakes 2', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (21, 3, 4, 'Pancakes 3', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (22, 4, 4, 'Pancakes 4', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (23, 5, 4, 'Pancakes 5', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (24, 6, 4, 'Pancakes 6', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`customers` (`id`, `name`, `payment_type`) VALUES (1, 'Matt Giannola', 'Credit');
INSERT INTO `final`.`customers` (`id`, `name`, `payment_type`) VALUES (2, 'Connor Johnston', 'Cash');
INSERT INTO `final`.`customers` (`id`, `name`, `payment_type`) VALUES (3, 'Matt Mandil', 'Debit');
INSERT INTO `final`.`customers` (`id`, `name`, `payment_type`) VALUES (4, 'George Zeller', 'Check');

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`employee_ranks`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (1, 'Manager');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (2, 'Food Service Worker');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (3, 'Food Service Worker');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (4, 'Manager');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (5, 'Manager');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (6, 'Food Service Worker');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (7, 'Food Service Worker');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (8, 'Food Service Worker');

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`salaries`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (id, 'pay_week', pay_wage);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (1, '2021-05-20', 12.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (2, '2021-05-20', 10.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (3, '2021-05-20', 10.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (4, '2021-05-20', 13.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (5, '2021-05-20', 14.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (6, '2021-05-20', 9.00);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (7, '2021-05-20', 9.50);
INSERT INTO `final`.`salaries` (`id`, `pay_week`, `pay_wage`) VALUES (8, '2021-05-20', 9.25);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`schedules`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (1, '2021-05-18 08:00:00', '2021-05-18 04:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (2, '2021-05-18 08:00:00', '2021-05-18 04:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (3, '2021-05-18 08:00:00', '2021-05-18 04:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (4, '2021-05-18 08:00:00', '2021-05-18 04:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (5, '2021-05-18 04:00:00', '2021-05-19 12:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (6, '2021-05-18 04:00:00', '2021-05-19 12:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (7, '2021-05-18 04:00:00', '2021-05-19 12:00:00', 8);
INSERT INTO `final`.`schedules` (`id`, `next_shift_start`, `next_shift_end`, `total_weekly_houres`) VALUES (8, '2021-05-18 04:00:00', '2021-05-19 12:00:00', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`employment_history`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (1, '2020-03-25', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (2, '2020-05-15', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (3, '2021-02-15', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (4, '2018-11-14', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (5, '2020-09-04', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (6, '2019-08-01', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (7, '2021-04-18', NULL);
INSERT INTO `final`.`employment_history` (`id`, `start_time`, `end_date`) VALUES (8, '2020-12-14', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (1, 1, 1, 1, 1, 'Mark');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (2, 2, 2, 2, 2, 'Lewis');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (3, 3, 3, 3, 3, 'Paul');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (4, 4, 4, 4, 4, 'Steve');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (5, 5, 5, 5, 5, 'Brandon');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (6, 6, 6, 6, 6, 'Dan');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (7, 7, 7, 7, 7, 'Kate');
INSERT INTO `final`.`employees` (`id`, `salary`, `employee_rank`, `employee_schedule`, `employee_history`, `employee_name`) VALUES (8, 8, 8, 8, 8, 'Lucy');

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`orders` (`id`, `total_cost`, `customer_id`, `combo_quantity`) VALUES (1, 5, 1, 1);
INSERT INTO `final`.`orders` (`id`, `total_cost`, `customer_id`, `combo_quantity`) VALUES (2, 7, 2, 1);
INSERT INTO `final`.`orders` (`id`, `total_cost`, `customer_id`, `combo_quantity`) VALUES (3, 12, 3, 2);
INSERT INTO `final`.`orders` (`id`, `total_cost`, `customer_id`, `combo_quantity`) VALUES (4, 17, 4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`combos_has_orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`combos_has_orders` (`combos_id`, `orders_id`) VALUES (4, 1);
INSERT INTO `final`.`combos_has_orders` (`combos_id`, `orders_id`) VALUES (12, 2);
INSERT INTO `final`.`combos_has_orders` (`combos_id`, `orders_id`) VALUES (22, 3);
INSERT INTO `final`.`combos_has_orders` (`combos_id`, `orders_id`) VALUES (9, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`employees_has_orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`employees_has_orders` (`employees_id`, `orders_id`) VALUES (4, 1);
INSERT INTO `final`.`employees_has_orders` (`employees_id`, `orders_id`) VALUES (6, 2);
INSERT INTO `final`.`employees_has_orders` (`employees_id`, `orders_id`) VALUES (2, 3);
INSERT INTO `final`.`employees_has_orders` (`employees_id`, `orders_id`) VALUES (1, 4);

COMMIT;

