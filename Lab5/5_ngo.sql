-- Design a database for an NGO's head offices, projects, actions and cities.
-- Store the investment of each project in each city and describe each action.
create table head_office (
    office_id int unsigned auto_increment primary key,
    city varchar(120) not null,
    country varchar(120) not null,
    address varchar(255) not null,
    phone varchar(32) not null,
    director_name varchar(255) not null
);

create table project (
    project_code varchar(32) primary key,
    office_id int unsigned not null,
    title varchar(255) not null,
    start_date date not null,
    end_date date not null,
    budget decimal(15, 2) not null,
    manager_name varchar(255) not null,
    foreign key (office_id) references head_office (office_id),
    check (end_date >= start_date),
    check (budget >= 0)
);

create table city (
    city_id int unsigned auto_increment primary key,
    name varchar(120) not null,
    country varchar(120) not null,
    population int unsigned not null
);

create table project_action (
    project_code varchar(32) not null,
    action_number int unsigned not null,
    description varchar(500) not null,
    primary key (project_code, action_number),
    foreign key (project_code) references project (project_code),
    check (action_number > 0)
);

create table project_city (
    project_code varchar(32) not null,
    city_id int unsigned not null,
    investment decimal(15, 2) not null,
    primary key (project_code, city_id),
    foreign key (project_code) references project (project_code),
    foreign key (city_id) references city (city_id),
    check (investment >= 0)
);

create table action_city (
    project_code varchar(32) not null,
    action_number int unsigned not null,
    city_id int unsigned not null,
    primary key (project_code, action_number, city_id),
    foreign key (project_code, action_number)
        references project_action (project_code, action_number),
    foreign key (project_code, city_id)
        references project_city (project_code, city_id)
);

describe head_office;
describe project;
describe city;
describe project_action;
describe project_city;
describe action_city;
