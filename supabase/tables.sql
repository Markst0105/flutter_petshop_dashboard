create table users(
  cpf varchar(12) not null primary key,
  name varchar(30) not null,
  dateBirth date not null,
  email varchar(30) not null,
  password_hash text not null
);

create table petowner(
  cpf varchar(12) not null primary key,
  dateBirth date not null,
  gender varchar(10) not null,
  name varchar(30) not null,
  cellNumber varchar(15) not null
);

create table pet(
  petID serial primary key,
  cpf varchar(12) not null,
  type varchar(10) not null,
  race varchar(20),
  size varchar(10) not null,
  dateBirth date not null,
  weight numeric(5, 2) not null,
  name varchar(20) not null,
  constraint ck_pet check (weight > 0),
  constraint fk_pet foreign key (cpf) references petOwner(cpf)
);

create table booking(
  bookingID serial primary key,
  petID integer not null,
  dateBooking date not null,
  timeBooking time not null,
  duration integer,
  unique (petID),
  constraint fk_booking foreign key (petID) references pet(petID),
  constraint ck_booking check (duration > 0),
  constraint ck_booking2 check (dateBooking > current_date)
);

create table users_booking(
  cpf varchar(12) not null,
  bookingID integer not null,
  constraint pk_users_booking primary key (cpf, bookingID),
  constraint fk_users_booking foreign key (cpf) references users(cpf),
  constraint fk_users_booking2 foreign key (bookingID) references booking(bookingID)
);

create table service(
  serviceName varchar(30) not null primary key,
  sizeDestined varchar(20) not null,
  duration integer not null,
  price numeric(5, 2) not null,
  constraint ck_service check (duration > 0),
  constraint ck_service2 check (price > 0)
);

create table booking_service(
  serviceName varchar(30) not null,
  bookingID integer not null,
  constraint pk_booking_service primary key (serviceName, bookingID),
  constraint fk_service foreign key (serviceName) references service(serviceName),
  constraint fk_booking foreign key (bookingID) references booking(bookingID)
);
