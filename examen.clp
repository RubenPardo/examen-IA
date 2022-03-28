(deffacts BH

    (maxCajas 2)
    (problema pedidos pedido naranjas 3 pedido manzanas 3 pedido uvas 1 lineaPedido robot cajasActuales 0 pales pale naranjas 3 pale manzanas 3 pale caquis 5 pale uvas 1)
)


(defrule comprobarStock
    (declare (salience 70))
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido  lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)
    (test (> ?cuantosPedido ?stockPale))
    =>
    (halt)

)

(defrule comprobarPedido
    (declare (salience 60))
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido  $?resto)
    (test (= ?cuantosPedido 0))
    =>
    (assert(problema pedidos $?iniPedido $?finPedido  $?resto))

)

(defrule comprobarFinal
    (declare (salience 100))
    (problema pedidos $?pedido lineaPedido $?resto)
    (test (= (length$ $?pedido) 0))
    =>
    (printout t "FIN===========" crlf)
    (halt)

)



(defrule cogerCaja
    (declare (salience 50))
    (maxCajas ?numCajas)
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales $?cajas pales $?ini pale ?tipoPale ?stockPale $?fin)
    (test (< ?cajasActuales ?numCajas )) ; no puede llevar mas del tope
    (test (> ?cuantosPedido 0)) ; que el pedido aun le queden
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales (+ ?cajasActuales 1) caja ?tipoPale $?cajas pales $?ini pale ?tipoPale (- ?stockPale 1) $?fin))
)

(defrule dejarCaja
    (declare (salience 40))
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales $?iniCaja caja $?cajas $?finCaja pales $?pales)

    (test (> ?cajasActuales 0))
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale (- ?cuantosPedido 1) $?finPedido  lineaPedido $?lineaPedido $?cajas robot cajasActuales (- ?cajasActuales 1) $?iniCaja $?finCaja pales $?pales))

)