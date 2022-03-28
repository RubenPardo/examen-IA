(deffacts BH

    (maxCajas 2)
    (problema pedidos pedido naranjas 3 pedido manzanas 3 pedido uvas 1 lineaPedido robot cajasActuales 0 pales pale naranjas 3 pale manzanas 3 pale caquis 5 pale uvas 1)
)


(defrule comprobarStock

    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido  lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)
    (test (> ?cuantosPedido ?stockPale))
    =>
    (printout t "No hay suficiente stock de " ?tipoPale crlf)
    (halt)

)

(defrule comprobarPedido

    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido  $?resto)
    (test (= ?cuantosPedido 0))
    =>
    (problema pedidos $?iniPedido ?cuantosPedido $?finPedido  $?resto)

)

(defrule comprobarFinal
    (declare (salience 100))
    (problema pedidos $?pedido $?resto)
    (test (= (length$ $?pedido) 0))
    =>
    (printout t "FIN===========" crlf)

)



(defrule cogerCaja
    (maxCajas ?numCajas)
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)

    (test (< ?cajasActuales ?numCajas)) ; no puede llevar mas del tope
    (test (> ?cuantosPedido 0)) ; que el pedido aun le queden
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales (+ ?cajasActuales 1) caja ?tipoPale pales $?ini pale ?tipoPale (- ?stockPale 1) $?fin))
    (printout t "Pillo caja de " ?tipoPale crlf)
)

(defrule dejarCaja
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales caja $?cajas pales $?pales)

    (test (> ?cajasActuales 0)) ; no puede llevar mas del tope
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale (- ?cuantosPedido 1) $?finPedido  lineaPedido $?lineaPedido $?cajas robot cajasActuales (- ?cajasActuales (length$ $?cajas)) caja pales $?pales))
    (printout t "Dejo cajas de " $?cajas crlf)
)