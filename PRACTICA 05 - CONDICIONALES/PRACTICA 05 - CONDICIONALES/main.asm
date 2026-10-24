;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	msgIngresar BYTE "Ingrese la cadena: ", 0 ; Texto para pedir el dato al usuario
	msgError BYTE "FORMATO INVALIDO", 0 ; Mensaje si la cadena no cumple el formato
	msgValido BYTE "FORMATO VALIDO", 0 ; Mensaje si la cadena es correcta

	cadena BYTE 8 DUP(0) ; Reserva 8 bytes en ceros para guardar la cadena ingresada
	
.code
main PROC

	mov edx, OFFSET msgIngresar ; Pasa la direccion del mensaje de ingreso a EDX
	call WriteString ; Imprime el mensaje en pantalla

	mov edx, OFFSET cadena ; Pasa a EDX la direccion donde se guardara el texto
	mov ecx, SIZEOF cadena ; Define en ECX el limite maximo de caracteres a leer (8)

	call ReadString ; Lee lo que escribe el usuario y lo guarda en 'cadena'
	call Crlf ;

	mov edx, OFFSET cadena ; Pasa la direccion de la cadena guardada a EDX
	call WriteString ; Imprime en pantalla la cadena que se acaba de ingresar
	call Crlf ;

validarLetra: ; Etiqueta para revisar que los caracteres sean letras mayusculas
	mov ESI, 0 ; Inicializa el indice ESI en la posicion 0 del arreglo
	mov AL, cadena[ESI] ; Copia a AL el caracter de 'cadena' en la posicion ESI
	cmp AL, 'A' ; Compara el caracter con el codigo ASCII de 'A'
	jb ; Salta si es menor que 'A' (no es letra mayuscula)
	ja 'Z' ; Salta si es mayor que 'Z' (se sale del rango de mayusculas)
	je validarGuion ; Si cumple la condicion, salta a revisar el guion

	inc ESI ; Incrementa el indice ESI en 1 para pasar al siguiente caracter
	jmp validar ; Regresa al inicio del ciclo para evaluar la siguiente posicion

validarGuion: ; Etiqueta para comprobar que exista un guion en la cuarta posicion
	mov ESI, 3 ; Coloca el indice ESI en la posicion 3 (el cuarto caracter)
	mov AL, cadena[ESI] ; Carga ese cuarto caracter en el registro AL
	cmp AL, '-' ; Compara el caracter con el simbolo de guion '-'
	je validarNum ; Si es igual a '-', salta a la parte que valida los numeros

	jz invalido ; Salta a la etiqueta de error si el formato no coincide

invalido: ; Etiqueta a la que llega el programa cuando el formato es incorrecto


	exit
main ENDP

END main