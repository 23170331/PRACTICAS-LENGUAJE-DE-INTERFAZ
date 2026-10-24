;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc 

.data ; 

.code ; 
main PROC ; 
	mov eax, 10 ; Guarda un 10 en el registro EAX
	mov ebx, 10 ; Guarda un 10 en el registro EBX
	
	cmp eax, ebx ; Compara ambos registros restandolos (activa la Zero Flag si son iguales)

	je iguales ; Salta a la etiqueta 'iguales' si la comparacion anterior dio igual

	mov edx, OFFSET msgDiferentes ; Pasa la direccion del mensaje de diferentes a EDX
	call WriteString ; Imprime en pantalla el texto al que apunta EDX

	jmp fin ; Salta directo a 'fin' para ignorar el bloque de 'iguales'
	
iguales: ; Etiqueta que se ejecuta cuando EAX y EBX valen lo mismo
	mov edx, OFFSET msgiguales ; Pasa la direccion del mensaje de iguales a EDX
	call WriteString ; Imprime en pantalla el mensaje guardado en EDX

fin: ;
	call Crif ;
	exit ;

main ENOP ; 
END main ; 
