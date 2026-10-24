;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	msgPin BYTE "Ingrese el pin: ", 0 ; Pide el PIN
	msgAttempts BYTE "Intentos restantes: ", 0 ; Texto de intentos
	msgError BYTE "Pin INCORRECTO.", 0 ; Aviso de error
	msgAcceso BYTE "Acceso permitido.", 0 ; Aviso de exito
	msgBloqueado BYTE "Autodestruccion comenzada...", 0 ; Aviso de bloqueo

	pinCorrecto = 1234 ; Constante con el PIN valido

.code
main PROC
	mov ebx, 3 ; Inicia en 3 intentos

intentar: ; Ciclo para pedir PIN
	mov edx, OFFSET msgPin ; Direccion del mensaje
	call WriteString ; Imprime el mensaje

	call ReadInt ; Lee el PIN ingresado
	cmp eax, pinCorrecto ; Compara con el PIN correcto

	je acceso ; Si es igual, salta a 'acceso'

	mov edx, OFFSET msgError ; Direccion del mensaje de error
	call WriteString ; Imprime el error
	call Crlf ; Salto de linea

	dec ebx ; Resta 1 intento

	jz bloqueado ; Si llega a 0, salta a 'bloqueado'

	mov edx, OFFSET msgAttempts ; Direccion del texto de intentos
	call WriteString ; Imprime texto de intentos

	mov eax, ebx ; Pasa intentos a EAX
	call WriteDec ; Imprime intentos restantes
	call Crlf ; Salto de linea

	jmp intentar ; Repite el ciclo

acceso: ; Seccion de PIN correcto
	mov edx, OFFSET msgAcceso ; Direccion de mensaje de exito
	call WriteString ; Imprime acceso permitido
	call Crlf ; Salto de linea

	jmp fin ; Salta al final

bloqueado: ; Seccion sin intentos
	mov edx, OFFSET msgBloqueado ; Direccion de mensaje de bloqueo
	call WriteString ; Imprime aviso de bloqueo
	call Crlf ; Salto de linea

fin:
	exit
main ENDP

END main