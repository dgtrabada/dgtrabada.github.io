****************************
Cambio de base con decimales
****************************

Conversión de base N a decimal
------------------------------

**Ejemplo con decimales**

.. math::

   1010.101_{2)} &= 1 \times 2^3 + 0 \times 2^2 + 1 \times 2^1 + 0 \times 2^0+1 \times 2^{-1}+0 \times 2^{-2}+1 \times 2^{-3} = 10.625_{10)}

    A.A_{16)} &= (A=10)×16^0 + (A=10)×16^{-1} = 10.625_{10)}

    12.5_{8)} &= 1 \times 8^1 + 2 \times 8^0 + 5 \times 8^{-1} = 10.625_{10)}

    22.22_{4)} &= 2 \times 4^1 + 2 \times 4^0 + 2  \times 4^{-1}+2 \times 4^{-2} = 10.625_{10)}

Base decimal a base N
---------------------

1. **Parte entera**; dividiendo hasta coeficiente más pequeño que n
2. **Parte fraccionaria**; multiplicando por n

* **Ejemplo** de base **decimal** a base **binaria** con decimales :math: `10.625_{10) \rightarrow 2)}`

  Parte entera
  
  .. math::
  
     \left\uparrow
     \begin{matrix} 
     10 : 2 &= 5\  resto\  \mathbf{0}  \\ 
     5 : 2 &= 2\ resto\ \mathbf{1} \\ 
     2 : 2 &= 1\ resto\ \mathbf{0} \\
     1 : 2 &= 0\ resto\ \mathbf{1} 
     \end{matrix}
     \right\uparrow

  Parte decimal
 
  .. math::
  
     \left\downarrow
     \begin{matrix} 
     0.625 \times 2 = \mathbf{1}.25  \\
     0.250 \times 2 = \mathbf{0}.50  \\
     0.500 \times 2 = \mathbf{1}.00  
     \end{matrix}\right\downarrow 
     
  Finalmente queda:
  
  .. math::

    10.625_{10)} = 1010.101_{2)}

* **Ejemplo** de base **decimal** a base **hexadecimal** con decimales 10.625 :sub:`10)→ 16)` =

  Parte decimal
  
  .. math:: 
     
     0.625 \times 16 &= 10 = A
  
     10.625_{10)} &= A.A_{16)}

* **Ejemplo** de base **decimal** a base **octal** con decimales 10.625 :sub:`10)→ 8)` =

  Parte entera
  
  .. math::
  
     10 : 8 &= 1\ resto\ \mathbf{2}
     
     1 : 8 &= 0\ resto\ \mathbf{1}
  
  Parte decimal
  
  .. math::
    
     0.625 \times 8 &= \mathbf{5}.00
     
     10.625_{10)} &= 12.5_{8)}
  
* **Ejemplo con agrupaciones**, entre base 2,8 y 16 podemos utilizar también el método de las agrupaciones
  
  1010.101 :sub:`2)` = 001   010   .   101 = 12.5 :sub:`8)`
  
  1010.101 :sub:`2)` = 1010  .  1010 = A.A :sub:`16)`
  
  
**Operaciones**: 

Vemos a continuación un simple ejemplo de sumas en binario, octal y hexadecimal :

Binario

.. math::
  
   1010.101_{2)}&
  
   +1010.101_{2)}&
  
   ----- &  
  
   10101.01_{2)} &= 21.25_{10}


Octal

.. math::

   12.5_{8)}&
   
   +12.5_{8)}&
   
   --- &
   
   25.2_{8)} &= 21.25_{10}

  
ayuda: :math:`5_{8)} + 5_{8)} = 12_{8)}`, ponemos 2 y 1 de acarreo

Hexadecimal

.. math::

   A.A_{16} = & (10).(10)_{16}
   
   +A.A_{16)} = & (10).(10)_{16}
   
   ----&-----

   & (20).(20)_{16} = (14).(14)_{16} = (1\ acarreo)= 15.4_{16} = 21.25_{10}


Otra forma de hacerlo en base hexadecimal es teniendo en cuenta que A+A=14, A+B=15...