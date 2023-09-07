DROP DATABASE IF EXISTS seminar_5_homework;
CREATE DATABASE seminar_5_homework;
USE seminar_5_homework;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
-- CREATE VIEW CheapCars AS SELECT Name FROM Cars WHERE Cost<25000;

SELECT *
FROM cars
  WHERE cost < 25000;
  
DROP VIEW IF EXISTS CheapCars;
CREATE VIEW CheapCars (id, name, cost)
AS SELECT *
FROM cars
  WHERE cost < 25000;
  
SELECT * FROM CheapCars;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов
-- (используя оператор ALTER VIEW) ALTER VIEW CheapCars AS SELECT Name FROM CarsWHERE Cost<30000;

ALTER VIEW CheapCars 
AS SELECT * FROM Cars
  WHERE Cost<30000;

SELECT * FROM CheapCars;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

SELECT * FROM cars
  WHERE name = 'Audi'OR name ='Skoda';
  
DROP VIEW IF EXISTS Audi_Skoda_Cars;
CREATE VIEW Audi_Skoda_Cars (id, name, cost)
AS SELECT *
FROM cars
  WHERE name = 'Audi'OR name ='Skoda';
  
SELECT * FROM Audi_Skoda_Cars;

-- Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, мы
-- вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования 
-- оконной функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции
-- LEAD . Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить
-- результат. В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу
-- после нее.

DROP TABLE IF EXISTS Timetable;

CREATE TABLE IF NOT EXISTS Timetable
(
    train_id INT NOT NULL,
    station VARCHAR (15) NOT NULL,
    time_arriving TIME
);

INSERT INTO Timetable (train_id, station, time_arriving) 
VALUES
(110, "San Francisco", "10:00:00"),
(110, "Redwood City", "10:54:00" ),
(110, "Palo Alto", "11:02:00" ),
(110, "San Jose", "12:35:00"),
(120, "San Francisco", "11:00:00"),
(120, "Palo Alto ", "12:49:00" ), 
(120, "San Jose", "13:30:00");

SELECT * FROM Timetable;

select *,
timediff(lead(time_arriving) over (partition by train_id order by time_arriving), time_arriving) 'time_to_next_station'
from Timetable;
    
