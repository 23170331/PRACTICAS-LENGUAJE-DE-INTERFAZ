;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.code
main PROC

	; condicion 1: ZERO FLAG
	; mov EBX, 1
	; cmp ebx, 1
	; call dumpRegs

	; mov EAX, 01h
	; call dumpRegs
	; cmp EAX, EBX

	mov ECX, 0 ; Limpia todo el registro ECX poniendolo en 0
	mov cl, 1111111b ; Carga el valor binario en la parte baja de ECX (127 en decimal)
	cmp cl, cl ; activa zeroflag ya que se resta a si mismo el registro y queda el residuo 0
	call dumpRegs ; Muestra en pantalla el estado de los registros y las banderas (ZF=1)
	
	; condicion 2: SIGN FLAG
	mov EAX, 0 ; limpiamos registros
	mov EBX, 0 ; limpiar registros

	mov al, -5 ; Carga un -5 en el registro de 8 bits AL
	mov bl, 1 ; Carga un 1 en el registro BL
	cmp al, bl ; se activa dicha bandera ya que el bit de hasta la izquierda es 1 (internamente hace -5 - 1 = -6, dando resultado negativo)
	call dumpRegs ; Imprime registros y banderas mostrando SF=1

	; CONDICION 3: CARRY FLAG
	mov EAX, 0 ; Reinicia EAX en 0
	mov EBX, 0 ; Reinicia EBX en 0

	mov al, 255 ; Carga el valor maximo sin signo para 8 bits (11111111 en binario)
	add al, 1 ; Le suma 1, provocando que AL regrese a 00000000b
	; se activa carryflag porque al no caber ese bit de mas en 255, el noveno bit se acarrea hacia afuera y activa carryflag

	call dumpRegs ; Muestra en consola como queda activado el acarreo (CF=1)

	; CONDICION 4: OVERFLOW FLAG
	mov EAX, 0 ; Limpia el registro EAX
	mov EBX, 0 ; Limpia el registro EBX

	mov al, -128 ; Carga el limite minimo negativo permitido en 8 bits con signo (-128 a 127)
	mov bl, 1 ; Carga un 1 positivo en BL

	cmp al, bl ; activa of porque esta fuera del rango -129, desbordandose (la resta -128 - 1 supera el limite de 8 bits con signo)
	call dumpRegs ; Muestra los registros con la bandera de desbordamiento encendida (OF=1)

	; CASO 5: TEST
	
	mov EAX, 0 ; Limpia el registro EAX
	
	mov EAX, 5 ;00000101 bits
	test eax, 1 ; Realiza una operacion logica AND entre EAX y 1 sin modificar el valor de EAX

	; 00000101 bits
	; - (Operacion AND bit a bit)
	; 00000001 bits

	; 00000001 bits (Como el resultado es 1 y no es cero, la Zero Flag se apaga: ZF=0)

	call dumpRegs ; Imprime los registros comprobando que EAX sigue valiendo 5 y ZF=0
	

	; agreagar por que se activa la sing flag en este test
	; se activa la sign flag ya que el bit mas alto tiene un valor de uno, intel determina que el bit esta encendido y enciende la bandera 
	mov EAX, 0 ; Limpia el registro EAX
	mov al, 10000000b ; Carga 128 en binario, donde el bit 7 (el mas significativo de AL) es 1
	test al, al ; Hace un AND consigo mismo, dando como resultado 10000000b y activando SF=1 porque el bit de signo quedo en 1

	call dumpRegs ; Muestra en consola el resultado final con la Sign Flag activa (SF=1)


	exit 
main ENDP

END main 