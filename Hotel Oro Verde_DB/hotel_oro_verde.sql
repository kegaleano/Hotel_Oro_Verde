/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     23/05/2025 13:00:10                          */
/*==============================================================*/


drop index CIUDAD_PK;

drop table CIUDAD;

drop index RELATIONSHIP_7_FK;

drop index CLIENTE_PK;

drop table CLIENTE;

drop index CODIGO_DESCUENTO_PK;

drop table CODIGO_DESCUENTO;

drop index RELATIONSHIP_3_FK;

drop index HABITACION_PK;

drop table HABITACION;

drop index RELATIONSHIP_13_FK;

drop index HOTEL_PK;

drop table HOTEL;

drop index RELATIONSHIP_9_FK;

drop index PAGO_PK;

drop table PAGO;

drop index PAIS_PK;

drop table PAIS;

drop index RELATIONSHIP_8_FK;

drop index RELATIONSHIP_6_FK;

drop index RELATIONSHIP_5_FK;

drop index RESERVA_PK;

drop table RESERVA;

drop domain ESTADO;

/*==============================================================*/
/* Domain: ESTADO                                               */
/*==============================================================*/
create domain ESTADO as VARCHAR(10);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   ID_CIUDAD            SERIAL not null,
   NOMBRE_CIUDAD        VARCHAR(30)          not null,
   constraint PK_CIUDAD primary key (ID_CIUDAD)
);

/*==============================================================*/
/* Index: CIUDAD_PK                                             */
/*==============================================================*/
create unique index CIUDAD_PK on CIUDAD (
ID_CIUDAD
);


/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CEDULA_CLIENTE       SERIAL not null,
   ID_PAIS              INT4                 null,
   NOMBRE_CLIENTE       VARCHAR(25)          not null,
   APELLIDO_CLIENTE     VARCHAR(25)          not null,
   TELEFONO_CLIENTE     VARCHAR(15)          not null,
   CORREO_CLIENTE       VARCHAR(50)          not null,
   DIRECCION_CLIENTE    VARCHAR(40)          not null,
   DIRECCION_SECUNDARIA_CLIENTE VARCHAR(40)          null,
   CIUDAD_CLIENTE       VARCHAR(30)          not null,
   CODIGO_POSTAL_CLIENTE INT4                 not null,
   PROVINCIA_CLIENTE    VARCHAR(50)          not null,
   constraint PK_CLIENTE primary key (CEDULA_CLIENTE)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
CEDULA_CLIENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on CLIENTE (
ID_PAIS
);

/*==============================================================*/
/* Table: CODIGO_DESCUENTO                                      */
/*==============================================================*/
create table CODIGO_DESCUENTO (
   ID_PROM              SERIAL not null,
   NOMBRE_PROM          VARCHAR(50)          not null,
   CODIGO_PROM          CHAR(10)             not null,
   DESCUENTO_PORCENTAJE_PROM DECIMAL(5,2)         not null,
   FECHA_INICIO_PROM    DATE                 not null,
   FECHA_FIN_PROM       DATE                 not null,
   DESCRIPCION_PROM     VARCHAR(300)         not null,
   constraint PK_CODIGO_DESCUENTO primary key (ID_PROM)
);

