;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data

.code
main PROC

	mov edx, OFFSET prompt2 ; Direccion del mensaje para pedir el primer numero
	call WriteString ; Imprime el mensaje en consola
	call ReadInt ; Lee el numero ingresado y lo guarda en EAX
	mov ecx, eax ; Respalda el primer numero en ECX

	mov edx, OFFSET prompt1 ; Direccion del mensaje para pedir el segundo numero
	call WriteString ; Imprime el mensaje en consola
	call ReadInt ; Lee el segundo numero en EAX
	mov ebx, eax ; Guarda el segundo numero en EBX

	mov eax, ecx ; Pasa el primer numero de vuelta a EAX
	mov ebx, ebx ; Mantiene el segundo numero en EBX
	
	cmp eax, ebx ; Compara el primer numero (EAX) con el segundo (EBX)

	je iguales ; Si son iguales, salta a la etiqueta 'iguales'

	mov edx, OFFSET msgDiferentes ; Direccion del mensaje de que son diferentes
	call WriteString ; Imprime que los numeros son diferentes

	jge mayor ; Si el primero es mayor o igual al segundo, salta a 'mayor'
	mov edx, OFFSET msgMenor ; Direccion del mensaje cuando es menor
	call WriteString ; Imprime que el numero es menor

	

	jmp fin ; Salta al final del programa
	
iguales: ; Seccion cuando ambos numeros valen lo mismo
	mov edx, OFFSET msgiguales ; Direccion del mensaje de iguales
	call WriteString ; Imprime el mensaje de iguales

mayor: ; Seccion cuando el primer numero es mayor o igual
	mov edx, OFFSET msgEsmayoroigual ; Direccion del mensaje de mayor o igual
	call WriteString ; Imprime el mensaje en consola

fin:
	call Crif
	exit

main ENOP
END main