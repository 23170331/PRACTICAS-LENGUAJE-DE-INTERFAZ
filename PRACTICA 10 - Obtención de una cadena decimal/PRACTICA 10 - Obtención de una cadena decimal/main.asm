;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
    ; Datos del problema
    tamArchivo DWORD 100000 ; Tamaño total del archivo en bytes
    bloques DWORD 125 ; Cantidad de bloques descargados
    tamBloque DWORD 512 ; Tamaño de cada bloque en bytes

    ; Resultados
    descargados DWORD ? ; Variable para total descargado
    pendientes DWORD ? ; Variable para bytes faltantes
    porcentaje DWORD ? ; Variable para el porcentaje
    grupos DWORD ? ; Variable para grupos de 1024
    residuo DWORD ? ; Variable para bytes sobrantes

    ; Mensajes
    msg1 BYTE "Bytes descargados: ",0 ; Texto para descargados
    msg2 BYTE "Bytes pendientes: ",0 ; Texto para pendientes
    msg3 BYTE "Porcentaje de avance: ",0 ; Texto para porcentaje
    msg4 BYTE "Grupos completos de 1024: ",0 ; Texto para grupos
    msg5 BYTE "Residuo del agrupamiento: ",0 ; Texto para residuo
    salto BYTE 13,10,0 ; Codigos ASCII para salto de linea

    ; Buffer de 11 bytes
    buffer BYTE 11 DUP(0) ; Espacio para guardar el numero hecho texto

.code

; Convertir EAX a texto decimal
; EAX = numero
; ESI = direccion del buffer

convertirDecimal PROC
    push eax ; Respalda EAX en la pila
    push ebx ; Respalda EBX en la pila
    push ecx ; Respalda ECX en la pila
    push edx ; Respalda EDX en la pila
    push edi ; Respalda EDI en la pila

    mov edi, esi ; Copia la direccion del buffer a EDI
    add edi, 10 ; Apunta al ultimo byte del buffer
    mov BYTE PTR [edi], 00h ; Coloca el caracter nulo al final

    mov ebx, 10 ; Divisor base 10 para sacar digitos

    cmp eax, 0 ; Verifica si el numero es 0
    jne convertir ; Si no es 0, salta a 'convertir'

    dec edi ; Retrocede una posicion en el buffer
    mov BYTE PTR [edi], '0' ; Coloca el caracter '0'
    jmp terminado ; Salta a 'terminado'

convertir:
    xor edx, edx ; Limpia EDX en 0 para la division
    div ebx ; Divide EAX entre 10 (residuo en DL)

    add dl, '0' ; Convierte el digito a caracter ASCII
    dec edi ; Retrocede una posicion en el buffer
    mov [edi], dl ; Guarda el caracter en el buffer

    cmp eax, 0 ; Revisa si el cociente llego a 0
    jne convertir ; Si quedan digitos, repite el ciclo

terminado:
    ; Mover los digitos al inicio del buffer
    mov esi, edi ; Apunta ESI a donde empieza el numero
    mov ecx, 0 ; Inicia contador de caracteres en 0

contar:
    cmp BYTE PTR [esi+ecx], 0 ; Busca el fin de cadena (nulo)
    je copiarInicio ; Si llega al final, salta a copiar
    inc ecx ; Cuenta un caracter mas
    jmp contar ; Repite el conteo

copiarInicio:
    mov edi, OFFSET buffer ; Apunta EDI al inicio del buffer
    inc ecx ; Incluye el caracter nulo en la copia
    cld ; Configura direccion de copia hacia adelante
    rep movsb ; Copia los caracteres de ESI a EDI

    pop edi ; Recupera el valor original de EDI
    pop edx ; Recupera el valor original de EDX
    pop ecx ; Recupera el valor original de ECX
    pop ebx ; Recupera el valor original de EBX
    pop eax ; Recupera el valor original de EAX
    ret ; Regresa de la funcion
convertirDecimal ENDP

