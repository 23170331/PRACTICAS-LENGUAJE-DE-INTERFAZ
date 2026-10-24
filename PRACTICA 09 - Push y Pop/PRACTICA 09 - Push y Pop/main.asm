;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.code
main PROC
	; BLOQUE 1: PUSH Y POP
	mov eax, 30

	push eax
	nop ; instruccion para que se detenga
	
	mov ebx, 0

	pop ebx
	nop ; instruccion para que se detenga

	; BLOQUE 2: ORDEN LIFO
	mov eax, 10
	push eax

	mov eax, 20
	push eax

	mov eax, 30
	push eax

	nop

	; saldran en orden 30, 20, 10 por trabajar con una pila
	pop eax 
	pop ebx
	pop ecx

	nop

	; BLOQUE 3: CONSERVAR REGISTROS

	mov eax, 100
	mov ebx, 200
	
	push eax
	push ebx

	mov eax, 999
	mov ebx, 888

	; sobreescribimos los valores anteriormente guardados con push
	; sale primero 200 y luego el 100
	pop ebx
	pop eax 

	; BLOQUE 4: CALL Y RET
	mov eax, 50
	mov ebx, 666
	
	call aumentarDiez

	nop

	exit


main ENDP

aumentarDiez PROC
	nop
	push ebx ; guardamos 666 en la pila

	nop

	mov ebx, 10 ; usamos ebx para la suma
	add eax, ebx ; sumamos 50 + 10 y guaradamos en eax

	nop

	pop ebx ; ebx vuelve a ser 666

	nop

	ret ; regresa al punto donde saltamos al "metodo"
aumentarDiez ENDP

END main