
CREATE SEQUENCE seq_id_region;
CREATE SEQUENCE seq_id_ciudad START WITH 0 MINVALUE 0;

INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Tarapacá');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Antofagasta');    
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Atacama');        
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Coquimbo');       
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Valparaíso');     
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de O`Higgins');   
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región del Maule');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región del Biobío');        
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de la Araucanía');   
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de los Lagos');      
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Aysén');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Magallanes');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región Metropolitana');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de los Ríos');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Arica');
INSERT INTO region VALUES (nextval('seq_id_region'), 'Región de Ñuble');

INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Iquique', 1);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Alto Hospicio', 1);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pozo Almonte', 1);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Antofagasta', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Mejillones', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Taltal', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Calama', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Pedro de Atacama', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Tocopilla', 2);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Copiapó', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Caldera', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Tierra Amarilla', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chañaral', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Salvador', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Diego de Almagro', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Vallenar', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Huasco', 3);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Serena', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Tongoy', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coquimbo', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Andacollo', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Vicuña', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Illapel', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Vilos', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Salamanca', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Ovalle', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Combarbalá', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Monte Patria', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Palqui', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Punitaqui', 4);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Valparaíso', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Placilla de Peñuelas', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Casablanca', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Concón', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puchuncaví', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Las Ventanas', 5);        
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quintero', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Viña del Mar', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hanga Roa', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Andes', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Calle Larga', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Rinconada', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Esteban', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Ligua', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cabildo', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quillota', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Calera', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hijuelas', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Cruz', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Melón', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Nogales', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Antonio', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Mirasol - El Yeco', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Algarrobo', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cartagena', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Quisco', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Las Cruces', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Tabo', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santo Domingo', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Felipe', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Catemu', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Llaillay', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Putaendo', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santa María', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Villa los Almendros', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quilpué', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Limache', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Olmué', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Villa Alemana', 5);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Rancagua', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Codegua', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Doñihue', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coltauco', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lo Miranda', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Doñihue', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Graneros', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Las Cabras', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Machalí', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Francisco de Mostazal', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Punta', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Gultro', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Punta de Diamante', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Peumo', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pichidegua', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quinta de Tilcoco', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Rengo', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Lirios', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Requínoa', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Vicente de Tagua Tagua', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pichilemu', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Fernando', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chépica', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chimbarongo', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Nancagua', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Peralillo', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santa Cruz', 6);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Talca', 7);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Constitución', 7);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Maule', 7);       
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Culenar', 7);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Clemente', 7);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cauquenes', 7);   
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Curicó', 7);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hualañé', 7);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Molina', 7);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Rauco', 7);       
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Romeral', 7);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Teno', 7);        
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Linares', 7);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Colbún', 7);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Longaví', 7);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Parral', 7);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Retiro', 7);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Javier', 7);  
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Villa Alegre', 7);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Concepción', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coronel', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chiguayante', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hualqui', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lota', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Penco', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Pedro de la Paz', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santa Juana', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Talcahuano', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Tomé', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hualpén', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lebu', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Laraquete', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Arauco', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cañete', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Curanilahue', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Álamos', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Ángeles', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cabrero', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Monte águila', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Laja', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Mulchén', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Nacimiento', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Rosendo', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santa Bárbara', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Huépil', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Yumbel', 8);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Labranza', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Temuco', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Carahue', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cunco', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Freire', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Gorbea', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lautaro', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Loncoche', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Nueva Imperial', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Padre las Casas', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pitrufquén', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pucón', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Vilcún', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cajón', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Villarrica', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Angol', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Collipulli', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Curacautín', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Purén', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Renaico', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Traiguén', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Victoria', 9);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Alerce', 10);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puerto Montt', 10);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Calbuco', 10);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Fresia', 10);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Frutillar', 10);   
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Muermos', 10); 
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Llanquihue', 10);  
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puerto Varas', 10);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Castro', 10);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Ancud', 10);       
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chonchi', 10);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Dalcahue', 10);    
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quellón', 10);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Osorno', 10);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Purranque', 10);   
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Río Negro', 10);   
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chaitén', 10); 
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coyhaique', 11);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puerto Aysén', 11);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cochrane', 11);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chile Chico', 11);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Punta Arenas', 12);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puerto Williams', 12);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Porvenir', 12);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puerto Natales', 12);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Santiago', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cerrillos', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Cerro Navia', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Conchalí', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Bosque', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Estación Ccentral', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Huechuraba', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Independencia', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Cisterna', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Florida', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Granja', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Pintana', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Reina', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Las Condes', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lo Barnechea', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lo Espejo', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lo Prado', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Macul', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Maipú', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Ñuñoa', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pedro Aguirre Cerda', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Peñalolén', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Providencia', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pudahuel', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Ciudad del Valle', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Qulicura', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quinta Normal', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Recoleta', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Renca', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Joaquín', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Miguel', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Ramón', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Vitacura', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Puente Alto', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Pirque', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Principal', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San José de Maipo', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La obra - Las Vertientes', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Colina', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chicureo', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chamisero', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Batuco', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lampa', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Valle grande', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chicauma', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Tiltil', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Bernardo', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Alto Jahuel', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Buin', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Bajos de San Agustín', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Paine', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Hospital', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Bollenar', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Melipilla', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Curacaví', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Talagante', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'El Monte', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Isla de Maipo', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Islita', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Padre Hurtado', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Peñaflor', 13);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Valdivia', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Lanco', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Los Lagos', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San José de la Mariquina', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Paillaco', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Panguipulli', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'La Unión', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Futrono', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Río Bueno', 14);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Arica', 15);
INSERT INTO ciudad VALUES (270, 'Parinacota', 15);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Putre', 15);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chillán', 16);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Bulnes', 16);       
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Chillán Viejo', 16);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quillón', 16);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Yungay', 16);       
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Quirihue', 16);     
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coelemu', 16);      
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'San Carlos', 16);
INSERT INTO ciudad VALUES (nextval('seq_id_ciudad'), 'Coihueco', 16);

COMMIT;