main PROC

    ; 1. Bytes descargados
    mov eax, bloques ; Carga cantidad de bloques (125)
    mul tamBloque ; Multiplica por tamaño de bloque (512)
    mov descargados, eax ; Guarda el resultado (64000)

    ; 2. Bytes pendientes
    mov eax, tamArchivo ; Carga tamaño total (100000)
    sub eax, descargados ; Resta los bytes descargados (64000)
    mov pendientes, eax ; Guarda los pendientes (36000)

    ; 3. Porcentaje entero
    mov eax, descargados ; Carga bytes descargados
    mov ebx, 100 ; Carga 100 para regla de tres
    mul ebx ; Multiplica descargados * 100
    mov ebx, tamArchivo ; Carga el tamaño total del archivo
    div ebx ; Divide entre el tamaño total
    mov porcentaje, eax ; Guarda el porcentaje (64)

    ; 4. Grupos de 1024 y residuo
    mov eax, descargados ; Carga bytes descargados
    xor edx, edx ; Limpia EDX para la division
    mov ebx, 1024 ; Carga el tamaño de grupo (1024)
    div ebx ; Divide descargados entre 1024
    mov grupos, eax ; Guarda el cociente en 'grupos'
    mov residuo, edx ; Guarda el sobrante en 'residuo'

    ; Mostrar bytes descargados
    mov edx, OFFSET msg1 ; Direccion del mensaje 1
    call WriteString ; Imprime el mensaje
    mov eax, descargados ; Pasa valor descargado a EAX
    mov esi, OFFSET buffer ; Pasa direccion del buffer a ESI
    call convertirDecimal ; Convierte el numero a texto
    mov edx, OFFSET buffer ; Direccion del buffer ya convertido
    call WriteString ; Imprime el numero en pantalla
    call Crlf ; Salto de linea

    ; Mostrar bytes pendientes
    mov edx, OFFSET msg2 ; Direccion del mensaje 2
    call WriteString ; Imprime el mensaje
    mov eax, pendientes ; Pasa bytes pendientes a EAX
    mov esi, OFFSET buffer ; Pasa direccion del buffer a ESI
    call convertirDecimal ; Convierte el numero a texto
    mov edx, OFFSET buffer ; Direccion del buffer con el texto
    call WriteString ; Imprime el numero en pantalla
    call Crlf ; Salto de linea

    ; Mostrar porcentaje
    mov edx, OFFSET msg3 ; Direccion del mensaje 3
    call WriteString ; Imprime el mensaje
    mov eax, porcentaje ; Pasa el porcentaje a EAX
    mov esi, OFFSET buffer ; Pasa direccion del buffer a ESI
    call convertirDecimal ; Convierte el numero a texto
    mov edx, OFFSET buffer ; Direccion del buffer con el texto
    call WriteString ; Imprime el porcentaje
    mov edx, OFFSET salto ; Direccion del salto manual
    call WriteString ; Imprime el salto de linea

    ; Mostrar grupos completos
    mov edx, OFFSET msg4 ; Direccion del mensaje 4
    call WriteString ; Imprime el mensaje
    mov eax, grupos ; Pasa cantidad de grupos a EAX
    mov esi, OFFSET buffer ; Pasa direccion del buffer a ESI
    call convertirDecimal ; Convierte el numero a texto
    mov edx, OFFSET buffer ; Direccion del buffer con el texto
    call WriteString ; Imprime los grupos
    call Crlf ; Salto de linea

    ; Mostrar residuo
    mov edx, OFFSET msg5 ; Direccion del mensaje 5
    call WriteString ; Imprime el mensaje
    mov eax, residuo ; Pasa el residuo a EAX
    mov esi, OFFSET buffer ; Pasa direccion del buffer a ESI
    call convertirDecimal ; Convierte el numero a texto
    mov edx, OFFSET buffer ; Direccion del buffer con el texto
    call WriteString ; Imprime el residuo
    call Crlf ; Salto de linea

    exit

main ENDP
END main