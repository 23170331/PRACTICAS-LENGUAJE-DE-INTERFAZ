;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data

.code
main PROC
	; ciclo while con incremento
	mov ebx, 0 ; Inicia el contador en 0

ciclo_while: ; Inicio del ciclo while
	cmp ebx, 100 ; Compara EBX con el limite 100
		
	jg fin_while ; Si es mayor a 100, sale del ciclo

	mov eax, ebx ; Pasa el valor a EAX para poder imprimirlo
	call WriteDec ; Imprime el numero en consola
	call crlf ; Salto de linea

	inc ebx ; Aumenta el contador EBX en 1

	jmp ciclo_while ; Regresa al inicio del ciclo
fin_while: ; Etiqueta de salida del while

	; ciclo do while con incremento
	mov ebx, 1 ; Inicia el contador en 1

ciclo_dowhile: ; Inicio del ciclo do-while
	mov eax, ebx ; Pasa el valor a EAX para imprimirlo
	call WriteDec ; Imprime el numero actual
	call crlf ; Salto de linea

	inc ebx ; Aumenta el contador EBX en 1

	cmp ebx, 100 ; Evalua si el contador llego al limite 100
	jle ciclo_dowhile ; Si es menor o igual a 100, repite el ciclo

	exit
main ENDP

END main