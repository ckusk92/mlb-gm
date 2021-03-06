use league;

insert into user (user_id, username, password)
    values (1, 'username', 'password');

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
		   ('Cincinatti Reds'),
		   ('Milwaukee Brewers'),
		   ('Pittsburgh Pirates'),
		   ('Los Angeles Dodgers'),
		   ('San Diego Padres'),
		   ('San Francisco Giants'),
		   ('Colorado Rockies'),
		   ('Arizona Diamondbacks'),
		   ('Tamba Bay Rays'),
		   ('New York Yankees'),
		   ('Toronto Blue Jays'),
		   ('Baltimore Orioles'),
		   ('Boston Red Sox'),
		   ('Minnesota Twins'),
		   ('Cleveland Indians'),
		   ('Chicago White Sox'),
		   ('Kansas City Royals'),
		   ('Detroit Tigers'),
		   ('Oakland Athletics'),
		   ('Houston Astros'),
		   ('Seattle Mariners'),
		   ('Los Angeles Angels'),
		   ('Texas Rangers');

insert into player (first_name, last_name, position_id, rating)
	values ('Chance', 'Macfarlane', 1, 52),
		   ('Freddy', 'Rennie', 1, 66),
		   ('Kaiden', 'Farley', 1, 55),
		   ('Ira', 'Crosby', 1, 60),
		   ('Sky', 'Melia', 1, 84),
		   ('Misha', 'Alford', 1, 63),
		   ('Flynn', 'Watkins', 1, 78),
		   ('Alister', 'Connor', 1, 86),
		   ('Tiago', 'Perez', 1, 74),
		   ('Jacob', 'DeGrom', 1, 99),
		   ('Gerrit', 'Cole', 1, 95),
		   ('Justin', 'Verlander', 1, 94),
		   ('Clayton', 'Kershaw', 1, 94),
		   ('Max', 'Scherzer', 1, 94),
		   ('Zack', 'Greinke', 1, 93),
		   ('Stephen', 'Strasburg', 1, 91),
		   ('Charlie', 'Morton', 1, 90),
		   ('Aaron', 'Nola', 1, 89),
		   ('Chris', 'Sale', 1, 88),
		   ('Roberto', 'Osuna', 1, 91),
		   ('Kirby', 'Yates', 1, 91),
		   ('Percey', 'Feeney', 2, 65),
		   ('Kayne', 'Johnson', 2, 76),
		   ('Fynley', 'McLeod', 2, 81),
		   ('Pearl', 'McCartney', 2, 65),
		   ('Colm', 'Head', 2, 64),
		   ('Bartosz', 'Galloway', 2, 60),
		   ('Mali', 'Blanchard', 2, 50),
		   ('J.T.', 'Realmuto', 2, 92),
		   ('Yasmani', 'Grandal', 2, 90),
		   ('Gary', 'Sanchez', 2, 85),
		   ('Buster', 'Posey', 2, 83),
		   ('Roberto', 'Perez', 2, 83),
		   ('Mike', 'Zunino', 2, 83),
		   ('Mitch', 'Garver', 2, 82),
		   ('Christian', 'Vasquez', 2, 82),
		   ('Tom', 'Murphy', 2, 82),
		   ('Yadier', 'Molina', 2, 81),
		   ('Salvador', 'Perez', 2, 81),
		   ('Willson', 'Conteras', 2, 81),
		   ('Yasir', 'Grey', 3, 51),
		   ('Connor', 'Rasmussen', 3, 63),
		   ('Isaak', 'English', 3, 83),
		   ('Johnny', 'Wilkinson', 3, 68),
		   ('Miguel', 'Ritter', 3, 75),
		   ('Manuel', 'Doherty', 3, 85),
		   ('Stella', 'Feeney', 3, 62),
		   ('Jaspal', 'Dunne', 3, 53),
		   ('Freddie', 'Freeman', 3, 91),
		   ('Paul', 'Goldschmidt', 3, 91),
		   ('Carlos', 'Santana', 3, 89),
		   ('Max', 'Muncy', 3, 88),
		   ('Pete', 'Alonso', 3, 87),
		   ('Josh', 'Bell', 3, 86),
		   ('Jose', 'Abreu', 3, 86),
		   ('Matt', 'Olson', 3, 86),
		   ('Edwin', 'Encarnacion', 3, 85),
		   ('Joey', 'Votto', 3, 84),
		   ('Miguel', 'Sano', 3, 84),
		   ('John', 'Lamb', 4, 77),
		   ('Rylan', 'Halliday', 4, 74),
		   ('Amanpreet', 'Mcknight', 4, 61),
		   ('Nate', 'Rodrigues', 4, 76),
		   ('Mathias', 'Durham', 4, 50),
		   ('Sanjay', 'Berry', 4, 64),
		   ('Cally', 'Giles', 4, 57),
		   ('Ciaran', 'Stamp', 4, 64),
		   ('Ozzie', 'Albies', 4, 92),
		   ('Jose', 'Altuve', 4, 91),
		   ('DJ', 'LeMahieu', 4, 91),
		   ('Jonathon', 'Villar', 4, 91),
		   ('Brandon', 'Lowe', 4, 87),
		   ('Whit', 'Merrifield', 4, 86),
		   ('David', 'Fletcher', 4, 86),
		   ('Kolten', 'Wong', 4, 86),
		   ('Robinson', 'Cano', 4, 85),
		   ('Starlin', 'Castro', 4, 84),
		   ('Tye', 'Atkins', 5, 57),
		   ('Darsh', 'Wilkinson', 5, 64),
		   ('Borys', 'Robinson', 5, 72),
		   ('Issac', 'Driscoll', 5, 74),
		   ('Eliot', 'Wilkes', 5, 79),
		   ('Ernie', 'Kirkpatrick', 5, 82),
		   ('Micah', 'Mejia', 5, 56),
		   ('Woody', 'Cameron', 5, 53),
		   ('Eddison', 'McCartney', 5, 75),
		   ('Anthony', 'Rendon', 5, 99),
		   ('Nolan', 'Arenado', 5, 99),
		   ('Alex', 'Bregman', 5, 97),
		   ('Matt', 'Chapman', 5, 94),
		   ('Kris', 'Bryant', 5, 93),
		   ('Eugenio', 'Suarez', 5, 91),
		   ('Jose', 'Ramirez', 5, 91),
		   ('Josh', 'Donaldson', 5, 91),
		   ('Justin', 'Turner', 5, 90),
		   ('Manny', 'Machado', 5, 88),
		   ('Lex', 'Byrd', 6, 50),
		   ('Flynn', 'Archer', 6, 75),
		   ('Marion', 'Keenan', 6, 74),
		   ('Leroy', 'Bray', 6, 76),
		   ('Kobie', 'Murray', 6, 83),
		   ('Kalum', 'Rennie', 6, 72),
		   ('Aarush', 'Finch', 6, 74),
		   ('Javier', 'Baez', 6, 93),
		   ('Trevor', 'Story', 6, 92),
		   ('Francisco', 'Lindor', 6, 91),
		   ('Marcus', 'Semien', 6, 88),
		   ('Trea', 'Turner', 6, 87),
		   ('Fernando', 'Tatis', 6, 86),
		   ('Xander', 'Bogaerts', 6, 85),
		   ('Carlos', 'Correa', 6, 85),
		   ('Andrelton', 'Simmons', 6, 84),
		   ('Paul', 'DeJong', 6, 83),
		   ('Jon-Paul', 'Barnett', 7, 70),
		   ('Mikael', 'Wade', 7, 53),
		   ('Marcell', 'Ozuna', 7, 87),
		   ('Stella', 'Bowman', 7, 53),
		   ('Tommy', 'Pham', 7, 89),
		   ('Eddie', 'Rosario', 7, 88),
		   ('Rodrigo', 'Best', 7, 77),
		   ('Ayomide', 'Quintana', 7, 78),
		   ('Christian', 'Yelich', 7, 90),
		   ('Giancarlo', 'Stanton', 7, 92),
		   ('Juan', 'Soto', 7, 91),
		   ('Shaurya', 'Rodriguez', 7, 74),
		   ('Jac', 'Finnegan', 7, 54),
		   ('Faiz', 'Wyatt', 7, 85),
		   ('Meredith', 'Bush', 8, 84),
		   ('Ismaeel', 'Maldonado', 8, 66),
		   ('Mike', 'Trout', 8, 99),
		   ('Bryan', 'Ortiz', 8, 71),
		   ('Devan', 'Dean', 8, 53),
		   ('Cobie', 'Preece', 8, 71),
		   ('George', 'Springer', 8, 87),
		   ('Ronal', 'Acuna', 8, 97),
		   ('Ajay', 'Madden', 8, 77),
		   ('Osian', 'Milner', 9, 85),
		   ('Johnnie', 'Finley', 9, 51),
		   ('Rayan', 'Brown', 9, 85),
		   ('Jon-Paul', 'Rios', 9, 53),
		   ('Mookie', 'Betts', 9, 96),
		   ('Avisail', 'Garcia', 9, 87),		   
		   ('Bryce', 'Harper', 9, 89),
		   ('Corrie', 'Leach', 9, 71),
		   ('Cody', 'Bellinger', 9, 98),
		   ('J.D.', 'Martinez', 9, 90),
		   ('Aaron', 'Judge', 9, 94),
		   ('Kien', 'Christie', 9, 71),
		   ('Thomas', 'Macias', 9, 87),
		   ('Joey', 'Gallo', 9, 91),
		   ('Tracey', 'Strong', 9, 70);