/*==============================================================*/
/* Index: CODIGO_DESCUENTO_PK                                   */
/*==============================================================*/
create unique index CODIGO_DESCUENTO_PK on CODIGO_DESCUENTO (
ID_PROM
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION (
   ID_HABITACION        SERIAL not null,
   ID_HOTEL             INT4                 not null,
   NOMBRE_HABITACION    VARCHAR(35)          not null,
   CAPACIDAD_HABITACION VARCHAR(3)           not null,
   CAMAS_HABITACION     VARCHAR(2)           not null,
   DESCRIPCION_HABITACION VARCHAR(400)         not null,
   IMAGEN_HABITACION    VARCHAR(300)         not null,
   PRECIO_HABITACION    DECIMAL(10,4)        not null,
   constraint PK_HABITACION primary key (ID_HABITACION)
);

/*==============================================================*/
/* Index: HABITACION_PK                                         */
/*==============================================================*/
create unique index HABITACION_PK on HABITACION (
ID_HABITACION
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on HABITACION (
ID_HOTEL
);

/*==============================================================*/
/* Table: HOTEL                                                 */
/*==============================================================*/
create table HOTEL (
   ID_HOTEL             SERIAL not null,
   ID_CIUDAD            INT4                 not null,
   NOMBRE_HOTEL         VARCHAR(35)          not null,
   TELEFONO_HOTEL       VARCHAR(10)          not null,
   CORREO_HOTEL         VARCHAR(40)          not null,
   constraint PK_HOTEL primary key (ID_HOTEL)
);

/*==============================================================*/
/* Index: HOTEL_PK                                              */
/*==============================================================*/
create unique index HOTEL_PK on HOTEL (
ID_HOTEL
);

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_13_FK on HOTEL (
ID_CIUDAD
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   ID_PAGO              SERIAL not null,
   ID_RESERVA           INT4                 not null,
   FECHA_PAGO           DATE                 not null,
   VALOR_PAGO           DECIMAL(10,4)        not null,
   ESTADO_PAGO          VARCHAR(15)          not null,
   TITULAR_TARJETA      VARCHAR(30)          not null,
   NUMERO_TARJETA       VARCHAR(16)          not null,
   FECHACADUCIDAD_TARJETA DATE                 not null,
   CVV_TARJETA          VARCHAR(4)           not null,
   constraint PK_PAGO primary key (ID_PAGO)
);

/*==============================================================*/
/* Index: PAGO_PK                                               */
/*==============================================================*/
create unique index PAGO_PK on PAGO (
ID_PAGO
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_9_FK on PAGO (
ID_RESERVA
);

/*==============================================================*/
/* Table: PAIS                                                  */
/*==============================================================*/
create table PAIS (
   ID_PAIS              SERIAL not null,
   NOMBRE_PAIS          VARCHAR(50)          not null,
   constraint PK_PAIS primary key (ID_PAIS)
);

/*==============================================================*/
/* Index: PAIS_PK                                               */
/*==============================================================*/
create unique index PAIS_PK on PAIS (
ID_PAIS
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA (
   ID_RESERVA           SERIAL not null,
   CEDULA_CLIENTE       INT4                 not null,
   ID_HABITACION        INT4                 not null,
   ID_PROM              INT4                 null,
   FECHA_RESERVA        DATE                 not null,
   FECHA_ENTRADA        DATE                 not null,
   FECHA_SALIDA         DATE                 not null,
   constraint PK_RESERVA primary key (ID_RESERVA)
);

/*==============================================================*/
/* Index: RESERVA_PK                                            */
/*==============================================================*/
create unique index RESERVA_PK on RESERVA (
ID_RESERVA
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on RESERVA (
CEDULA_CLIENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_6_FK on RESERVA (
ID_HABITACION
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_8_FK on RESERVA (
ID_PROM
);

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_PAIS foreign key (ID_PAIS)
      references PAIS (ID_PAIS)
      on delete restrict on update restrict;

alter table HABITACION
   add constraint FK_HABITACI_RELATIONS_HOTEL foreign key (ID_HOTEL)
      references HOTEL (ID_HOTEL)
      on delete restrict on update restrict;

alter table HOTEL
   add constraint FK_HOTEL_RELATIONS_CIUDAD foreign key (ID_CIUDAD)
      references CIUDAD (ID_CIUDAD)
      on delete restrict on update restrict;

alter table PAGO
   add constraint FK_PAGO_RELATIONS_RESERVA foreign key (ID_RESERVA)
      references RESERVA (ID_RESERVA)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_CLIENTE foreign key (CEDULA_CLIENTE)
      references CLIENTE (CEDULA_CLIENTE)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_HABITACI foreign key (ID_HABITACION)
      references HABITACION (ID_HABITACION)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_CODIGO_D foreign key (ID_PROM)
      references CODIGO_DESCUENTO (ID_PROM)
      on delete restrict on update restrict;


INSERT INTO PAIS (ID_PAIS, NOMBRE_PAIS) VALUES
(1, 'Afganistán'),
(2, 'Albania'),
(3, 'Alemania'),
(4, 'Andorra'),
(5, 'Angola'),
(6, 'Antigua y Barbuda'),
(7, 'Arabia Saudita'),
(8, 'Argelia'),
(9, 'Argentina'),
(10, 'Armenia'),
(11, 'Australia'),
(12, 'Austria'),
(13, 'Azerbaiyán'),
(14, 'Bahamas'),
(15, 'Bangladés'),
(16, 'Barbados'),
(17, 'Baréin'),
(18, 'Bélgica'),
(19, 'Belice'),
(20, 'Benín'),
(21, 'Bielorrusia'),
(22, 'Birmania'),
(23, 'Bolivia'),
(24, 'Bosnia y Herzegovina'),
(25, 'Botsuana'),
(26, 'Brasil'),
(27, 'Brunéi'),
(28, 'Bulgaria'),
(29, 'Burkina Faso'),
(30, 'Burundi'),
(31, 'Bután'),
(32, 'Cabo Verde'),
(33, 'Camboya'),
(34, 'Camerún'),
(35, 'Canadá'),
(36, 'Catar'),
(37, 'Chad'),
(38, 'Chile'),
(39, 'China'),
(40, 'Chipre'),
(41, 'Colombia'),
(42, 'Comoras'),
(43, 'Corea del Norte'),
(44, 'Corea del Sur'),
(45, 'Costa de Marfil'),
(46, 'Costa Rica'),
(47, 'Croacia'),
(48, 'Cuba'),
(49, 'Dinamarca'),
(50, 'Dominica'),
(51, 'Ecuador'),
(52, 'Egipto'),
(53, 'El Salvador'),
(54, 'Emiratos Arabes Unidos'),
(55, 'Eritrea'),
(56, 'Eslovaquia'),
(57, 'Eslovenia'),
(58, 'España'),
(59, 'Estados Unidos'),
(60, 'Estonia'),
(61, 'Esuatini'),
(62, 'Etiopía'),
(63, 'Filipinas'),
(64, 'Finlandia'),
(65, 'Fiyi'),
(66, 'Francia'),
(67, 'Gabón'),
(68, 'Gambia'),
(69, 'Georgia'),
(70, 'Ghana'),
(71, 'Granada'),
(72, 'Grecia'),
(73, 'Guatemala'),
(74, 'Guinea'),
(75, 'Guinea-Bisáu'),
(76, 'Guinea Ecuatorial'),
(77, 'Guyana'),
(78, 'Haití'),
(79, 'Honduras'),
(80, 'Hungría'),
(81, 'India'),
(82, 'Indonesia'),
(83, 'Irak'),
(84, 'Irán'),
(85, 'Irlanda'),
(86, 'Islandia'),
(87, 'Islas Marshall'),
(88, 'Islas Salomón'),
(89, 'Israel'),
(90, 'Italia'),
(91, 'Jamaica'),
(92, 'Japón'),
(93, 'Jordania'),
(94, 'Kazajistán'),
(95, 'Kenia'),
(96, 'Kirguistán'),
(97, 'Kiribati'),
(98, 'Kuwait'),
(99, 'Laos'),
(100, 'Lesoto'),
(101, 'Letonia'),
(102, 'Líbano'),
(103, 'Liberia'),
(104, 'Libia'),
(105, 'Liechtenstein'),
(106, 'Lituania'),
(107, 'Luxemburgo'),
(108, 'Madagascar'),
(109, 'Malasia'),
(110, 'Malaui'),
(111, 'Maldivas'),
(112, 'Malí'),
(113, 'Malta'),
(114, 'Marruecos'),
(115, 'Mauricio'),
(116, 'Mauritania'),
(117, 'México'),
(118, 'Micronesia'),
(119, 'Moldavia'),
(120, 'Mónaco'),
(121, 'Mongolia'),
(122, 'Montenegro'),
(123, 'Mozambique'),
(124, 'Namibia'),
(125, 'Nauru'),
(126, 'Nepal'),
(127, 'Nicaragua'),
(128, 'Níger'),
(129, 'Nigeria'),
(130, 'Noruega'),
(131, 'Nueva Zelanda'),
(132, 'Omán'),
(133, 'Países Bajos'),
(134, 'Pakistán'),
(135, 'Palaos'),
(136, 'Panamá'),
(137, 'Papúa Nueva Guinea'),
(138, 'Paraguay'),
(139, 'Perú'),
(140, 'Polonia'),
(141, 'Portugal'),
(142, 'Reino Unido'),
(143, 'República Centroafricana'),
(144, 'República Checa'),
(145, 'República del Congo'),
(146, 'República Democrática del Congo'),
(147, 'República Dominicana'),
(148, 'Ruanda'),
(149, 'Rumania'),
(150, 'Rusia'),
(151, 'Samoa'),
(152, 'San Cristóbal y Nieves'),
(153, 'San Marino'),
(154, 'San Vicente y las Granadinas'),
(155, 'Santa Lucía'),
(156, 'Santo Tomé y Príncipe'),
(157, 'Senegal'),
(158, 'Serbia'),
(159, 'Seychelles'),
(160, 'Sierra Leona'),
(161, 'Singapur'),
(162, 'Siria'),
(163, 'Somalia'),
(164, 'Sri Lanka'),
(165, 'Sudáfrica'),
(166, 'Sudán'),
(167, 'Sudán del Sur'),
(168, 'Suecia'),
(169, 'Suiza'),
(170, 'Surinam'),
(171, 'Tailandia'),
(172, 'Tanzania'),
(173, 'Tayikistán'),
(174, 'Timor Oriental'),
(175, 'Togo'),
(176, 'Tonga'),
(177, 'Trinidad y Tobago'),
(178, 'Túnez'),
(179, 'Turkmenistán'),
(180, 'Turquía'),
(181, 'Tuvalu'),
(182, 'Ucrania'),
(183, 'Uganda'),
(184, 'Uruguay'),
(185, 'Uzbekistán'),
(186, 'Vanuatu'),
(187, 'Venezuela'),
(188, 'Vietnam'),
(189, 'Yemen'),
(190, 'Zambia'),
(191, 'Zimbabue');

INSERT INTO ciudad (nombre_ciudad) VALUES 
('Guayaquil'),
('Cuenca'),
('Manta'),
('Machala'),
('Latacunga'),
('Loja');

INSERT INTO hotel (id_ciudad, nombre_hotel, telefono_hotel, correo_hotel) VALUES 
(1,'Oro Verde Guayaquil','1800676837','info@hotelesoroverde.com'),
(1,'Unipark Guayaquil','1800676837','info@hotelesoroverde.com'),
(1,'Hotel del Parque','1800676837','info@hotelesoroverde.com'),
(2,'Oro Verde Cuenca','1800676837','info@hotelesoroverde.com'),
(3,'Oro Verde Manta','1800676837','info@hotelesoroverde.com'),
(4,'Oro Verde Machala','1800676837','info@hotelesoroverde.com'),
(5,'Oro Verde Latacunga','1800676837','info@hotelesoroverde.com'),
(6,'Oro Verde Loja','1800676837','info@hotelesoroverde.com');


INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES 
(9,'Deluxe 2 Camas Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',105),
(9,'Deluxe King','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama King y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/standard_king_2_enhanced.jpg',140),
(9,'Deluxe Queen','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama Queen y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/main-image/deluxe_queen_enhanced.jpg',105.50),
(9,'Premium Floor King','2','1','Para el viajero más exigente, el Premium Floor cumple con todas las expectativas. Cuenta con servicio personalizado y beneficios exclusivos. Estas amplias habitaciones cuentan con una cama King, sábanas y cobertores de lujo, closets espaciosos con luz interna y piso flotante.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/premium_king_2_enhanced.jpg',135),
(9,'Leading Suite Business','4','1','Las Leading Suite son ideales para familias, grupos pequeños o viajeros que buscan más espacio, confort y privacidad. Estas habitaciones ofrecen una cama King con sala de estar separadas y áreas para dormir que incluyen dos SmartTV, un sofa cama, área para comer.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/jr_leading_suite_2_enhanced.jpg',175),
(9,'Premium Floor Suite King','2','1','Para el viajero más exigente, el Premium Floor cumple con todas las expectativas. Cuenta con servicio personalizado y beneficios exclusivos. Estas amplias habitaciones cuentan con una cama King y una pequeña sala de estar, sábanas y cobertores de lujo, closets espaciosos con luz interna y piso flotante.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/premium_suite_3_enhanced.jpg',215);

INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES 
(12,'Deluxe 2 Camas Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',99),
(12,'Deluxe King','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama King y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/standard_king_2_enhanced.jpg',99),
(12,'Suite','2','1','Trabaje o relájese en nuestra espaciosa Junior Suite con una cama King. Baño privado, amenidades modernas. Disfrute de estas amplia y cómoda habitación.','https://reservations.oroverdehotels.com/assets/hotel/114498/media/room/main-image/deluxe_king_enhanced.jpg',149),
(12,'Suite Presidencial','2','1','Experimente el verdadero lujo en nuestra Suite Presidencial con cama King Size, baño privado con hidromasaje, sala de estar y amenidades exclusivas.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/standard_king_2_enhanced.jpg',199);

INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES 
(13,'Deluxe King Vista al Mar','2','1','Elegante habitación con cama King, situada en el bloque principal del hotel, entre el primer y segundo piso. Ofrece una hermosa vista al mar y está equipada con todas las comodidades necesarias para que su estancia sea verdaderamente inolvidable.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/main-image/deluxe_-_signature_king_enhanced.jpg',106.60),
(13,'Bungalow King','2','1','Nuestros nuevos bungalows han sido diseñados para quienes buscan confort, lujo y total privacidad. Estas habitaciones completamente nuevas se ubican en una zona exclusiva del hotel y cuentan con acceso a su propia área de piscinas. Están equipados con una cama king size, ofreciendo el espacio perfecto para relajarse y disfrutar de una experiencia única.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/bungalow_king_2_enhanced.jpg',161.95),
(13,'Junior Suite Vista al Mar','2','1','Lujosas y amplias suites ubicadas en el edificio principal de habitaciones, entre el segundo y el quinto piso. Están equipadas con una cama king size y disponen de dos ambientes: una cómoda sala de estar y un balcón privado con una espectacular vista al mar, perfectos para una estancia inolvidable.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/junior_suite_2_enhanced.jpg',180.40),
(13,'Grand Suite King Vista al Mar','2','1','Ubicada en el exclusivo edificio de Grand Suites, esta amplia habitación ofrece dos ambientes bien definidos: una cómoda sala de estar con sofá cama y un dormitorio con una cama king size. Además, dispone de dos baños y está equipada con mobiliario y acabados de lujo. Es la opción ideal para familias que buscan confort y estilo en un entorno exclusivo.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/grand_suite_king_4_enhanced.jpg',229.60),
(13,'Deluxe 2 Camas Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',106.60),
(13,'Suite Presidencial vista al Mar','2','1','Situada en el quinto piso del edificio principal, nuestra exclusiva Suite Presidencial ofrece una vista panorámica inigualable al mar. Dispone de una elegante sala de estar y una cama King Size, combinando lujo, confort y privacidad.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/presidencial_3_enhanced.jpg',270.60),
(13,'Bungalow con Piscina','2','1','Nuestros nuevos bungalows han sido diseñados para quienes valoran el confort, el lujo y la privacidad absoluta. Ubicados en una zona exclusiva del hotel, estas habitaciones totalmente nuevas ofrecen acceso directo a su propia área de piscinas y están equipadas con una cama King Size. ','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/bungalow_pool_2_enhanced.jpg',317.75),
(13,'Suite Imperial Vista al Mar','2','1','Ubicada en el tercer piso del edificio Grand Suites, nuestra exclusiva Suite Imperial combina amplitud, lujo y confort en un solo espacio. Equipada con una cama King Size, una elegante sala de estar y un balcón privado con vista al mar.','https://reservations.oroverdehotels.com/assets/hotel/114494/media/room/detail-image/imperial_6_enhanced.jpg',393.60)
;

INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES  
(14,'Deluxe Queen','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama Queen y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/main-image/deluxe_queen_enhanced.jpg',113.98),
(14,'Deluxe Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',113.98),
(14,'Suite Ejecutiva','3','1','Desiñada para el viajero de negocios moderno. Nuestra Suite Ejecutiva ofrece comodidad y convenienca con una lujosa cama King Size, Wi-Fi, Sala de estar y Jacuzzi.','https://reservations.oroverdehotels.com/assets/hotel/114496/media/room/detail-image/travelclick_0497_enhanced.jpg',154.98);



INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES 
(15,'Deluxe Queen','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama Queen y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/main-image/deluxe_queen_enhanced.jpg',85),
(15,'Deluxe Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',69.70),
(15,'Deluxe Full','2','1',' No fumadores• Acceso a Internet• Satélite/TV por cable• Ducha• Secador de pelo• Ropa de cama y toallas','https://tbb-prod-emea.imgix.net/attachments/room_type_photos/images/713919/713919/IMG_4602.jpg?auto=format,compress&fit=crop&crop=entropy&w=1707&q=75',85),

(15,'Junior Suite','2','1',' No fumadores• Acceso a Internet• Satélite/TV por cable• Ducha• Secador de pelo• Ropa de cama y toallas. Cama King Size.','https://tbb-prod-emea.imgix.net/attachments/room_type_photos/images/713915/713915/IMG_4762.jpg?auto=format,compress&fit=crop&crop=entropy&w=1707&q=75',90);


INSERT INTO habitacion (id_hotel, nombre_habitacion, capacidad_habitacion, camas_habitacion, descripcion_habitacion,imagen_habitacion,precio_habitacion) VALUES  
(16,'Deluxe Queen','2','1','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Cama Queen y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/main-image/deluxe_queen_enhanced.jpg',113.97),
(16,'Deluxe Twin','4','2','Ofrecen un diseño fresco y contemporáneo, espacios generosos para trabajar o relajarse. Camas Twin y baños totalmente remodelados con ducha tipo lluvia.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/deluxe_twin_2_enhanced.jpg',113.97),
(16,'Deluxe Full','2','1',' No fumadores• Acceso a Internet• Satélite/TV por cable• Ducha• Secador de pelo• Ropa de cama y toallas','https://tbb-prod-emea.imgix.net/attachments/room_type_photos/images/713919/713919/IMG_4602.jpg?auto=format,compress&fit=crop&crop=entropy&w=1707&q=75',130),
(16,'Suite Presidencial','2','1','Experimente el verdadero lujo en nuestra Suite Presidencial con cama King Size, baño privado con hidromasaje, sala de estar y amenidades exclusivas.','https://reservations.oroverdehotels.com/assets/hotel/114490/media/room/detail-image/standard_king_2_enhanced.jpg',160),
(16,'Suite Oro Verde','2','1','','https://bookings.travelclick.com/assets/hotel/114928/media/room/main-image/ov_suite_tc_enhanced.jpg',145),
(16,'Habitacion Deluxe Triple','5','3','','https://bookings.travelclick.com/assets/hotel/114928/media/room/main-image/triple_tc_enhanced.jpg',215)
;


INSERT INTO codigo_descuento (nombre_prom, codigo_prom,descuento_porcentaje_prom,fecha_inicio_prom,fecha_fin_prom,descripcion_prom) VALUES
('Descuento Especial','DESCUENTO8',8,'2025-01-01','2025-12-31','Descuento aplicado por tres noches mínimo'),
('Descuento para Móviles','DESCUMOVIL',10,'2025-01-01','2025-12-31','Descuento por realizar la reserva desde móviles')
;