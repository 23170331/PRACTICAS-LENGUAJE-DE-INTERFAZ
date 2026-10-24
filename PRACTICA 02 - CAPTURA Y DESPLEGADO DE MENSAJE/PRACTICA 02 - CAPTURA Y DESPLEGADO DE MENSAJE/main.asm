;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	mensaje BYTE "Escribe tu nombre: ", 0 ; Declara la cadena de texto a mostrar terminada en nulo

	nombre BYTE 15 DUP(0) ; Reserva un espacio de 15 bytes vacios para guardar el nombre

.code
main PROC
	mov edx, OFFSET mensaje ; Pasa la direccion de memoria de 'mensaje' al registro EDX
	call WriteString ; Imprime en pantalla el texto al que apunta EDX

	mov edx, OFFSET nombre ; Pasa a EDX la direccion donde se guardara lo que escriba el usuario
	mov ecx, SIZEOF nombre ; Guarda en ECX el limite maximo de caracteres permitidos (15)

	call ReadString ; Detiene el programa para leer el teclado y lo guarda en 'nombre'
	call Crlf ; Hace un salto de linea en la consola

	mov edx, OFFSET nombre ; Pasa la direccion de la variable 'nombre' (ya con datos) a EDX
	call WriteString ; Imprime en pantalla el nombre que se guardo
	call Crlf ; Hace otro salto de linea

	exit ; 
main ENDP

END main ;