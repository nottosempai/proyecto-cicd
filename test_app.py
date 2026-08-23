from app import sumar, restar


def test_sumar():
    assert sumar(2, 3) == 5


def test_sumar_negativos():
    assert sumar(-2, -3) == -5


def test_restar():
    assert restar(5, 3) == 2


def test_restar_resultado_negativo():
    assert restar(3, 5) == -2