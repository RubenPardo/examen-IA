(deffacts BH

    (maxCajas 2)
    (problema pedidos pedido naranjas 3 pedido manzanas 3 pedido uvas 1 lineaPedido robot cajasActuales 0 cajas pales pale naranjas 3 pale manzanas 3 pale caquis 5 pale uvas 1)
)


(defrule comprobarStock
    (declare (salience 40))
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido  lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales cajas $?cajas pales $?ini pale ?tipoPale ?stockPale $?fin)
    (test (> ?cuantosPedido ?stockPale))
    =>
    (printout t "No hay stock suficiente" crlf)
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
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales cajas $?cajas pales $?ini pale ?tipoPale ?stockPale $?fin)
    (test (< ?cajasActuales ?numCajas )) ; no puede llevar mas del tope
    (test (> ?stockPale 0))
    (test (> ?cuantosPedido 0)) ; que el pedido aun le queden
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales (+ ?cajasActuales 1) cajas $?cajas ?tipoPale pales $?ini pale ?tipoPale (- ?stockPale 1) $?fin))
)

(defrule dejarCaja
    (declare (salience 60))
    (problema pedidos $?iniPedido pedido ?tipoPale ?cuantosPedido $?finPedido lineaPedido $?lineaPedido robot cajasActuales ?cajasActuales cajas ?caja $?cajas pales $?pales)
    (test (eq ?tipoPale ?caja))
    (test (> ?cajasActuales 0))
    =>
    (assert (problema pedidos $?iniPedido pedido ?tipoPale (- ?cuantosPedido 1) $?finPedido lineaPedido $?lineaPedido ?caja robot cajasActuales (- ?cajasActuales 1) cajas $?cajas pales $?pales))

)