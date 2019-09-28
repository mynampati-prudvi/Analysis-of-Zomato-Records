################################### CREATE DATABASE #########################################

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zomato
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zomato
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zomato` DEFAULT CHARACTER SET utf8 ;
USE `zomato` ;

-- -----------------------------------------------------
-- Table `zomato`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Restaurant` (
  `Restaurant_id` SMALLINT UNSIGNED NOT NULL,
  `Restaurant_name` VARCHAR(200) NOT NULL,
  `Avg_cost` DECIMAL(10,2) NOT NULL,
  `Currency_type` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `Restaurant_id_UNIQUE` (`Restaurant_id` ASC) VISIBLE,
  PRIMARY KEY (`Restaurant_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Country` (
  `Country_id` SMALLINT(5) NOT NULL,
  `Country_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`City` (
  `City_id` SMALLINT(5) NOT NULL,
  `Name` VARCHAR(50) NULL DEFAULT NULL,
  `Country_id` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`City_id`),
  CONSTRAINT `country_id_fk`
    FOREIGN KEY (`Country_id`)
    REFERENCES `zomato`.`Country` (`Country_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Address` (
  `Restaurant_id` SMALLINT UNSIGNED NOT NULL,
  `Address_id` SMALLINT(10) NOT NULL,
  `Address` VARCHAR(500) NOT NULL,
  `City_id` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`Address_id`),
  INDEX `Restaurant_id_fk_idx` (`Restaurant_id` ASC) VISIBLE,
  INDEX `city_id_fk_idx` (`City_id` ASC) VISIBLE,
  UNIQUE INDEX `Restaurant_id_UNIQUE` (`Restaurant_id` ASC) VISIBLE,
  CONSTRAINT `Restaurant_id_fk`
    FOREIGN KEY (`Restaurant_id`)
    REFERENCES `zomato`.`Restaurant` (`Restaurant_id`),
  CONSTRAINT `city_id_fk`
    FOREIGN KEY (`City_id`)
    REFERENCES `zomato`.`City` (`City_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`cuisine` (
  `cuisine_id` SMALLINT UNSIGNED NOT NULL,
  `cuisine_type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cuisine_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Rating` (
  `Rating` DECIMAL(4,2) NOT NULL,
  `Restaurant_id` SMALLINT UNSIGNED NOT NULL,
  `Votes` INT(10) NOT NULL,
  `Rating_color` VARCHAR(45) NULL DEFAULT NULL,
  `Rating_text` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `restaurant_rating_fk_idx` (`Restaurant_id` ASC) VISIBLE,
  UNIQUE INDEX `Restaurant_id_UNIQUE` (`Restaurant_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_rating_fk`
    FOREIGN KEY (`Restaurant_id`)
    REFERENCES `zomato`.`Restaurant` (`Restaurant_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`Restaurant_other_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Restaurant_other_services` (
  `Restaurant_id` SMALLINT UNSIGNED NOT NULL,
  `Table_booking` VARCHAR(5) NULL,
  `Online_Delivery` VARCHAR(5) NULL,
  PRIMARY KEY (`Restaurant_id`),
  CONSTRAINT `restaurant_other_Services_fk`
    FOREIGN KEY (`Restaurant_id`)
    REFERENCES `zomato`.`Restaurant` (`Restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `zomato`.`Restaurant_cuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zomato`.`Restaurant_cuisines` (
  `cuisine_id` SMALLINT UNSIGNED NOT NULL,
  `Restaurant_id` SMALLINT UNSIGNED NOT NULL,
  INDEX `restaurant_id_fk_idx` (`Restaurant_id` ASC) VISIBLE,
  INDEX `cuisine_id_fk_idx` (`cuisine_id` ASC) VISIBLE,
  CONSTRAINT `restaurant_id_fk`
    FOREIGN KEY (`Restaurant_id`)
    REFERENCES `zomato`.`Restaurant` (`Restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cuisine_id_fk`
    FOREIGN KEY (`cuisine_id`)
    REFERENCES `zomato`.`cuisine` (`cuisine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




################################# LOADING DATA ##############################################


show variables like "secure_file_priv";


# Loading data into Country table

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\country.csv'
replace into table zomato.country
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;

# Loading data into City table

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\city.csv'
replace into table zomato.city
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;

# Loading data into rating table

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\rating.csv'
replace into table zomato.rating
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;

# Loading data into Restaurant_other_services

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\services.csv'
replace into table zomato.restaurant_other_services
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;

# Loading data into Restaurant

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\restaurant.csv'
replace into table zomato.restaurant
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;

# Loading data into Cuisine

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cuisines.csv'
replace into table zomato.cuisine
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines;


# Loading data into address

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\address.csv'
replace into table zomato.address
fields terminated by ',' optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;



# Loading data into restaurant_cuisines

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\restaurant_cuisines.csv'
replace into table zomato.restaurant_cuisines
fields terminated by ',' 
lines terminated by '\n'
ignore 1 lines
(restaurant_ID, CUISINE_ID);




################################### QUERIES ########################################



use zomato;

################################### QUERY 1 ########################################  

# a) TOP 5 Restaurants in Each City having Online delivery

SELECT restaurant_id, restaurant_name, CITY, online_delivery, RATING, VOTES, CITY_rank
FROM
(
		SELECT 
			r.restaurant_id,
			r.restaurant_name,
			c.name AS CITY,
			ro.online_delivery,
			ra.rating,
			ra.votes,
			RANK() OVER (PARTITION BY c.name
						  ORDER BY ra.rating DESC
						) AS CITY_rank
		FROM
			restaurant r
				left JOIN
			rating ra ON r.restaurant_id = ra.restaurant_id
				left JOIN
			restaurant_other_services ro ON r.restaurant_id = ro.restaurant_id
				left JOIN
			address a ON a.restaurant_id = r.restaurant_id
				left JOIN
			city c ON c.city_id = a.city_id  
		WHERE ro.online_delivery like 'yes%' and ra.votes > 10 ) AS TEMP
WHERE CITY_rank < 6
ORDER BY CITY, CITY_RANK ;


# b) Last 3 restaurants in each city having online delivery

SELECT restaurant_id, restaurant_name, CITY, online_delivery, RATING, VOTES, CITY_rank
FROM
(
		SELECT 
			r.restaurant_id,
			r.restaurant_name,
			c.name AS CITY,
			ro.online_delivery,
			ra.rating,
			ra.votes,
			RANK() OVER (PARTITION BY c.name
						  ORDER BY ra.rating asc
						) AS CITY_rank
		FROM
			restaurant r
				left JOIN
			rating ra ON r.restaurant_id = ra.restaurant_id
				left JOIN
			restaurant_other_services ro ON r.restaurant_id = ro.restaurant_id
				left JOIN
			address a ON a.restaurant_id = r.restaurant_id
				left JOIN
			city c ON c.city_id = a.city_id  
		WHERE ro.online_delivery like 'yes%' and ra.votes > 10 ) AS TEMP
WHERE CITY_rank  < 4
ORDER BY CITY, CITY_RANK ;





################################### QUERY 2 ########################################

# a) Top 5 Restaurants in Each Country having online delivery

SELECT restaurant_id, restaurant_name, online_delivery, rating, votes, country, Country_rank
from (
		Select
			r.restaurant_id,
			r.restaurant_name,
			ro.online_delivery,
			ra.rating,
			ra.votes,
			co.country_name as country,
			RANK() OVER (PARTITION BY co.country_name
							  ORDER BY ra.rating DESC
							) AS Country_rank
                        
from restaurant r
				left JOIN
			rating ra ON r.restaurant_id = ra.restaurant_id
				left JOIN
			restaurant_other_services ro ON r.restaurant_id = ro.restaurant_id
				left JOIN
			address a ON a.restaurant_id = r.restaurant_id
				left JOIN
			city c ON c.city_id = a.city_id
            left join
            country co on co.country_id = c.country_id
WHERE ro.online_delivery like 'yes%' and ra.votes > 10) AS temp
WHERE country_rank < 6
ORDER BY country, Country_rank; 	



########################## QUERY 3 ###################################

# Counting the total number of restaurants based on cuisines 

SELECT 
    c.cuisine_type, count(a.restaurant_name)
FROM
    restaurant a
        LEFT JOIN
    restaurant_cuisines b ON a.Restaurant_id = b.restaurant_id
        JOIN
    cuisine c ON b.cuisine_id = c.cuisine_id
GROUP BY c.cuisine_type;



################################ QUERY 4 ######################################

# Restaurants having the highest number of votes with better rating

SELECT 
	r.restaurant_name,
	r.restaurant_id,
    ra.votes,
    ra.rating
FROM restaurant r 
	inner join 	rating ra on r.restaurant_id = ra.restaurant_id 
WHERE ra.rating > 4
order by votes desc
limit 10;

################################### QUERY 5 ########################################

# Countries having unique cuisines

Select cu.cuisine_type,
		r.restaurant_name,
		r.restaurant_id,
        c.country_name
from cuisine cu 
	inner join restaurant_cuisines rc on cu.cuisine_id = rc.cuisine_id
    inner join restaurant r on r.restaurant_id = rc.restaurant_id
    inner join address a on a.restaurant_id = r.restaurant_id
    inner join city ci on ci.city_id = a.city_id
    inner join country c on c.country_id = ci.country_id
WHERE cuisine_type NOT IN (SELECT cuisine_type
						   FROM cuisine cu2
							inner join restaurant_cuisines rc2 on cu2.cuisine_id = rc2.cuisine_id
							inner join restaurant r2 on r2.restaurant_id = rc2.restaurant_id
							inner join address a2 on a2.restaurant_id = r2.restaurant_id
							inner join city ci2 on ci2.city_id = a2.city_id
							inner join country c2 on c2.country_id = ci2.country_id
                            WHERE C.country_id <> C2.country_id)
LIMIT 5;

################################### QUERY 6 ########################################

# Top Restaurants having CHINESE Cuisine in the Country

SELECT 
    cu.cuisine_type,
    r.restaurant_name,
    r.restaurant_id,
    c.country_name,
    ra.rating
FROM
    cuisine cu
        INNER JOIN
    restaurant_cuisines rc ON cu.cuisine_id = rc.cuisine_id
        INNER JOIN
    restaurant r ON r.restaurant_id = rc.restaurant_id
        INNER JOIN
    address a ON a.restaurant_id = r.restaurant_id
        INNER JOIN
    city ci ON ci.city_id = a.city_id
        INNER JOIN
    country c ON c.country_id = ci.country_id
        INNER JOIN
    rating ra ON ra.restaurant_id = r.restaurant_id
WHERE
    cu.cuisine_type like '%chinese%' and c.country_name like '%india'
ORDER BY rating DESC
LIMIT 10;    





######################## QUERY 7########################

# Finding the number of restaurant names in New Delhi

SELECT 
    COUNT(a.Restaurant_name) AS countRestaurant,
    a.Restaurant_name AS nameOfRestaurant
FROM
    restaurant a
        JOIN
    address b ON a.Restaurant_id = b.Restaurant_id
        JOIN
    city c ON b.City_id = c.City_id
WHERE
    c.Name = 'New Delhi'
GROUP BY nameOfRestaurant
ORDER BY countRestaurant DESC
LIMIT 21;


################################QUERY 8 #################################

# Finding the restaurant names based on ratings feedback

SELECT 
    a.restaurant_name, d.Country_name, p.Rating_text
FROM
    rating p
        JOIN
    restaurant a ON p.Restaurant_id = a.Restaurant_id
        JOIN
    address b ON b.Restaurant_id = a.Restaurant_id
        JOIN
    city c ON b.City_id = c.City_id
        JOIN
    country d ON c.Country_id = d.Country_id
WHERE
    p.Rating_text != 'Poor
';


################################### QUERY 9 ########################################


# a) Restaurants with rating > 4 having less avg_cost in INDIA

Select r.restaurant_id,
		r.restaurant_name,
		r.avg_cost,
		ra.rating,
		ra.votes,
		c.country_name as country  
from restaurant r 
	inner join rating ra on r.restaurant_id = ra.restaurant_id
    inner join address a on a.restaurant_id = ra.restaurant_id
    inner join city ci on ci.city_id = a.city_id
    inner join country c on c.country_id = ci.country_id
where c.country_name like '%india%' and rating > 4.00 and avg_cost between 50 and 2000
order by rating desc , avg_cost asc;


# b) Restaurant with rating < 2 

Select r.restaurant_id,
		r.restaurant_name,
		r.avg_cost,
		ra.rating,
		ra.votes
from restaurant r 
	inner join rating ra on r.restaurant_id = ra.restaurant_id
    inner join address a on a.restaurant_id = ra.restaurant_id
where  rating < 2.00 
order by rating ASC , avg_cost asc;

    
        