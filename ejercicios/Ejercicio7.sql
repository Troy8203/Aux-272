DECLARE
    CURSOR cursor_prod IS SELECT idprod, nombre 
        FROM producto ORDER BY nombre;

    xidprod NUMBER;
    xname_prod VARCHAR(100);

    CURSOR cursor_ing IS SELECT nombre, cantidad
        FROM esta_compuesto, ingrediente
        WHERE esta_compuesto.iding=ingrediente.iding AND idprod=xidprod
        ORDER BY nombre;

    xname_ing VARCHAR(100);
    xcant NUMBER;

BEGIN
    OPEN cursor_prod;
        LOOP
            FETCH cursor_prod INTO xidprod, xname_prod;
            EXIT WHEN cursor_prod%NOTFOUND;
            dbms_output.put_line('Producto:' || xname_prod);
            
            OPEN cursor_ing;
                LOOP
                    FETCH cursor_ing INTO xname_ing, xcant;
                    EXIT WHEN cursor_ing%NOTFOUND;
                    IF xname_ing IN ('PAPA', 'PAN', 'TOMATE', 'AJO') THEN
                        dbms_output.put_line('            '||xname_ing||'          '||xcant||'(Unidades)');
                    ELSIF xname_ing IN ('ARROZ', 'FIDEO', 'SAL', 'AZUCAR') THEN
                        dbms_output.put_line('            '||xname_ing||'          '||xcant||'(Gr.)');
                    ELSIF xname_ing IN ('CARNE', 'POLLO') THEN
                        dbms_output.put_line('            '||xname_ing||'          '||xcant||'(Kg.)');
                    ELSE
                        dbms_output.put_line('            '||xname_ing||'          '||xcant||'--');
                    END IF;
                END LOOP;
            CLOSE cursor_ing;
            dbms_output.put_line('=================================================='); 
        END LOOP;
    CLOSE cursor_prod;
END;

---2)
DECLARE
    CURSOR cursor_sucursal IS SELECT idsuc, direccion, cigerente
        FROM sucursal ORDER BY direccion;
    
    xidsuc NUMBER;
    xdir VARCHAR(100);
    xcigerente NUMBER;

    CURSOR cursor_prod_serv IS SELECT nombre
        FROM se_sirve, producto
        WHERE se_sirve.idprod=producto.idprod AND idsuc=xidsuc
        ORDER BY nombre;

    xcout NUMBER;
    xnameprod varchar(100);

    CURSOR cursor_detalle_pedido IS SELECT DISTINCT pedido.nropedido, f2_nombre_pedido(pedido.nropedido) name, monto_x_pedido(pedido.nropedido) monto
        FROM detalle_pedido, pedido
        WHERE detalle_pedido.nropedido=pedido.nropedido AND idsuc=xidsuc
        ORDER BY name;

        xnropedido NUMBER;
        xnamepedido VARCHAR(100);
        xmonto NUMBER;
        xtotal NUMBER;
BEGIN
    OPEN cursor_sucursal;
        LOOP
            xtotal:=0;
            FETCH cursor_sucursal INTO xidsuc, xdir, xcigerente;
            EXIT WHEN cursor_sucursal%NOTFOUND;
            dbms_output.put_line('=================================================='); 
            dbms_output.put_line('Sucursal: ' ||xdir||'             Gerente: '||obtap_nom (xcigerente));
            OPEN cursor_prod_serv;
                xcout:=0;
                dbms_output.put_line('  Productos que se sirve');
                LOOP
                    FETCH cursor_prod_serv INTO xnameprod;
                    EXIT WHEN cursor_prod_serv%NOTFOUND;
                    xcout:=xcout+1;

                    dbms_output.put_line('                '||xcout||'    '||xnameprod);
                END LOOP;
            CLOSE cursor_prod_serv;


            OPEN cursor_detalle_pedido;
                dbms_output.put_line('  Pedidos que solicitaron de la sucursal');
                LOOP
                    FETCH cursor_detalle_pedido INTO xnropedido, xnamepedido, xmonto;
                    EXIT WHEN cursor_detalle_pedido%NOTFOUND;
                    xtotal:=xtotal+xmonto;
                    dbms_output.put_line('                '||xnropedido||'    '||xnamepedido||'    '||xmonto);
                END LOOP;
            CLOSE cursor_detalle_pedido;
            dbms_output.put_line('Total venta: '||xtotal);

        END LOOP;
    CLOSE cursor_sucursal;
END;