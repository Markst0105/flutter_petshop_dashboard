CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Insert into users using bcrypt hashing for passwords
INSERT INTO users (cpf, name, dateBirth, email, password_hash) VALUES
('11111111111', 'João Silva', '1990-05-15', 'joao.silva@email.com', crypt('senhaJoao123', gen_salt('bf'))),
('22222222222', 'Maria Santos', '1985-10-20', 'maria.santos@email.com', crypt('mariaSenha456', gen_salt('bf'))),
('33333333333', 'Pedro Oliveira', '1992-03-10', 'pedro.oliveira@email.com', crypt('pedroPass789', gen_salt('bf'))),
('44444444444', 'Ana Costa', '1988-12-05', 'ana.costa@email.com', crypt('anaCosta2026', gen_salt('bf'))),
('55555555555', 'Lucas Souza', '1995-07-22', 'lucas.souza@email.com', crypt('lucasSouza!@#', gen_salt('bf')));

-- 2. Insert into petowner (Independent Table)
INSERT INTO petowner (cpf, dateBirth, gender, name, cellNumber) VALUES
('66666666666', '1980-01-12', 'Male', 'Carlos Pereira', '11987654321'),
('77777777777', '1993-04-25', 'Female', 'Fernanda Lima', '21976543210'),
('88888888888', '1975-08-30', 'Male', 'Roberto Alves', '31965432109'),
('99999999999', '1998-11-14', 'Female', 'Juliana Gomes', '41954321098'),
('10101010101', '1982-06-18', 'Male', 'Marcos Dias', '51943210987');

-- 3. Insert into pet (Depends on petowner)
-- Note: petID is auto-generated via SERIAL (will be 1, 2, 3, 4, 5)
INSERT INTO pet (cpf, type, race, size, dateBirth, weight, name) VALUES
('66666666666', 'Dog', 'Vira-lata', 'Medium', '2020-02-10', 15.50, 'Rex'),
('77777777777', 'Cat', 'Siamês', 'Small', '2021-05-20', 4.20, 'Mel'),
('88888888888', 'Dog', 'Poodle', 'Small', '2019-09-15', 7.00, 'Thor'),
('99999999999', 'Dog', 'Bulldog', 'Medium', '2022-01-05', 20.30, 'Bolinha'),
('10101010101', 'Cat', 'Persa', 'Small', '2023-08-11', 3.80, 'Nina');

-- 4. Insert into booking (Depends on pet)
-- Note: bookingID is auto-generated via SERIAL. 
-- petID must be UNIQUE per booking based on your schema constraint.
-- dateBooking is set in the future relative to the current year.
INSERT INTO booking (petID, dateBooking, timeBooking, duration) VALUES
(1, '2026-12-01', '09:00:00', 60),
(2, '2026-12-02', '10:30:00', 45),
(3, '2026-12-03', '14:00:00', 90),
(4, '2026-12-04', '11:00:00', 60),
(5, '2026-12-05', '16:00:00', 30);

-- 5. Insert into users_booking (Depends on users and booking)
INSERT INTO users_booking (cpf, bookingID) VALUES
('11111111111', 1),
('22222222222', 2),
('33333333333', 3),
('44444444444', 4),
('55555555555', 5);

-- Insert into service (Accommodating 3 sizes per service)
INSERT INTO service (serviceName, sizeDestined, duration, price) VALUES
-- Banho
('Banho - P', 'Small', 30, 25.00),
('Banho - M', 'Medium', 45, 35.00),
('Banho - G', 'Large', 60, 45.00),

-- Tosa
('Tosa - P', 'Small', 30, 30.00),
('Tosa - M', 'Medium', 45, 45.00),
('Tosa - G', 'Large', 60, 60.00),

-- Corte de Unhas
('Corte de Unhas - P', 'Small', 15, 15.00),
('Corte de Unhas - M', 'Medium', 15, 20.00),
('Corte de Unhas - G', 'Large', 15, 25.00),

-- Limpeza de Dentes
('Limpeza de Dentes - P', 'Small', 30, 40.00),
('Limpeza de Dentes - M', 'Medium', 30, 50.00),
('Limpeza de Dentes - G', 'Large', 30, 60.00),

-- Limpeza de Orelhas
('Limpeza de Orelhas - P', 'Small', 15, 20.00),
('Limpeza de Orelhas - M', 'Medium', 15, 25.00),
('Limpeza de Orelhas - G', 'Large', 15, 30.00),

-- Tosa Completa
('Tosa Completa - P', 'Small', 60, 60.00),
('Tosa Completa - M', 'Medium', 90, 80.00),
('Tosa Completa - G', 'Large', 120, 100.00),

-- Remoção de Subpelo
('Remoção de Subpelo - P', 'Small', 45, 35.00),
('Remoção de Subpelo - M', 'Medium', 60, 50.00),
('Remoção de Subpelo - G', 'Large', 90, 65.00),

-- Tratamento Antipulgas
('Tratamento Antipulgas - P', 'Small', 20, 25.00),
('Tratamento Antipulgas - M', 'Medium', 20, 35.00),
('Tratamento Antipulgas - G', 'Large', 20, 45.00);


-- Matching pet sizes: Booking 1 & 4 (Medium), Booking 2, 3, & 5 (Small)
INSERT INTO booking_service (serviceName, bookingID) VALUES
-- Booking 1: Medium Dog
('Banho - M', 1),
('Limpeza de Orelhas - M', 1),

-- Booking 2: Small Cat
('Corte de Unhas - P', 2),

-- Booking 3: Small Dog
('Tosa Completa - P', 3),
('Tratamento Antipulgas - P', 3),

-- Booking 4: Medium Dog
('Banho - M', 4),
('Remoção de Subpelo - M', 4),

-- Booking 5: Small Cat
('Limpeza de Orelhas - P', 5);