import requests
import datetime

BASE_URL = 'http://localhost:8000/api'

def obtener_ciudades():
    response = requests.get(f'{BASE_URL}/ciudades/')
    if response.status_code == 200:
        ciudades = response.json()
        print("Ciudades disponibles:")
        for ciudad in ciudades:
            print(f"{ciudad['id_ciudad']}: {ciudad['nombre_ciudad']}")
        return ciudades
    else:
        print("Error al obtener ciudades.")
        return []

def obtener_hoteles_por_ciudad(id_ciudad):
    response = requests.get(f'{BASE_URL}/hoteles/', params={'id_ciudad': id_ciudad})
    if response.status_code == 200:
        hoteles = response.json()
        print(f"Hoteles en ciudad {id_ciudad}:")
        for hotel in hoteles:
            print(f"{hotel['id_hotel']}: {hotel['nombre_hotel']}")
        return hoteles
    else:
        print("Error al obtener hoteles.")
        return []

def obtener_habitaciones_por_hotel(id_hotel):
    response = requests.get(f'{BASE_URL}/habitaciones/', params={'id_hotel': id_hotel})
    if response.status_code == 200:
        habitaciones = response.json()
        print(f"Habitaciones en hotel {id_hotel}:")
        for habitacion in habitaciones:
            print(f"{habitacion['id_habitacion']}: {habitacion['nombre_habitacion']} - ${habitacion['precio_habitacion']}")
        return habitaciones
    else:
        print("Error al obtener habitaciones.")
        return []

def obtener_paises():
    response = requests.get(f'{BASE_URL}/paises/')
    if response.status_code == 200:
        paises = response.json()
        print("Paises disponibles:")
        for pais in paises:
            print(f"{pais['id_pais']}: {pais['nombre_pais']}")
        return paises
    else:
        print("Error al obtener países.")
        return []

def calcular_total(precio_por_noche, fecha_entrada, fecha_salida):
    dias = (fecha_salida - fecha_entrada).days
    return dias * float(precio_por_noche)

def obtener_paises():
    response = requests.get(f'{BASE_URL}/paises/')
    if response.status_code == 200:
        paises = response.json()
        print("Países disponibles:")
        for pais in paises:
            print(f"{pais['id_pais']}: {pais['nombre_pais']}")
        return paises
    else:
        print("Error al obtener países.")
        return []

def registrar_cliente():
    cedula = input("Ingrese la cédula del cliente: ")

    # Verificar si ya existe
    response = requests.get(f'{BASE_URL}/clientes/{cedula}/')
    if response.status_code == 200:
        print("Cliente ya registrado.")
        return cedula  # Ya existe, usarlo
    elif response.status_code != 404:
        print("Error al verificar la cédula del cliente:", response.text)
        return None

    print("Cliente no registrado. Ingrese los datos para registrarlo.")
    cliente_data = {
        "cedula_cliente": cedula,
        "nombre_cliente": input("Nombre: "),
        "apellido_cliente": input("Apellido: "),
        "telefono_cliente": input("Teléfono: "),
        "correo_cliente": input("Correo: "),
        "direccion_cliente": input("Dirección: "),
        "direccion_secundaria_cliente": input("Dirección secundaria (opcional): ") or None,
        "ciudad_cliente": input("Ciudad: "),
        "codigo_postal_cliente": int(input("Código postal: ")),
        "provincia_cliente": input("Provincia: "),
    }

    paises = obtener_paises()
    if paises:
        id_pais = None
        valid_ids = [pais['id_pais'] for pais in paises]
        while id_pais not in valid_ids:
            try:
                id_pais = int(input("Seleccione ID del país de la lista mostrada: "))
                if id_pais not in valid_ids:
                    print("ID inválido. Intente de nuevo.")
            except ValueError:
                print("Debe ingresar un número entero válido.")
        cliente_data["id_pais"] = id_pais
    else:
        print("No se pudo cargar la lista de países, ingrese ID de país manualmente.")
        cliente_data["id_pais"] = int(input("ID del país: "))

    response = requests.post(f'{BASE_URL}/clientes/', json=cliente_data)
    if response.status_code == 201:
        print("Cliente registrado exitosamente.")
        return cedula
    else:
        print("Error al registrar cliente:", response.text)
        return None



def registrar_reserva_y_pago(id_habitacion, cedula_cliente, precio_habitacion):
    fecha_entrada = datetime.datetime.strptime(input("Fecha de entrada (YYYY-MM-DD): "), "%Y-%m-%d").date()
    fecha_salida = datetime.datetime.strptime(input("Fecha de salida (YYYY-MM-DD): "), "%Y-%m-%d").date()
    total = calcular_total(precio_habitacion, fecha_entrada, fecha_salida)

    reserva_data = {
        "cedula_cliente": cedula_cliente,
        "id_habitacion": id_habitacion,
        "fecha_reserva": str(datetime.date.today()),
        "fecha_entrada": str(fecha_entrada),
        "fecha_salida": str(fecha_salida),
        "id_prom": None
    }

    response = requests.post(f'{BASE_URL}/reservas/', json=reserva_data)
    if response.status_code == 201:
        reserva_id = response.json()['id_reserva']
        print("Reserva registrada exitosamente.")

        pago_data = {
            "id_reserva": reserva_id,
            "fecha_pago": str(datetime.date.today()),
            "valor_pago": total,
            "estado_pago": "exitoso",
            "titular_tarjeta": input("Titular tarjeta: "),
            "numero_tarjeta": input("Número tarjeta: "),
            "fechacaducidad_tarjeta": input("Fecha caducidad (YYYY-MM-DD): "),
            "cvv_tarjeta": input("CVV: ")
        }

        response_pago = requests.post(f'{BASE_URL}/pagos/', json=pago_data)
        if response_pago.status_code == 201:
            print("Pago registrado exitosamente.")
        else:
            print("Error al registrar el pago", response_pago.text)
    else:
        print("Error al registrar la reserva", response.text)

# Flujo principal de selección y registro
ciudades = obtener_ciudades()
id_ciudad = int(input("Seleccione ID de ciudad: "))
hoteles = obtener_hoteles_por_ciudad(id_ciudad)
id_hotel = int(input("Seleccione ID de hotel: "))
habitaciones = obtener_habitaciones_por_hotel(id_hotel)
id_habitacion = int(input("Seleccione ID de habitación: "))
precio_habitacion = float(next(h for h in habitaciones if h['id_habitacion'] == id_habitacion)['precio_habitacion'])
cedula_cliente = registrar_cliente()
if cedula_cliente:
    registrar_reserva_y_pago(id_habitacion, cedula_cliente, precio_habitacion)
