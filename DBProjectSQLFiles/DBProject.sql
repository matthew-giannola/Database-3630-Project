-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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
  `phone_number` VARCHAR(15) NULL DEFAULT NULL,
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
  INDEX `vendor_stock_idx` (`vendor` ASC) VISIBLE,
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
  INDEX `fk_drinks_stock1_idx` (`stock_id` ASC) VISIBLE,
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
  INDEX `ingrediants_stock_idx` (`stock_id` ASC) INVISIBLE,
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
  UNIQUE INDEX `unigue_combo` (`drink` ASC, `food` ASC) VISIBLE,
  INDEX `drinks_combos_fk_idx` (`drink` ASC) VISIBLE,
  INDEX `ingrediatns_comdos_fk_idx` (`food` ASC) VISIBLE,
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
-- Table `final`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`orders` (
  `id` INT NOT NULL,
  `total_cost` DOUBLE NOT NULL DEFAULT '0',
  `customer_id` INT NOT NULL,
  `combo_quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `customer_order_idx` (`customer_id` ASC) VISIBLE,
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
  INDEX `fk_combos_has_orders_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_combos_has_orders_combos1_idx` (`combos_id` ASC) VISIBLE,
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
-- Table `final`.`employment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`employment_history` (
  `id` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`salaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`salaries` (
  `id` INT NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `final`.`schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `final`.`schedules` (
  `id` INT NOT NULL,
  `next_shift_start` VARCHAR(15) NOT NULL,
  `next_shift_end` VARCHAR(15) NOT NULL,
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
  PRIMARY KEY (`id`),
  INDEX `rank_employee_fk_idx` (`employee_rank` ASC) VISIBLE,
  INDEX `salary_employee_idx` (`salary` ASC) VISIBLE,
  INDEX `scedules_employee_idx` (`employee_schedule` ASC) VISIBLE,
  INDEX `history_employees_fk_idx` (`employee_history` ASC) VISIBLE,
  CONSTRAINT `history_employees_fk`
    FOREIGN KEY (`employee_history`)
    REFERENCES `final`.`employment_history` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
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
  INDEX `fk_employees_has_orders_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_employees_has_orders_employees1_idx` (`employees_id` ASC) VISIBLE,
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
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (id, 'name', 'address', 'phone_number');
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (1, 'Pepsi', '3453 Jackson St, Dubuque, IA 52001', '608 245 3348');
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (2, 'Tyson', '5218 Elm St, Dubuque, IA 52001', '608 445 9821');
INSERT INTO `final`.`vendor` (`id`, `name`, `address`, `phone_number`) VALUES (3, 'General Mills', '3453 45 St, Dubuque, IA 52001', '608 342 1776');

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`stock`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`stock` (`id`, `cost`, `num_stock`, `vendor`) VALUES (id, cost, num_stock, vendor);
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
INSERT INTO `final`.`drinks` (`id`, `name`, `drink_size`, `stock_id`) VALUES (id, 'name', 'drink_size', stock_id);
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
INSERT INTO `final`.`food` (`id`, `food`, `stock_id`) VALUES (id, 'food', stock_id);
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
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (1, 1, 1, 'Burger w/ Small Coke', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (2, 2, 1, 'Burger w/ Large Coke', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (3, 3, 1, 'Burger w/ Small Sprite', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (4, 4, 1, 'Burger w/ Large Sprite', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (5, 5, 1, 'Burger w/ Small Water', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (6, 6, 1, 'Burger w/ Large Water', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (7, 1, 2, 'Chicken Strips w/ Small Coke', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (8, 2, 2, 'Chicken Strips w/ Large Coke', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (9, 3, 2, 'Chicken Strips w/ Small Sprite', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (10, 4, 2, 'Chicken Strips w/ Large Sprite', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (11, 5, 2, 'Chicken Strips w/ Small Water', 6);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (12, 6, 2, 'Chicken Strips w/ Large Water', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (13, 1, 3, 'Burrito w/ Small Coke', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (14, 2, 3, 'Burrito w/ Large Coke', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (15, 3, 3, 'Burrito w/ Small Sprite', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (16, 4, 3, 'Burrito w/ Large SPrite', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (17, 5, 3, 'Burrito w/ Small Water', 7);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (18, 6, 3, 'Burrito w/ Large Water', 8);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (19, 1, 4, 'Pancakes w/ Small Coke', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (20, 2, 4, 'Pancakes w/ Large Coke', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (21, 3, 4, 'Pancakes w/ Small Sprite', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (22, 4, 4, 'Pancakes w/ Large Coke', 5);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (23, 5, 4, 'Pancakes w/ Small Water', 4);
INSERT INTO `final`.`combos` (`id`, `drink`, `food`, `combos_name`, `combo_cost`) VALUES (24, 6, 4, 'Pancakes w/ Large Water', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `final`.`employee_ranks`
-- -----------------------------------------------------
START TRANSACTION;
USE `final`;
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (1, 'Manager');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (2, 'Cook');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (3, 'Cashier');
INSERT INTO `final`.`employee_ranks` (`id`, `employee_rank`) VALUES (4, 'Server');

COMMIT;

