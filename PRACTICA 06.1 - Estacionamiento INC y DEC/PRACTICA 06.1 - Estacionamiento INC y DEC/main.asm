;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	msgEspacio BYTE "Entró carro? ", 0 ; Pregunta al usuario
	msgLleno BYTE "No hay mas espacio en el estacionamiento. ", 0 ; Aviso de lleno
	msgBloqueado BYTE "Espera a que salgan carros del estacionamiento.", 0 ; Aviso de espera

	entradaCarro = 1 ; Constante de entrada
	salidaCarro = 2 ; Constante de salida

.code
main PROC
	mov ebx, 10 ; Espacios disponibles

entradaSalida: ; Ciclo principal
	mov edx, OFFSET msgEspacio ; Direccion del mensaje
	call WriteString ; Imprime el mensaje

	call ReadInt ; Lee opcion del usuario
	cmp eax, entradaCarro ; Compara si entra carro
	dec ebx ; Resta 1 espacio

	cmp eax, salidaCarro ; Compara si sale carro
	inc ebx ; Suma 1 espacio

	mov edx, OFFSET msgLleno ; Direccion de aviso lleno
	call WriteString ; Imprime el aviso
	call Crlf ; Salto de linea

	jz lleno ; Si llega a 0, salta a 'lleno'

	mov edx, OFFSET msgAttempts ; Direccion del texto de intentos
	call WriteString ; Imprime texto de intentos

	mov eax, ebx ; Pasa espacios a EAX
	call WriteDec ; Imprime espacios restantes
	call Crlf ; Salto de linea

	jmp entradaSalida ; Repite el ciclo

bloqueado: ; Seccion de bloqueo
	mov edx, OFFSET msgBloqueado ; Direccion de aviso bloqueado
	call WriteString ; Imprime el aviso
	call Crlf ; Salto de linea
	
	call ReadInt ; Lee un numero
	cmp eax ; Compara EAX

	jmp fin ; Salta al final

lleno: ; Seccion sin cupo
	mov edx, OFFSET msgLleno ; Direccion de aviso lleno
	call WriteString ; Imprime el aviso
	call Crlf ; Salto de linea

	jmp bloqueado ; Salta a 'bloqueado'

fin:
	exit
main ENDP

END main