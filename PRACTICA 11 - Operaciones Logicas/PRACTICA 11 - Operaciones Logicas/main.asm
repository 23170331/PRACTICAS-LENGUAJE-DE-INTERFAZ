;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data

.code
main PROC
	; 0 - encendido de computadora
	; 1 - alarma
	; 2 - conectado
	; Estado inicial: 00000101

	; 1.- AND: EXTRAER EL ESTADO DE ENCENDIDO
	mov eax, 0 ; Limpia EAX en 0
	mov ebx, 0 ; Limpia EBX en 0

	mov al, 00000101b ; Carga el estado inicial en AL
	mov bl, al ; Copia el estado a BL
	and bl, 00000001b ; Aisla el bit 0 (encendido) y apaga los demas
	nop ; Pausa sin operacion

	call dumpRegs ; Muestra registros y banderas en consola
	nop ; Pausa sin operacion

	; 2.- OR: ENCENDER ALARMA
	mov al, 00000101b ; Restaura el estado inicial en AL
	or al, 00000010b ; Enciende el bit 1 (alarma) sin alterar los otros

	call dumpRegs ; Muestra registros con el nuevo estado
	nop ; Pausa sin operacion

	; 3.- XOR: DESCONECTAR Y CONECTAR COMPUTADORA
	mov al, 00000101b ; Restaura el estado inicial en AL
	xor al, 00000100b ; desconectamos invirtiendo el bit de 1 a 0
	call dumpRegs ; Muestra el cambio en los registros
	nop ; Pausa sin operacion

	xor al, 00000100b ; volvemos a conectar invirtiendo de 0 a 1
	call dumpRegs ; Muestra el estado reconectado en consola
	nop ; Pausa sin operacion



	exit

main ENDP

END main