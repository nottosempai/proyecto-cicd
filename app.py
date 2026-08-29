from flask import Flask, jsonify

app = Flask(__name__)


def sumar(numero1, numero2):
    return numero1 + numero2


def restar(numero1, numero2):
    return numero1 - numero2


@app.get("/")
def inicio():
    return jsonify(
        mensaje="API CI/CD desplegada automáticamente en AWS",
        estado="ok",
    )


@app.get("/sumar/<int:numero1>/<int:numero2>")
def sumar_api(numero1, numero2):
    return jsonify(
        numero1=numero1,
        numero2=numero2,
        resultado=sumar(numero1, numero2),
    )


@app.get("/salud")
def salud():
    return jsonify(estado="saludable"), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)