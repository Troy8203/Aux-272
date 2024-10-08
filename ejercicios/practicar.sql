1)
SELECT DISTINCT razon_social, direccion
FROM proveedor, provee, ingrediente
WHERE (precio>=50 AND precio<=150) AND provee.iding=ingrediente.iding AND provee.idprov=proveedor.idprov
ORDER BY razon_social, direccion
2)
SELECT DISTINCT sucursal.direccion, sucursal.telefono
FROM sucursal, empleado, persona
WHERE sucursal.idsuc=empleado.idsuc AND empleado.ciempleado=persona.ci AND ((2023 - EXTRACT(YEAR FROM persona.fechanaci))<=30)
ORDER BY sucursal.direccion, sucursal.telefono
3)
SELECT direccion, apematerno, apepaterno, nombre
FROM sucursal, persona
WHERE sexo LIKE 'Femenino' AND cigerente=ci
ORDER BY direccion
4)
SELECT DISTINCT apepaterno, apematerno, persona.nombre
FROM persona, pedido, detalle_pedido, producto
WHERE producto.nombre LIKE '%HAMBURGUESA%' AND detalle_pedido.idprod=producto.idprod AND pedido.nropedido=detalle_pedido.nropedido AND persona.ci=cicliente
ORDER BY apepaterno, apematerno, persona.nombre
5)
SELECT apepaterno, apematerno, nombre, salario
FROM empleado, persona
WHERE ciempleado=ci AND salario=(SELECT MAX(salario) FROM empleado, persona WHERE ciempleado=ci)
6)
SELECT DISTINCT apepaterno, apematerno, persona.nombre
FROM persona , pedido, detalle_pedido, producto
WHERE costo=(SELECT MIN(costo) FROM producto) AND ci=cicliente AND pedido.nropedido=detalle_pedido.nropedido AND detalle_pedido.idprod=producto.idprod
ORDER BY apepaterno, apematerno, persona.nombre
7)
SELECT direccion, cant as nroempleados_fem
FROM sucursal, (SELECT sucursal.idsuc, COUNT(*) as cant
FROM sucursal, empleado, persona
WHERE sexo LIKE 'Femenino' AND sucursal.idsuc=empleado.idsuc AND empleado.ciempleado=ci
GROUP BY sucursal.idsuc
HAVING COUNT(*)>2) TMP
WHERE sucursal.idsuc=TMP.idsuc
ORDER BY direccion
8)
SELECT apepaterno, apematerno, nombre
FROM (SELECT * FROM persona WHERE nacionalidad LIKE 'Boliviana') TMP
WHERE ci NOT IN (SELECT cicliente  FROM pedido) AND ci NOT IN (SELECT ciempleado FROM empleado) AND ci IN (SELECT cicliente FROM cliente)
ORDER BY apepaterno, apematerno, nombre
9)
SELECT DISTINCT persona.apepaterno, persona.apematerno, persona.nombre
FROM (SELECT *
FROM producto
WHERE idprod NOT IN (SELECT producto.idprod
FROM producto, detalle_pedido, pedido, cliente, persona
WHERE producto.idprod=detalle_pedido.idprod AND detalle_pedido.nropedido= pedido.nropedido AND pedido.cicliente=cliente.cicliente AND cliente.cicliente=ci AND nacionalidad LIKE 'Argentina')) tmp, detalle_pedido, pedido, persona
WHERE tmp.idprod=detalle_pedido.idprod AND detalle_pedido.nropedido=pedido.nropedido AND cicliente=ci
ORDER BY persona.apepaterno, persona.apematerno, persona.nombre