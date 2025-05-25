from rest_framework import serializers
from .models import Ciudad, Cliente, CodigoDescuento, Habitacion, Hotel, Pago, Pais, Reserva


class CiudadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ciudad
        fields = '__all__'


class PaisSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pais
        fields = '__all__'


class ClienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cliente
        fields = '__all__'


class CodigoDescuentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = CodigoDescuento
        fields = '__all__'


class HotelSerializer(serializers.ModelSerializer):
    # Para mostrar nombre de la ciudad si quieres
    id_ciudad = CiudadSerializer(read_only=True)

    class Meta:
        model = Hotel
        fields = '__all__'


class HabitacionSerializer(serializers.ModelSerializer):
    id_hotel = HotelSerializer(read_only=True)

    class Meta:
        model = Habitacion
        fields = '__all__'


class ReservaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reserva
        fields = '__all__'


class PagoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pago
        fields = '__all__'
