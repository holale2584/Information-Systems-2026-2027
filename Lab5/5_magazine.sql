-- Design a database to manage information about the magazines that you buy
-- habitually, including their issues, articles, and ordered authors.
create table magazine (
    issn char(9) primary key,
    title varchar(255) not null
);

create table magazine_issue (
    issn char(9) not null,
    issue_year smallint unsigned not null,
    issue_number int unsigned not null,
    primary key (issn, issue_year, issue_number),
    foreign key (issn) references magazine (issn),
    check (issue_number > 0)
);

create table article (
    article_id int unsigned auto_increment primary key,
    issn char(9) not null,
    issue_year smallint unsigned not null,
    issue_number int unsigned not null,
    title varchar(255) not null unique,
    first_page int unsigned not null,
    last_page int unsigned not null,
    foreign key (issn, issue_year, issue_number)
        references magazine_issue (issn, issue_year, issue_number),
    check (first_page > 0 and last_page >= first_page)
);

create table author (
    author_id int unsigned auto_increment primary key,
    name varchar(255) not null,
    email varchar(254) not null,
    affiliation varchar(255) not null
);

create table article_author (
    article_id int unsigned not null,
    author_id int unsigned not null,
    author_order int unsigned not null,
    primary key (article_id, author_id),
    unique (article_id, author_order),
    foreign key (article_id) references article (article_id),
    foreign key (author_id) references author (author_id),
    check (author_order > 0)
);

describe magazine;
describe magazine_issue;
describe article;
describe author;
describe article_author;
