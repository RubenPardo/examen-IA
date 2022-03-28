(deffacts BH

    (pedidos oedido naranjas 3 pedido manzanas 3 pedido uvas 1)
    (maxCajas 2)
    (probelma lineaPedido robot cajasActuales 0 pales pale naranjas 3 pale manzanas 3 pale caquis 5 pale uvas 1)
)


(defrule comprobarStock
    (pedidos $?iniPedido pedido ?tipoPedido ?cuantosPedido $?finPedido )
    (probelma lineaPedido $lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)

    (test (eq ?tipoPedido ?tipoPale)) ; que el tipo exista
    ()
)

(defrule cogerCaja
    (maxCajas ?numCajas)
    (pedidos $?iniPedido pedido ?tipoPedido ?cuantosPedido $?finPedido )
    (probelma lineaPedido $lineaPedido robot cajasActuales ?cajasActuales pales $?ini pale ?tipoPale ?stockPale $?fin)

    (test)
    (test (eq ?tipoPedido ?tipoPale)) ; que el tipo exista
    ()
)