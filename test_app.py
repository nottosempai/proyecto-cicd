from app import app, sumar, restar


def test_sumar():
    assert sumar(2, 3) == 5


def test_sumar_negativos():
    assert sumar(-2, -3) == -5


def test_restar():
    assert restar(5, 3) == 2


def test_restar_resultado_negativo():
    assert restar(3, 5) == -2


def test_inicio():
    cliente = app.test_client()

    respuesta = cliente.get("/")

    assert respuesta.status_code == 200
    assert respuesta.get_json()["mensaje"] == "API CI/CD desplegada automáticamente en AWS"
    assert respuesta.get_json()["estado"] == "ok"


def test_sumar_api():
    cliente = app.test_client()

    respuesta = cliente.get("/sumar/2/3")

    assert respuesta.status_code == 200
    assert respuesta.get_json()["numero1"] == 2
    assert respuesta.get_json()["numero2"] == 3
    assert respuesta.get_json()["resultado"] == 5


def test_salud():
    cliente = app.test_client()

    respuesta = cliente.get("/salud")

    assert respuesta.status_code == 200
    assert respuesta.get_json()["estado"] == "saludable"