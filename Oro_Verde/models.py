from django.db import models


class Ciudad(models.Model):
    id_ciudad = models.AutoField(primary_key=True)
    nombre_ciudad = models.CharField(max_length=30)

    class Meta:
      
        db_table = 'ciudad'


class Cliente(models.Model):
    cedula_cliente = models.CharField(primary_key=True, max_length=15)
    id_pais = models.ForeignKey('Pais', models.DO_NOTHING, db_column='id_pais', blank=True, null=True)
    nombre_cliente = models.CharField(max_length=25)
    apellido_cliente = models.CharField(max_length=25)
    telefono_cliente = models.CharField(max_length=15)
    correo_cliente = models.CharField(max_length=50)
    direccion_cliente = models.CharField(max_length=40)
    direccion_secundaria_cliente = models.CharField(max_length=40, blank=True, null=True)
    ciudad_cliente = models.CharField(max_length=30)
    codigo_postal_cliente = models.IntegerField()
    provincia_cliente = models.CharField(max_length=50)

    class Meta:
       
        db_table = 'cliente'

    def __str__(self):
        return f"{self.nombre_cliente} {self.apellido_cliente} - {self.cedula_cliente}"


class CodigoDescuento(models.Model):
    id_prom = models.AutoField(primary_key=True)
    nombre_prom = models.CharField(max_length=50)
    codigo_prom = models.CharField(max_length=10)
    descuento_porcentaje_prom = models.DecimalField(max_digits=5, decimal_places=2)
    fecha_inicio_prom = models.DateField()
    fecha_fin_prom = models.DateField()
    descripcion_prom = models.CharField(max_length=300)

    class Meta:
        
        db_table = 'codigo_descuento'

    def __str__(self):
        return self.nombre_prom


class Habitacion(models.Model):
    id_habitacion = models.AutoField(primary_key=True)
    id_hotel = models.ForeignKey('Hotel', models.DO_NOTHING, db_column='id_hotel')
    nombre_habitacion = models.CharField(max_length=35)
    capacidad_habitacion = models.CharField(max_length=3)
    camas_habitacion = models.CharField(max_length=2)
    descripcion_habitacion = models.CharField(max_length=400)
    imagen_habitacion = models.CharField(max_length=300)
    precio_habitacion = models.DecimalField(max_digits=6, decimal_places=2)

    class Meta:
        
        db_table = 'habitacion'

    def __str__(self):
        return f"{self.nombre_habitacion}"


class Hotel(models.Model):
    id_hotel = models.AutoField(primary_key=True)
    id_ciudad = models.ForeignKey(Ciudad, models.DO_NOTHING, db_column='id_ciudad')
    nombre_hotel = models.CharField(max_length=35)
    telefono_hotel = models.CharField(max_length=10)
    correo_hotel = models.CharField(max_length=40)

    class Meta:
        
        db_table = 'hotel'


class Pago(models.Model):
    id_pago = models.AutoField(primary_key=True)
    id_reserva = models.ForeignKey('Reserva', models.DO_NOTHING, db_column='id_reserva')
    fecha_pago = models.DateField()
    valor_pago = models.DecimalField(max_digits=6, decimal_places=2)
    estado_pago = models.CharField(max_length=15)
    titular_tarjeta = models.CharField(max_length=30)
    numero_tarjeta = models.CharField(max_length=16)
    fechacaducidad_tarjeta = models.DateField()
    cvv_tarjeta = models.CharField(max_length=4)

    class Meta:
        
        db_table = 'pago'


class Pais(models.Model):
    id_pais = models.AutoField(primary_key=True)
    nombre_pais = models.CharField(max_length=50)

    class Meta:
        
        db_table = 'pais'

    def __str__(self):
        return f"{self.nombre_pais}"


class Reserva(models.Model):
    id_reserva = models.AutoField(primary_key=True)
    cedula_cliente = models.ForeignKey(Cliente, models.CASCADE, db_column='cedula_cliente')
    id_habitacion = models.ForeignKey(Habitacion, models.DO_NOTHING, db_column='id_habitacion')
    id_prom = models.ForeignKey(CodigoDescuento, models.DO_NOTHING, db_column='id_prom', blank=True, null=True)
    fecha_reserva = models.DateField()
    fecha_entrada = models.DateField()
    fecha_salida = models.DateField()

    class Meta:
        
        db_table = 'reserva'

    def __str__(self):
        return f"{self.cedula_cliente}"
