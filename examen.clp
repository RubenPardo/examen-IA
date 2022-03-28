(deffacts BH

    (pedidos pedido naranjas 3 pedido manzanas 3 pedido uvas 1)
    (maxCajas 2)
    (problema lineaPedido robot cajasActuales 0 pales pale naranjas 3 pale manzanas 3 pale caquis 5 pale uvas 1)
)


(defrule comprobarStock

    (pedidos $?iniPedido pedido ?tipoPedido ?cuantosPedido $?finPedido )
    (problema lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)

)

(defrule cogerCaja
    (maxCajas ?numCajas)
    (pedidos $?iniPedido pedido ?tipoPedido ?cuantosPedido $?finPedido )
    (problema lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)

    (test (< ?cajasActuales ?numCajas)) ; no puede llevar mas del tope
    (test (eq ?tipoPedido ?tipoPale)) ; que el tipo exista
    =>
    (assert (problema lineaPedido $?lineaPedido robot cajasActuales (+ ?cajasActuales 1) caja ?tipoPale pales $?ini pale ?tipoPale (- ?stockPale 1) $?fin))
    (printout t "Pillo caja de " ?tipoPale crlf)
)

(defrule dejarCaja
    (problema lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales caja $?cajas pales $?pales)

    (test (> ?cajasActuales 0)) ; no puede llevar mas del tope
    =>
    (assert (problema lineaPedido $?lineaPedido $?cajas robot cajasActuales (- ?cajasActuales (length$ $?cajas)) pales $?pales))
    (printout t "Dejo cajas de " $?cajas crlf)
)