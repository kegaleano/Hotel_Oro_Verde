from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from .models import Ciudad, Cliente, CodigoDescuento, Habitacion, Hotel, Pago, Pais, Reserva
from .serializers import (
    CiudadSerializer,
    ClienteSerializer,
    CodigoDescuentoSerializer,
    HabitacionSerializer,
    HotelSerializer,
    PagoSerializer,
    PaisSerializer,
    ReservaSerializer
)

# -------- CIUDAD --------
class CiudadListCreateView(generics.ListCreateAPIView): #Lista todas las ciudades con get y crea una ciudad nueva con post.
    queryset = Ciudad.objects.all()
    serializer_class = CiudadSerializer

class CiudadDetailView(generics.RetrieveUpdateDestroyAPIView): #permite obtener - get, actualizar -put/patch o eliminar una ciudad especifica
    queryset = Ciudad.objects.all()
    serializer_class = CiudadSerializer
    lookup_field = 'id_ciudad'

#Aspecto	        CiudadDetailView	                           filter_backends (DjangoFilterBackend)
#Función	        Acceso a un único objeto por ID	               Filtrar colecciones en listados
#URL típica         /api/ciudades/3/	                           /api/ciudades/?nombre_ciudad=Quito
#Uso principal	    Obtener, actualizar, eliminar un registro	   Filtrar listados para buscar registros específicos o con ciertas condiciones

# -------- HOTEL --------
class HotelListCreateView(generics.ListCreateAPIView):
    queryset = Hotel.objects.all()
    serializer_class = HotelSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['id_ciudad']

class HotelDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Hotel.objects.all()
    serializer_class = HotelSerializer
    lookup_field = 'id_hotel'


# -------- HABITACION --------
class HabitacionListCreateView(generics.ListCreateAPIView):
    queryset = Habitacion.objects.all()
    serializer_class = HabitacionSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['id_hotel']

class HabitacionDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Habitacion.objects.all()
    serializer_class = HabitacionSerializer
    lookup_field = 'id_habitacion'


# -------- CLIENTE --------
class ClienteListCreateView(generics.ListCreateAPIView):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer

class ClienteDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer
    lookup_field = 'cedula_cliente'


# -------- PAIS --------
class PaisListCreateView(generics.ListCreateAPIView):
    queryset = Pais.objects.all()
    serializer_class = PaisSerializer

class PaisDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Pais.objects.all()
    serializer_class = PaisSerializer
    lookup_field = 'id_pais'


# -------- CODIGO DESCUENTO --------
class CodigoDescuentoListCreateView(generics.ListCreateAPIView):
    queryset = CodigoDescuento.objects.all()
    serializer_class = CodigoDescuentoSerializer

class CodigoDescuentoDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = CodigoDescuento.objects.all()
    serializer_class = CodigoDescuentoSerializer
    lookup_field = 'id_prom'


# -------- RESERVA --------
class ReservaListCreateView(generics.ListCreateAPIView):
    queryset = Reserva.objects.all()
    serializer_class = ReservaSerializer

class ReservaDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Reserva.objects.all()
    serializer_class = ReservaSerializer
    lookup_field = 'id_reserva'


# -------- PAGO --------
class PagoListCreateView(generics.ListCreateAPIView):
    queryset = Pago.objects.all()
    serializer_class = PagoSerializer

class PagoDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Pago.objects.all()
    serializer_class = PagoSerializer
    lookup_field = 'id_pago'


