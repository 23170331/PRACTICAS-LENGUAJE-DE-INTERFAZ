;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data

.code
main PROC
	; 1. ADD: SUMA DE VALORES EN REGISTROS
	mov eax, 15 ; Carga 15 en EAX
	mov ebx, 10 ; Carga 10 en EBX

	add eax, ebx ; eax = 15 + 10 = 25

	nop ; Pausa sin operacion

	; 2. SUB: RESTA DE VALORES EN REGISTROS
	mov eax, 50 ; Carga 50 en EAX
	mov ebx, 20 ; Carga 20 en EBX

	sub eax, ebx ; eax = 50 - 20 = 30

	nop ; Pausa sin operacion

	; 3. MUL: MULTIPLICACION DE VALORES EN 8 BITS
	mov al, 5 ; Carga 5 en AL
	mov bl, 4 ; Carga 4 en BL

	mul bl ; al * bl = 20, el resultado de 16 bits se guarda en AX

	nop ; Pausa sin operacion

	; 4. MUL: MULTIPLICACION DE VALROES DENTRO DE 32 BITS

	mov eax, 25 ; Carga 25 en EAX
	mov ebx, 3 ; Carga 3 en EBX

	mul ebx ; Multiplica EAX * EBX = 75 (guarda en EDX:EAX)

	nop ; Pausa sin operacion

	; 5. MUL: PRODUCTO QUE NECESITA MAS DE 32 BITS

	mov eax, 65537 ; Carga el primer factor en EAX
	mov ebx, 65537 ; Carga el segundo factor en EBX

	; 6. IMUL: MULTIPLICACION CON SIGNO

	mov eax, -5 ; Carga -5 en EAX

	imul eax, eax, 3 ; Multiplica EAX * 3 = -15 con signo

	nop ; Pausa sin operacion

	; 7. DIV: DIVIDENDO SIN SIGNO

	mov eax, 125 ; Carga el dividendo en EAX
	mov edx, 0 ; representa el residuo
	mov ebx, 12 ; Carga el divisor en EBX

	; IDIV: DIVISION CON SIGNO

	mov eax, -125 ; Carga el dividendo negativo en EAX

	cdq ; extiende el signo de eax hacia edx

	mov ebx, 12 ; Carga el divisor en EBX

	idiv ebx ; eax contiene el cociente, edx el residuo

	nop ; Pausa sin operacion
	exit
main ENDP

END main