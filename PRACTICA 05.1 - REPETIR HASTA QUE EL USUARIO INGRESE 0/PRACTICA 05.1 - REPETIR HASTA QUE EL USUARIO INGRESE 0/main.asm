;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	mensaje BYTE "Numero: ", 0 ; Texto para pedir el dato en pantalla

	numero BYTE 8 DUP(0) ; Reserva 8 bytes en ceros para guardar el numero ingresado

.code
main PROC
	mov ebx, 1 ; Inicializa EBX en 1 para usarlo como contador de repeticiones
ciclo: ; Etiqueta donde inicia el bucle repetitivo
	mov edx, OFFSET mensaje ; Pasa la direccion del mensaje a EDX
	call WriteString ; Imprime en pantalla el texto de 'mensaje'

	mov edx, OFFSET numero ; Pasa a EDX la direccion donde se guardara lo ingresado
	mov ecx, SIZEOF numero ; Define en ECX el limite maximo de caracteres a leer (8)

	call ReadString ; Lee lo que escribe el usuario y lo guarda en 'numero'
	call Crlf

	mov edx, OFFSET numero ; Pasa la direccion del dato guardado en 'numero' a EDX
	call WriteString ; Imprime en consola el numero que se acaba de escribir
	call Crlf

	mov eax, ebx ; Copia el valor actual del contador EBX al registro EAX
	inc ebx ; Incrementa el contador EBX en 1 para la siguiente vuelta

	cmp numero, '0' ; compara el valor ingresado con el 0

	jne ciclo ; si no es igual a 0, se repite el ciclo
	exit

exit
main ENDP

END main