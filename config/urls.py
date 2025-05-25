from django.urls import path
from Oro_Verde.views import *

urlpatterns = [
    path('api/ciudades/', CiudadListCreateView.as_view()),
    path('api/ciudades/<int:id_ciudad>/', CiudadDetailView.as_view()),

    path('api/hoteles/', HotelListCreateView.as_view()),
    path('api/hoteles/<int:id_hotel>/', HotelDetailView.as_view()),

    path('api/habitaciones/', HabitacionListCreateView.as_view()),
    path('api/habitaciones/<int:id_habitacion>/', HabitacionDetailView.as_view()),

    path('api/clientes/', ClienteListCreateView.as_view()),
    path('api/clientes/<int:cedula_cliente>/', ClienteDetailView.as_view()),

    path('api/paises/', PaisListCreateView.as_view()),
    path('api/paises/<int:id_pais>/', PaisDetailView.as_view()),

    path('api/descuentos/', CodigoDescuentoListCreateView.as_view()),
    path('api/descuentos/<int:id_prom>/', CodigoDescuentoDetailView.as_view()),

    path('api/reservas/', ReservaListCreateView.as_view()),
    path('api/reservas/<int:id_reserva>/', ReservaDetailView.as_view()),

    path('api/pagos/', PagoListCreateView.as_view()),
    path('api/pagos/<int:id_pago>/', PagoDetailView.as_view()),
]
