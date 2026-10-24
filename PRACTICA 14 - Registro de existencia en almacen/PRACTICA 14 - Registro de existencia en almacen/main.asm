;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc
 
.data
    msgPedir    BYTE "Cantidad recibida: ", 0 ; Texto para pedir el dato
    msgErr      BYTE "Entrada invalida. Intente de nuevo.", 0Dh, 0Ah, 0 ; Aviso de error con salto de linea
    msgExistencia      BYTE "Existencia actual: ", 0 ; Texto para mostrar el resultado
    msgUnid     BYTE " unidades.", 0Dh, 0Ah, 0 ; Texto final con salto de linea
 
    cantidadRecibida DWORD ? ; Variable para el numero convertido
    existenciaActual DWORD ? ; Variable para el total sumado
    buffer           BYTE 10 DUP(0) ; Espacio para guardar la entrada del usuario
    outBuffer        BYTE 10 DUP(0) ; Espacio para el resultado convertido a texto
 
.code
main PROC
pedir: ; Etiqueta para solicitar la entrada
    mov edx, OFFSET msgPedir ; Direccion del mensaje de solicitud
    call WriteString ; Imprime el mensaje en pantalla
 
    mov edx, OFFSET buffer ; Direccion donde se guardara lo leido
    mov ecx, SIZEOF buffer ; Limite maximo de caracteres a leer (10)
    call ReadString ; eax = cantidad de caracteres leidos

    cmp eax, 1 ; Compara la longitud con 1 caracter
    jl error ; revisamos que no sea menor a 1 en caso de que ingresen una cantidad vacia
    cmp eax, 2 ; Compara la longitud con 2 caracteres
    jg error ; comparamos si es mayor a 2 digitos la cantidad ingresada
 
    mov esi, OFFSET buffer ; Apunta ESI al inicio del buffer leido
    mov ecx, eax               ; contador del bucle tomado de la longitud
    xor ebx, ebx               ; acumulado igual a 0
 
validarYconvertir: ; Ciclo para revisar digitos y pasarlos a entero
    movzx eax, BYTE PTR [esi] ; carga byte actual en al y llenamos con 0
 
    ; Validar rango 0 a 9
    cmp al, '0' ; compara si el valor en ASCII es igual a 0 del caracter 0
    jb error ; salta a error en caso de que sea cero
    cmp al, '9' ; compara el valor en ascii
    ja error ; si el valor es mayor a 9 se va a error
 
    sub al, '0' ; convertimos char a numero 
    imul ebx, ebx, 10 ; valor acumulado en ebx * 10
    add ebx, eax ; sumamos el nuevo digito 
   
    inc esi ; avanzamos al siguiente caracter dek buffer
    loop validarYconvertir ; decrementa ecx para el ciclo
 
    ; rango 1 a 99
    cmp ebx, 1 ; Compara el numero final con el minimo (1)
    jl error ; Si es menor a 1, salta a error
    cmp ebx, 99 ; Compara el numero final con el maximo (99)
    jg error ; Si es mayor a 99, salta a error
 
    
    mov cantidadRecibida, ebx ; guardamos el numero entero en la variable
    mov eax, ebx ; Pasa la cantidad recibida a EAX
    add eax, 25 ; sumamos la existencia
    mov existenciaActual, eax ; Guarda el total en 'existenciaActual'

    mov edx, OFFSET msgExistencia ; Direccion del texto de existencia
    call WriteString ; Imprime el texto en consola
 
    mov eax, existenciaActual ; Pasa el total a EAX para convertirlo
    mov edi, OFFSET outBuffer ; usamos edi para construir el texto
    call ConvertirACadena ; Llama al procedimiento que pasa de entero a ASCII
 
    mov edx, OFFSET outBuffer ; direccion con la cadena convertida
    call WriteString ; Imprime el numero ya hecho texto
    mov edx, OFFSET msgUnid ; Direccion del texto 'unidades'
    call WriteString ; Imprime el texto final
 
    exit
 
error: ; Seccion para entradas invalidas
    mov edx, OFFSET msgErr ; Direccion del mensaje de error
    call WriteString ; Imprime el aviso de error
    jmp pedir ; Regresa al inicio para volver a pedir el dato
 
main ENDP

ConvertirACadena PROC
    mov ebx, 10 ; Divisor base 10 para separar digitos
    xor ecx, ecx ; ecx = 0, contador de digitos que se guarda en la pila
extraer: ; Ciclo para obtener cada digito dividiendo
    xor edx, edx ; edx = 0
    div ebx ; divide edx (eax/10)
    add dl, '0' ; convierte el residuo eb codigo ascii
    push dx ; Guarda el caracter en la pila para invertir el orden
    inc ecx ; Aumenta en 1 el contador de digitos
    test eax, eax ; verifica si el cociente es 0
    jnz extraer ; si el cociente no es 0, continua extrayendo digitos
escribir: ; Ciclo para sacar los digitos en el orden correcto
    pop dx ; Recupera el ultimo digito guardado en la pila
    mov [edi], dl; escribimos el caracter ascii en la posicion actual de outbuffer señalada por edi
    inc edi ; Avanza a la siguiente posicion del buffer de salida
    loop escribir ; Repite hasta vaciar todos los digitos contados en ECX
    mov BYTE PTR [edi], 0 ; agregamos el byte nulo para marcar el fin de la cadena
    ret ; Regresa al procedimiento principal
ConvertirACadena ENDP
 
END main