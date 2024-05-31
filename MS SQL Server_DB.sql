CREATE TABLE Directions_of_study (
    ID INT IDENTITY PRIMARY KEY,
    direction_name NVARCHAR(100) NOT NULL
);

CREATE TABLE Groups (
    ID INT IDENTITY PRIMARY KEY, 
    group_name NVARCHAR(10) NOT NULL, 
    direction_id INT NOT NULL,
    FOREIGN KEY (direction_id) REFERENCES Directions_of_study(ID)
);

CREATE TABLE Student (
    ID INT IDENTITY PRIMARY KEY, 
    full_name NVARCHAR(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    address NVARCHAR(200) DEFAULT 'NULL', 
    email NVARCHAR(100) DEFAULT 'NULL',
    group_id INT NOT NULL,
    budget BIT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Groups(ID)
);

CREATE TABLE Phone_numbers (
    ID INT IDENTITY PRIMARY KEY,
    student_id INT NOT NULL,
    phone_number NVARCHAR(25) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Student(ID)
);

CREATE TABLE Marks (
    ID INT IDENTITY PRIMARY KEY, 
    student_id INT NOT NULL, 
    sub_disc_teach_id INT NOT NULL, 
    mark INT,
    FOREIGN KEY (student_id) REFERENCES Student(ID)
);

CREATE TABLE Disciplines (
    ID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(200) NOT NULL
);

CREATE TABLE Teachers (
    ID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(200) NOT NULL
);

CREATE TABLE Pair_time (
    ID INT IDENTITY PRIMARY KEY, 
    time_start TIME NOT NULL, 
    time_end TIME NOT NULL 
);

CREATE TABLE DirectionDisciplineTeacher (
    ID INT IDENTITY PRIMARY KEY,
    direction_id INT NOT NULL, 
    discipline_id INT NOT NULL,
    teacher_id INT NOT NULL, 
    FOREIGN KEY (direction_id) REFERENCES Directions_of_study(ID),
    FOREIGN KEY (discipline_id) REFERENCES Disciplines(ID),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(ID)
);

CREATE TABLE Lessons_schedule (
    ID INT IDENTITY PRIMARY KEY, 
    sub_disc_teach_id INT NOT NULL,
    time_id INT NOT NULL, 
    date DATE NOT NULL, 
    FOREIGN KEY (time_id) REFERENCES Pair_time(ID),
    FOREIGN KEY (sub_disc_teach_id) REFERENCES DirectionDisciplineTeacher(ID)
);

CREATE TABLE Attendance (
    ID INT IDENTITY PRIMARY KEY, 
    schedule_id INT NOT NULL, 
    student_id INT NOT NULL, 
    presence BIT NOT NULL, 
    FOREIGN KEY (schedule_id) REFERENCES Lessons_schedule(ID),
    FOREIGN KEY (student_id) REFERENCES Student(ID)
);

INSERT INTO Directions_of_study(direction_name)
VALUES ("Information systems and technologies");
INSERT INTO Directions_of_study(direction_name)
VALUES ("Applied Informatics");
INSERT INTO Directions_of_study(direction_name)
VALUES ("Business Informatics");

INSERT INTO Groups(group_name, direction_id)
VALUES ("IS101", 1);
INSERT INTO Groups(group_name, direction_id)
VALUES ("IS102", 1);
INSERT INTO Groups(group_name, direction_id)
VALUES ("IS103", 1);

INSERT INTO Groups(group_name, direction_id)
VALUES ("PI101", 2);
INSERT INTO Groups(group_name, direction_id)
VALUES ("PI102", 2);
INSERT INTO Groups(group_name, direction_id)
VALUES ("PI103", 2);

INSERT INTO Groups(group_name, direction_id)
VALUES ("BI101", 3);
INSERT INTO Groups(group_name, direction_id)
VALUES ("BI102", 3);
INSERT INTO Groups(group_name, direction_id)
VALUES ("BI103", 3);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Eremin Alexander Alexandrovich", "2000-11-24", "Tomsk, Mira str., No. 11", "amwflmym49@bk.ru", 1, 1),
("Eremin Alexander Petrovich", "2002-10-22", "Almetyevsk, Zheleznodorozhnaya str., No. 14", "nkxymmbb37@bk.ru", 1, 1),
("Golovach Elisaveta Petrovna", "2004-10-05", "Severodvinsk, Pionerskaya str., No. 7", "psriphqr68@bk.ru", 1, 0),
("Bishler Elisaveta Konstantinovna", "2003-01-01", "Petropavlovsk-Kamchatsky, Trudovaya str., No. 12", "usjjkfhz69@bk.ru", 1, 0),
("Sergeev Sergius Sergievich", "2000-01-02", "Yuzhno-Sakhalinsk, Krasnoarmeiskaya str., No. 19", "tipjions3@bk.ru", 1, 1),
("Eremyuk Sergius Vasilievich", "2002-12-16", "Chelyabinsk, Pervomaysky lane, No. 9", "imbbnglx66@bk.ru", 1, 1),
("Shlepko Stephan Stephanovich", "2002-12-17", "Almetyevsk, Yuzhnaya str., No. 14", "yeogvaif2@bk.ru", 1, 1),
("Kovriginus Nicolaus Dmitrievich", "2004-12-20", "Almetyevsk, Yuzhnaya str., No. 10", "mhqusjpx37@bk.ru", 1, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Kolotushkin Konstantin Alexandrovich", "2001-01-23", "Novorossiysk, Raduzhnaya str., No. 22", "puiozica69@bk.ru", 2, 1),
("Chikus Ivan Ivanovich", "2002-02-10", "Volzhsky, Krasnoarmeiskaya str., No. 10", "jqspkwlw49@bk.ru", 2, 1),
("Pachikus Evpatius Sergeevich", "2002-04-13", "Astrakhan, Zavodskaya str., No. 11", "nuwdbvwb17@bk.ru", 2, 0),
("Perchus Kirill Lvovich", "2004-10-18", "Nalchik, Rechnaya str., No. 11", "bvltysaw62@bk.ru", 2, 1),
("Eliseev Roman Romanovich", "2001-12-17", "Ulan-Ude, Chkalova str., No. 2", "soeohkfhl58@bk.ru", 2, 0),
("Stalkinus Kirill Lvovich", "2002-11-01", "Sochi, Kolkhoznaya str., No. 23", "kzkrbvah98@bk.ru", 2, 0),
("Stepkinus Stephan Stephanovich", "2003-09-02", "Nizhny Tagil, Lenina str., No. 22", "cbciwiee61@bk.ru", 2, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Petrov Georgius Gennadii Gennadievich", "2003-04-25", "Krasnogorsk, 17 Sentyabrya str., No. 1", "erdvnnkg24@bk.ru", 3, 1),
("Zhdanov Condratius Vadimovich", "2001-11-23", "Ekaterinburg, Raduzhnaya str., No. 15", "nfipryzd24@bk.ru", 3, 1),
("Filatov Donatus Arsenievich", "2002-12-13", "Novocherkassk, Shosseynaya str., No. 14", "ssiuemok7@bk.ru", 3, 0),
("Zinovievus Samuel Gelasievich", "2003-05-14", "Volgograd, Shkolny lane, No. 13", "fontjhqo91@bk.ru", 3, 0),
("Sazonovus Petrus Fedotovich", "2005-06-18", "Oktyabrskiy, Zaslonova str., No. 24", "erzonznx24@bk.ru", 3, 0),
("Nikiforov Averkius Serapionovich", "2000-10-19", "Ryazan, Sportivnaya str., No. 4", "mkkidlfz29@bk.ru", 3, 1),
("Rodionovus Gordius Damirovich", "2001-10-01", "Astrakhan, Shkolnaya str., No. 8", "vyleaqlz57@bk.ru", 3, 1),
("Kuznetsovus Marcus Sozonovich", "2003-09-04", "Tver, Shkolnaya str., No. 19", "adpadrxl25@bk.ru", 3, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Subbotina Marisha Ruslanovna", "2002-10-17", "Taganrog, Zarechnaya str., No. 15", "braeuyqm29@bk.ru", 4, 0),
("Polyakova Galina Vyacheslavovna", "2001-09-18", "Kamyshin, Dachnaya str., No. 23", "zhkecjpr69@bk.ru", 4, 1),
("Sukhanova Evelina Ivanovna", "2005-08-20", "Kaspiysk, 3 Marta str., No. 22", "yrqsivwi24@bk.ru", 4, 1),
("Kapustina Lunara Filatovna", "2004-07-28", "Bryansk, Selskaya str., No. 20", "azqitjvz33@bk.ru", 4, 0),
("Doronina Ralina Fedoseevna", "2002-06-07", "Seversk, Vishnevaya str., No. 23", "mbghstjs74@bk.ru", 4, 1),
("Terentyev Ermak Irineevich", "2001-05-02", "Nazran, Shkolny lane, No. 5", "vocteuqn24@bk.ru", 4, 0),
("Sazonov Arsen Yaroslavovich", "2005-04-08", "Serpukhov, Partizanskaya str., No. 8", "dwqbdghc98@bk.ru", 4, 0),
("Yershov Mitrofan Ilyovich", "2004-03-17", "Pyatigorsk, Zarechny lane, No. 21", "wsnxpwnf58@bk.ru", 4, 1),
("Shiryaev Matvey Yeremeevich", "2003-02-18", "Kyzyl, Ozernaya str., No. 6", "rtuvjhcj39@bk.ru", 4, 1),
("Noskov Timofey Maksovich", "2002-01-09", "Yakutsk, Sadovaya str., No. 8", "dllovewa32@bk.ru", 4, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Efimova Adeliya Kimovna", "2001-09-09", "Orekhovo-Zuevo, Mira str., No. 10", "kytearhf64@bk.ru", 5, 0),
("Chipyirkina Svetlana Ivanovna", "2002-11-11", "Achinsk, Gagarina str., No. 22", "ahfgysyw13@bk.ru", 5, 0),
("Kulagina Asya Vasilyevna", "2003-12-12", "Nefteyugansk, Polesskaya str., No. 11", "mjeqgezs57@bk.ru", 5, 1),
("Borisova Laima Dmitrievna", "2004-02-02", "Novoshakhtinsk, Peschanaya str., No. 13", "qhdaetdf8@bk.ru", 5, 1),
("Kocheva Natalya Yevgenevna", "2005-09-09", "Lyubertsy, Pochtovaya str., No. 17", "nhqsfxte26@bk.ru", 5, 0),
("Sheptun Sergei Sergeyevich", "2002-10-10", "Derbent, Zavodskaya str., No. 25", "tzpzbkal28@bk.ru", 5, 1),
("Golovanov Sergei Viktorovich", "2000-03-18", "Nevinnomyssk, Lugovoy lane, No. 10", "vlbblrpm32@bk.ru", 5, 1),
("Krylova Maryana Glebovna", "2003-04-22", "Tambov, Novaya str., No. 24", "cyepnwdk23@bk.ru", 5, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Burov Nikolay Panteleimonovich", "2005-07-06", "Ramenskoye, Sovetskaya str., No. 3", "dfclgwwz29@bk.ru", 6, 1),
("Dmitriev Illarion Gelasievich", "2004-11-03", "Nizhny Tagil, Oktyabrskiy lane, No. 14", "epsnbwgm8@bk.ru", 6, 0),
("Larionov Ustin Vladlenovich", "2000-04-02", "Cherkessk, Tsvetochnaya str., No. 1", "upguzrow76@bk.ru", 6, 1),
("Kazakov Orest Naumovich", "2002-03-01", "Yaroslavl, Pervomayskaya str., No. 22", "ikumhrfo9@bk.ru", 6, 0),
("Yudina Ioanna Agafonovichna", "2002-05-16", "Odintsovo, Pochtovaya str., No. 16", "mxbehmly87@bk.ru", 6, 0),
("Andreev Gordey Platonovich", "2005-07-27", "Magnitogorsk, Pushkina str., No. 12", "zucweukd97@bk.ru", 6, 1),
("Rogov Askold Filippovich", "2001-04-26", "Pskov, Krasnoarmeyskaya str., No. 25", "btjwevlv53@bk.ru", 6, 1),
("Anisimov Abram Melsovich", "2002-08-25", "Berezniki, Michurina str., No. 13", "rrexevkn12@bk.ru", 6, 0),
("Lobanov Luka Tikhonovich", "2004-02-19", "Mytishchi, Internatsionalnaya str., No. 16", "gqhleznf61@bk.ru", 6, 1),
("Ryabov Boris Viktorovich", "2003-01-21", "Mytishchi, Internatsionalnaya str., No. 17", "kvrdsvyo33@bk.ru", 6, 1),
("Evdokimov Moisey Lukyanovich", "2003-02-11", "Murom, Druzhby str., No. 12", "ugpvondv10@bk.ru", 6, 1),
("Vladimirov Arsen Makarovich", "2001-07-20", "Murom, Druzhby str., No. 18", "eumamwah69@bk.ru", 6, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Blokhin Efim Protasievich", "2003-11-15", "Murom, Mirnaya str., No. 6", "rzarlgxy72@bk.ru", 7, 0),
("Khokhlov Ilya Filatovich", "2001-12-16", "Nizhnekamsk, Naberezhnaya str., No. 20", "hewynjcs30@bk.ru", 7, 1),
("Suvorov Leonid Igorevich", "2003-04-11", "Sergiev Posad, Solnechnaya str., No. 17", "abqndmqh26@bk.ru", 7, 0),
("Isakov Filipp Ignatievich", "2001-07-22", "Engels, Zheleznodorozhnaya str., No. 16", "nqsqdgzl13@bk.ru", 7, 1),
("Ignatiev Ignat Nathanovich", "2000-05-30", "Krasnodar, Vishnevaya str., No. 10", "wccqerry31@bk.ru", 7, 0),
("Knyazev Eduard Sozonovich", "2005-06-16", "Neftekamsk, Chapaeva str., No. 88", "bgblkpzq95@bk.ru", 7, 1),
("Grishin Kassian Efimovich", "2004-02-02", "Vladikavkaz, Lenina str., No. 23", "qfekdjiu69@bk.ru", 7, 1),
("Kovalyova Asida Kirillovna", "2002-01-17", "Krasnodar, Peschanaya str., No. 16", "qtxkvtnd73@bk.ru", 7, 1),
("Tarasova Merisa Romanovna", "2000-03-21", "Petrozavodsk, Zaslonova str., No. 13", "nlfgguhj69@bk.ru", 7, 1),
("Sharapova Asya Dmitrievna", "2001-10-25", "Lipetsk, Belorusskaya str., No. 13", "bbmkauwe17@bk.ru", 7, 0),
("Titova Aylin Sozonovna", "2002-12-06", "Naberezhnye Chelny, Zeleny lane, No. 18", "oxvxwvcx75@bk.ru", 7, 0),
("Abramova Iraida Albertovna", "2003-11-06", "Armavir, Ozerny lane, No. 11", "pkcedcbx91@bk.ru", 7, 1),
("Sysoeva Milda Semenovna", "2002-12-02", "Pervouralsk, Belorusskaya str., No. 19", "qrluhgbo34@bk.ru", 7, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Davydova Stella Efimovna", "2002-01-22", "Tyumen, Chapaeva str., No. 16", "iozvzevm40@bk.ru", 8, 0),
("Simonova Gloria Gordeevna", "2000-12-03", "Belgorod, Dzerzhinskogo str., No. 14", "rolcflhc45@bk.ru", 8, 1),
("Muravyova Tereza Semenovna", "2001-09-22", "Barnaul, Michurina str., No. 18", "aicliyqt28@bk.ru", 8, 0),
("Bespalova Arkheliya Dmitrievna", "2002-07-14", "Yekaterinburg, Zelenaya str., No. 23", "mcymtayh57@bk.ru", 8, 1),
("Emelyanova Yanita Nathanovna", "2000-05-24", "Pyatigorsk, Tsentralny lane, No. 6", "prvxookj70@bk.ru", 8, 0),
("Maksimova Lali Melsovna", "2005-03-21", "Serpuhov, Dzerzhinskogo str., No. 15", "nzroyism94@bk.ru", 8, 1),
("Kabanova Dzhuliya Lukyanovna", "2004-01-22", "Abakan, Internatsionalnaya str., No. 1", "rtayucxb52@bk.ru", 8, 1),
("Drozdov Albert Fedorovich", "2002-11-24", "Angarsk, Tikhaya str., No. 18", "okylqvcz26@bk.ru", 8, 1),
("Shestakov Mitrofan Vladislavovich", "2001-10-06", "Oktyabrsky, Svetlaya str., No. 24", "ndmspyni14@bk.ru", 8, 1),
("Nazarov Korneliy Vasilyevich", "2003-10-14", "Angarsk, Stroiteley str., No. 8", "rxmaglry23@bk.ru", 8 , 0),
("Kirillov Kondraty Glebovich", "2002-12-23", "Rostov-on-Don, Maksima Gorkogo str., No. 25", "ogtwwblq56@bk.ru", 8, 1),
("Ignatiev Emelyan Donatovich", "2004-01-22", "Achinsk, Ozerny lane, No. 24", "gzhfbrkv69@bk.ru", 8, 1),
("Efimov Yegor Vladimirovich", "2003-02-02", "Nazran, Kolkhoznaya str., No. 15", "unhmhnxr34@bk.ru", 8, 1),
("Odintsov Ernest Lvovich", "2002-07-17", "Nizhny Novgorod, 3 Marta str., No. 24", "xkrkdehe12@bk.ru", 8, 1);

INSERT INTO Student(full_name, date_of_birth, address, email, group_id, budget)
VALUES 
("Emelyanova Leya Frolovna", "2002-12-22", "Tolyatti, Lesnoy lane, No. 16", "ipcsclnt28@bk.ru", 9, 1),
("Safonova Geliana Filatovna", "2003-01-11", "Volzhsky, Druzhby str., No. 10", "mttjajjz30@bk.ru", 9, 0),
("Tikhonova Marta Andreevna", "2003-09-16", "Kemerovo, Polevoy lane, No. 19", "hkmmsfks85@bk.ru", 9, 1),
("Efremova Valentina Melorovna", "2004-07-12", "Magnitogorsk, Molodezhnaya str., No. 15", "fqeifypz80@bk.ru", 9, 1),
("Kolobova Ilena Artemovna", "2002-09-29", "Kopeysk, Oktyabrsky lane, No. 17", "cpvtwwoo29@bk.ru", 9, 0),
("Kulikova Vasilisa Efimovna", "2002-10-18", "Bryansk, Kirova str., No. 16", "imlrquke48@bk.ru", 9, 0),
("Zimina Daryana Stanislavovna", "2000-01-15", "Arzamas, Pionerskaya str., No. 14", "jlzkdeum52@bk.ru", 9, 1),
("Kudryavtseva Grazhina Parfenyevna", "2002-02-07", "Kamyshin, Lenina V.I. str., No. 10", "pjtzdhrq50@bk.ru", 9, 0),
("Gorshkov Leonard Dmitrievich", "2003-11-07", "Blagoveshchensk, Lesnoy lane, No. 9", "cqxcffpe59@bk.ru", 9, 0),
("Bobylev Averkiy Dmitrievich", "2003-07-01", "Pervouralsk, Polevaya str., No. 25", "yumnmqtj31@bk.ru", 9, 1),
("Filippov Daniil Yuryevich", "2002-09-22", "Yelets, Polevoy lane, No. 5", "yumnmqtsj31@bk.ru", 9, 1),
("Vladimirov Osip Irineevich", "2001-10-27", "Zheleznogorsk, Michurina str., No. 10", "yumnmqsadtj31@bk.ru", 9, 1),
("Filippov Yaroslav Filatovich", "2003-11-17", "Miass, Tsvetochnaya str., No. 25", "yumsadaznmqtj31@bk.ru", 9, 1),
("Bragin Artem Nikitevich", "2004-12-14", "Syzran, Yubileynaya str., No. 11", "yumsadqsnmqtj31@bk.ru", 9, 1),
("Shashkov Vladimir Efimovich", "2003-02-11", "Kostroma, Zavodskaya str., No. 18", "yumnfsaqmqtj31@bk.ru", 9, 1);

INSERT INTO Phone_numbers(student_id, phone_number)
VALUES

(1, "+79048061802"),
(2, "+79546203578"),
(3, "+79936318426"),
(4, "+79039627604"),
(5, "+79173442983"),
(6, "+79415618707"),
(7, "+79198825103"),
(8, "+79815433829"),
(9, "+79330614924"),
(10, "+79286770640"),
(11, "+79042552700"),
(12, "+79003291047"),
(13, "+79565040415"),
(14, "+79147948239"),
(15, "+79293878495"),
(16, "+79264355611"),
(17, "+79852341841"),
(18, "+79869550873"),
(19, "+79233364725"),
(20, "+79218677081"),
(21, "+79234981400"),
(22, "+79887671279"),
(23, "+79808544842"),
(24, "+79945785194"),
(25, "+79337500572"),
(26, "+79509933277"),
(27, "+79851429156"),
(28, "+79210257665"),
(29, "+79271902337"),
(30, "+79960684845"),
(31, "+79921236807"),
(32, "+79532750779"),
(33, "+79179556936"),
(34, "+79774358161"),
(35, "+79327641195"),
(36, "+79328804913"),
(37, "+79661076934"),
(38, "+79787312828"),
(39, "+79893103000"),
(40, "+79374621453"),
(41, "+79165314473"),
(42, "+79602986017"),
(43, "+79201423462"),
(44, "+79274776777"),
(45, "+79277724888"),
(46, "+79384791239"),
(47, "+79325499868"),
(48, "+79600148414"),
(49, "+79581208298"),
(50, "+79296719668"),
(51, "+79953955796"),
(52, "+79167751037"),
(53, "+79947895870"),
(54, "+79287828545"),
(55, "+79713546229"),
(56, "+79781047873"),
(57, "+79249454852"),
(58, "+79549097571"),
(59, "+79851913349"),
(60, "+79209791266"),
(61, "+79846643183"),
(62, "+79125692800"),
(63, "+79789626705"),
(64, "+79060838058"),
(65, "+79002402365"),
(66, "+79610909316"),
(67, "+79820594620"),
(68, "+79215991387"),
(69, "+79112038773"),
(70, "+79808892905"),
(71, "+79850385938"),
(72, "+79946004373"),
(73, "+79148974075"),
(74, "+79097068056"),
(75, "+79314210530"),
(76, "+79260114308"),
(77, "+79399195452"),
(78, "+79146352065"),
(79, "+79712102601"),
(80, "+79125482841"),
(81, "+79659915000"),
(82, "+79719028448"),
(83, "+79941554960"),
(84, "+79656323952"),
(85, "+79526448708"),
(86, "+79004941735"),
(87, "+79700920591"),
(88, "+79195367015"),
(89, "+79207179941"),
(90, "+79032085122"),
(91, "+79335734092"),
(92, "+79193165320"),
(93, "+79850318117"),
(94, "+79293493458"),
(95, "+79027489945");

INSERT INTO Teachers(name)
    VALUES
        ("Osipov Fyodor Leonidovich"),
        ("Osipov Alexander Leonidovich"),
        ("Cheglov Yegor Romanovich"),
        ("Kovrigin Alexey Viktorovich"),
        ("Pashkov Petr Mikhaylovich");

INSERT INTO Disciplines(name)
    VALUES
        ("Programming of discrete structures"),
        ("Data analysis"),
        ("Information security"),
        ("Programming technologies"),
        ("Combinatorics"),
        ("Database technologies"),
        ("Information systems design");

INSERT INTO DirectionDisciplineTeacher(direction_id, 
discipline_id, teacher_id)
    VALUES
        (1, 1, 1),
        (1, 3, 5),
        (1, 6, 4);
        
INSERT INTO DirectionDisciplineTeacher(direction_id, 
discipline_id, teacher_id)
    VALUES
        (2, 4, 2),
        (2, 5, 5),
        (2, 2, 2),
        (2, 7, 3);

INSERT INTO DirectionDisciplineTeacher(direction_id, 
discipline_id, teacher_id)
    VALUES
        (3, 5, 5),
        (3, 3, 5),
        (3, 6, 4),
        (3, 1, 1);
INSERT INTO Marks(student_id, sub_disc_teach_id, mark)
    VALUES
        (1, 1, 5), (1, 2, 5), (1, 3, 5),
        (2, 1, 3), (2, 2, 5), (2, 3, 4),
        (3, 1, 2), (3, 2, 4), (3, 3, 3),
        (4, 1, 5), (4, 2, 2), (4, 3, 5),
        (5, 1, 4), (5, 2, 3), (5, 3, 5),
        (6, 1, 3), (6, 2, 4), (6, 3, 4),
        (7, 1, 3), (7, 2, 4), (7, 3, 5),
        (8, 1, 2), (8, 2, 2), (8, 3, 2),
        (9, 1, 2), (9, 2, 2), (9, 3, 2),
        (10, 1, 5), (10, 2, 4), (10, 3, 5),
        (11, 1, 5), (11, 2, 3), (11, 3, 4),
        (12, 1, 5), (12, 2, 5), (12, 3, 5),
        (13, 1, 2), (13, 2, 2), (13, 3, 2),
        (14, 1, 4), (14, 2, 4), (14, 3, 4),
        (15, 1, 3), (15, 2, 3), (15, 3, 3),
        (16, 1, 5), (16, 2, 2), (16, 3, 3),
        (17, 1, 4), (17, 2, 5), (17, 3, 5),
        (18, 1, 4), (18, 2, 5), (18, 3, 5),
        (19, 1, 3), (19, 2, 5), (19, 3, 4),
        (20, 1, 5), (20, 2, 4), (20, 3, 2),
        (21, 1, 2), (21, 2, 5), (21, 3, 5),
        (22, 1, 5), (22, 2, 5), (22, 3, 5),
        (23, 1, 4), (23, 2, 4), (23, 3, 4);

INSERT INTO Marks(student_id, sub_disc_teach_id, mark)
    VALUES 
        (24, 4, 5), (24, 5, 5), (24, 6, 5), (24, 7, 5),
        (25, 4, 4), (25, 5, 3), (25, 6, 4), (25, 7, 4),
        (26, 4, 2), (26, 5, 5), (26, 6, 5), (26, 7, 4),
        (27, 4, 5), (27, 5, 3), (27, 6, 3), (27, 7, 4),
        (28, 4, 5), (28, 5, 2), (28, 6, 3), (28, 7, 4),
        (29, 4, 2), (29, 5, 3), (29, 6, 4), (29, 7, 5),
        (30, 4, 4), (30, 5, 4), (30, 6, 4), (30, 7, 4),
        (31, 4, 5), (31, 5, 4), (31, 6, 5), (31, 7, 4),
        (32, 4, 5), (32, 5, 5), (32, 6, 5), (32, 7, 5),
        (33, 4, 5), (33, 5, 5), (33, 6, 5), (33, 7, 4),
        (34, 4, 4), (34, 5, 5), (34, 6, 5), (34, 7, 5),
        (35, 4, 4), (35, 5, 3), (35, 6, 5), (35, 7, 4),
        (36, 4, 5), (36, 5, 5), (36, 6, 5), (36, 7, 4),
        (37, 4, 4), (37, 5, 4), (37, 6, 4), (37, 7, 4),
        (38, 4, 5), (38, 5, 5), (38, 6, 5), (38, 7, 4),
        (39, 4, 3), (39, 5, 5), (39, 6, 2), (39, 7, 4),
        (40, 4, 5), (40, 5, 5), (40, 6, 5), (40, 7, 4),
        (41, 4, 3), (41, 5, 5), (41, 6, 4), (41, 7, 4),
        (42, 4, 5), (42, 5, 4), (42, 6, 4), (42, 7, 2),
        (43, 4, 3), (43, 5, 3), (43, 6, 3), (43, 7, 3),
        (44, 4, 4), (44, 5, 4), (44, 6, 4), (44, 7, 4),
        (45, 4, 5), (45, 5, 5), (45, 6, 5), (45, 7, 5),
        (46, 4, 5), (46, 5, 5), (46, 6, 3), (46, 7, 4),
        (47, 4, 5), (47, 5, 2), (47, 6, 4), (47, 7, 5),
        (48, 4, 2), (48, 5, 5), (48, 6, 5), (48, 7, 4),
        (49, 4, 5), (49, 5, 4), (49, 6, 3), (49, 7, 4),
        (50, 4, 4), (50, 5, 3), (50, 6, 5), (50, 7, 4),
        (51, 4, 4), (51, 5, 5), (51, 6, 5), (51, 7, 4),
        (52, 4, 4), (52, 5, 4), (52, 6, 5), (52, 7, 5),
        (53, 4, 2), (53, 5, 2), (53, 6, 2), (53, 7, 2);


INSERT INTO Marks(student_id, sub_disc_teach_id, mark)
    VALUES 
        (54, 8, 5), (54, 9, 5), (54, 10, 5), (54, 11, 5),
        (55, 8, 4), (55, 9, 3), (55, 10, 4), (55, 11, 4),
        (56, 8, 2), (56, 9, 5), (56, 10, 5), (56, 11, 4),
        (57, 8, 5), (57, 9, 3), (57, 10, 3), (57, 11, 4),
        (58, 8, 5), (58, 9, 2), (58, 10, 3), (58, 11, 4),
        (59, 8, 2), (59, 9, 3), (59, 10, 4), (59, 11, 5),
        (60, 8, 4), (60, 9, 4), (60, 10, 4), (60, 11, 4),
        (61, 8, 5), (61, 9, 4), (61, 10, 5), (61, 11, 4),
        (62, 8, 5), (62, 9, 5), (62, 10, 5), (62, 11, 5),
        (63, 8, 5), (63, 9, 5), (63, 10, 5), (63, 11, 4),
        (64, 8, 4), (64, 9, 5), (64, 10, 5), (64, 11, 5),
        (65, 8, 4), (65, 9, 3), (65, 10, 5), (65, 11, 4),
        (66, 8, 5), (66, 9, 5), (66, 10, 5), (66, 11, 4),
        (67, 8, 4), (67, 9, 4), (67, 10, 4), (67, 11, 4),
        (68, 8, 5), (68, 9, 5), (68, 10, 5), (68, 11, 4),
        (69, 8, 3), (69, 9, 5), (69, 10, 2), (69, 11, 4),
        (70, 8, 5), (70, 9, 5), (70, 10, 5), (70, 11, 4),
        (71, 8, 3), (71, 9, 5), (71, 10, 4), (71, 11, 4),
        (72, 8, 5), (72, 9, 4), (72, 10, 4), (72, 11, 2),
        (73, 8, 3), (73, 9, 3), (73, 10, 3), (73, 11, 3),
        (74, 8, 4), (74, 9, 4), (74, 10, 4), (74, 11, 4),
        (75, 8, 5), (75, 9, 5), (75, 10, 5), (75, 11, 5),
        (76, 8, 5), (76, 9, 5), (76, 10, 3), (76, 11, 4),
        (77, 8, 5), (77, 9, 2), (77, 10, 4), (77, 11, 5),
        (78, 8, 2), (78, 9, 5), (78, 10, 5), (78, 11, 4),
        (79, 8, 5), (79, 9, 4), (79, 10, 3), (79, 11, 4),
        (80, 8, 4), (80, 9, 3), (80, 10, 5), (80, 11, 4),
        (81, 8, 4), (81, 9, 5), (81, 10, 5), (81, 11, 4),
        (82, 8, 4), (82, 9, 4), (82, 10, 5), (82, 11, 5),
        (83, 8, 2), (83, 9, 2), (83, 10, 2), (83, 11, 2),
        (84, 8, 4), (84, 9, 4), (84, 10, 4), (84, 11, 4),
        (85, 8, 5), (85, 9, 5), (85, 10, 5), (85, 11, 5),
        (86, 8, 5), (86, 9, 5), (86, 10, 3), (86, 11, 4),
        (87, 8, 5), (87, 9, 2), (87, 10, 4), (87, 11, 5),
        (88, 8, 2), (88, 9, 5), (88, 10, 5), (88, 11, 4),
        (89, 8, 5), (89, 9, 4), (89, 10, 3), (89, 11, 4),
        (90, 8, 4), (90, 9, 3), (90, 10, 5), (90, 11, 4),
        (91, 8, 4), (91, 9, 5), (91, 10, 5), (91, 11, 4),
        (92, 8, 4), (92, 9, 4), (92, 10, 5), (92, 11, 5),
        (93, 8, 4), (93, 9, 3), (93, 10, 5), (93, 11, 4),
        (94, 8, 4), (94, 9, 5), (94, 10, 5), (94, 11, 4),
        (95, 8, 2), (95, 9, 2), (95, 10, 2), (95, 11, 2);


INSERT INTO Pair_time(time_start, time_end)
VALUES
("8:00", "9:30"), ("9:40", "11:10"),
("11:25", "12:50"), ("13:20", "14:50"),
("15:05", "16:35"), ("16:50", "18:20"),
("18:30", "20:00"), ("20:05", "21:35");


INSERT INTO Lessons_schedule(sub_disc_teach_id, time_id, date)
VALUES 	(1, 1, "2023-09-01"),
        (1, 2, "2023-09-11"),
        (1, 3, "2023-10-01"),
        (1, 4, "2023-10-11"),
        (1, 5, "2023-11-01"),
        (1, 6, "2023-11-11"),
        (1, 7, "2023-12-01"),
        (1, 8, "2023-12-11"),
        (2, 1, "2023-09-02"),
        (2, 2, "2023-09-12"),
        (2, 3, "2023-10-02"),
        (2, 4, "2023-10-12"),
        (2, 5, "2023-11-02"),
        (2, 6, "2023-11-12"),
        (2, 7, "2023-12-02"),
        (2, 8, "2023-12-12"),
        (3, 1, "2023-09-03"),
        (3, 2, "2023-09-13"),
        (3, 3, "2023-10-03"),
        (3, 4, "2023-10-13"),
        (3, 5, "2023-11-03"),
        (3, 6, "2023-11-13"),
        (3, 7, "2023-12-03"),
        (3, 8, "2023-12-13"),
        (4, 1, "2023-09-04"),
        (4, 2, "2023-09-14"),
        (4, 3, "2023-10-04"),
        (4, 4, "2023-10-14"),
        (4, 5, "2023-11-04"),
        (4, 6, "2023-11-14"),
        (4, 7, "2023-12-04"),
        (4, 8, "2023-12-14"),
        (5, 1, "2023-09-05"),
        (5, 2, "2023-09-15"),
        (5, 3, "2023-10-05"),
        (5, 4, "2023-10-15"),
        (5, 5, "2023-11-05"),
        (5, 6, "2023-11-16"),
        (5, 7, "2023-12-05"),
        (5, 8, "2023-12-15"),
        (6, 1, "2023-09-06"),
        (6, 2, "2023-09-16"),
        (6, 3, "2023-10-06"),
        (6, 4, "2023-10-16"),
        (6, 5, "2023-11-06"),
        (6, 6, "2023-11-16"),
        (6, 7, "2023-12-06"),
        (6, 8, "2023-12-16"),
        (7, 1, "2023-09-07"),
        (7, 2, "2023-09-17"),
        (7, 3, "2023-10-07"),
        (7, 4, "2023-10-17"),
        (7, 5, "2023-11-07"),
        (7, 6, "2023-11-17"),
        (7, 7, "2023-12-07"),
        (7, 8, "2023-12-17"),
        (8, 1, "2023-09-07"),
        (8, 2, "2023-09-17"),
        (8, 3, "2023-10-07"),
        (8, 4, "2023-10-17"),
        (8, 5, "2023-11-07"),
        (8, 6, "2023-11-17"),
        (8, 7, "2023-12-07"),
        (8, 8, "2023-12-17"),
        (9, 1, "2023-09-08"),
        (9, 2, "2023-09-18"),
        (9, 3, "2023-10-08"),
        (9, 4, "2023-10-18"),
        (9, 5, "2023-11-08"),
        (9, 6, "2023-11-18"),
        (9, 7, "2023-12-08"),
        (9, 8, "2023-12-18"),
        (10, 1, "2023-09-09"),
        (10, 2, "2023-09-19"),
        (10, 3, "2023-10-09"),
        (10, 4, "2023-10-19"),
        (10, 5, "2023-11-09"),
        (10, 6, "2023-11-19"),
        (10, 7, "2023-12-09"),
        (10, 8, "2023-12-19"),
        (11, 1, "2023-09-10"),
        (11, 2, "2023-09-20"),
        (11, 3, "2023-10-10"),
        (11, 4, "2023-10-20"),
        (11, 5, "2023-11-10"),
        (11, 6, "2023-11-20"),
        (11, 7, "2023-12-10"),
        (11, 8, "2023-12-20");


INSERT INTO Attendance(schedule_id, student_id, presence)  presence
VALUES
(1, 1, 0),
(1, 2, 1),
(1, 3, 1),
(1, 4, 0),
(1, 5, 1),
(1, 6, 0),
(1, 7, 1),
(1, 8, 1),
(1, 9, 1);
