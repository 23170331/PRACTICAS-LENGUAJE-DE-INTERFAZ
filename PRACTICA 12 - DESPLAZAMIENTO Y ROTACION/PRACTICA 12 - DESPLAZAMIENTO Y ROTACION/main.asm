;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.code
main PROC
	mov eax, 0 ; Limpia EAX en 0
	mov ebx, 0 ; Limpia EBX en 0
	mov ecx, 0 ; Limpia ECX en 0
	mov edx, 0 ; Limpia EDX en 0

	; 1 - SHL: DESPLAZAR UNA POSICION A LA IZQUIERDA
	mov al, 10000000b  ;se recorre hacia la izquierda y desaparece el bit encendido
	shl al, 1 ; Desplaza 1 bit a la izquierda (el bit saliente activa CF=1)

	call DumpRegs ; muestra las banderas
	call Writebin ; Imprime EAX en formato binario


	; 2 - SHR: DESPLAZAR UNA POSICION A LA DERECHA
	mov al, 00001101b  ;desaparece el ultimo bit ya que se recorre a la derecha
	shr al, 1 ; Desplaza 1 bit a la derecha (divide entre 2 sin signo)

	call DumpRegs ; Muestra registros y banderas
	call writebin ; Imprime el resultado en binario

	; 3 - SAR: CONSERVAR EL SIGNO
	mov al, -8 ; Carga -8 en AL
	sal al, 1 ; Desplaza a la izquierda multiplicando por 2 (-16)

	call writebin ; Imprime el valor en binario
	call dumpregs ; Muestra registros y banderas

	; 4 - SAR: CON OPERACIONES NO EXACTAS
	mov al, -9 ; Carga -9 en AL
	sar al, 1 ; Desplaza a la derecha conservando el bit de signo (-5)

	call DumpRegs ; Muestra registros y banderas
	call writebin ; Imprime el resultado en binario

	; 5 - CONTEO: DESPLAZAR 2 BITS HACIA LA IZQUIERDA CON CONSTANTE (valor directo)
	mov al, 00001111b ; Carga 15 en binario en AL
	shl al, 2 ; Desplaza 2 posiciones a la izquierda (00111100b)
	
	call DumpRegs ; Muestra registros y banderas
	call writebin ; Imprime el valor en binario

	; 6 - DESPLAZAR 2 BITS HACIA LA DERECHA UTILIZANDO CL (asignamos valor al registro cl y desplazamos)
	mov al, 00001111b ; Carga 15 en binario en AL
	mov cl, 2 ; Define en CL la cantidad de bits a desplazar (2)
	shr al, cl ; Desplaza AL a la derecha segun el valor de CL (00000011b)

	call DumpRegs ; Muestra registros y banderas
	call writebin ; Imprime el resultado en binario

	; 7 - ROR, ROL, RCL, RCR    -- ROTACIONES 
	mov al, 00001111b ; Carga el valor inicial en AL
	rcl al, 1 ; Rota a la izquierda incluyendo el valor de la Carry Flag

	call DumpRegs ; Muestra registros y banderas
	call writebin ; Imprime el resultado en binario

	; 8 - ROL: ROTAR A LA IZQUIERDA (el bit mas significativo pasa al final)
	mov al, 10000001b ; Carga el patron de bits en AL
	rol al, 1 ; Rota 1 posicion a la izquierda (queda 00000011b y CF=1)

	call DumpRegs ; Muestra registros y banderas
	call Writebin ; Imprime el resultado en binario

	; 9 - ROR: ROTAR A LA DERECHA (el ultimo bit pasa al inicio)
	mov al, 10000001b ; Carga el patron de bits en AL
	ror al, 1 ; Rota 1 posicion a la derecha (queda 11000000b y CF=1)

	call DumpRegs ; Muestra registros y banderas
	call Writebin ; Imprime el resultado en binario

	; 10 - RCR: ROTAR A LA DERECHA A TRAVES DEL CARRY (carry pasa al inicio)
	stc ; enciende la bandera Carry (CF = 1)
	mov al, 00000001b ; Carga 1 en binario en AL
	rcr al, 1 ; Rota a la derecha metiendo el Carry al inicio (queda 10000000b)

	call DumpRegs ; Muestra registros y banderas
	call Writebin ; Imprime el resultado en binario

	exit

main ENDP

END main