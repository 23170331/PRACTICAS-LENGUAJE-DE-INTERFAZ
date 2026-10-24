;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc

.data
	nombreArchivo BYTE "inventario.txt", 0 ;nombre del archivo donde se guardarán los datos
	texto BYTE "125", 0 ; dato a guardar
	archivoHandle DWORD ? ; manejador de archivos

	mensajeExito BYTE "Archivo guardado.", 0 ; Aviso de exito
	mensajeError BYTE "ERROR. No se guardó el archivo correctamente.", 0 ; Aviso de fallo
.code
main PROC
	; 1. CREAR EL ARCHIVO
	mov edx, OFFSET nombreArchivo ; va a la primera posicion de nombreArchivo, toma la direccion y escribe el nombre del archivo
	call CreateOutputFile ; Crea el archivo y devuelve su ID en EAX

	cmp eax, INVALID_HANDLE_VALUE ; verificame si ese valor al crear el archivo corresponde a un valor invalido que identifique el error
	je error ; Si hubo fallo al crear, salta a 'error'

	mov archivoHandle, eax ; guardamos el identificador guardado en eax generado a partir del CreateOutputFile

	; 2. ESCRIBIR TEXTO ('125')
	mov eax, archivoHandle ; almacenar el id de nuestro archivo
	mov edx, OFFSET texto ; Direccion del texto que se va a escribir
	mov ecx, SIZEOF texto - 1 ; ponemos - 1 para no incluir el cero en la cadena
	call WriteToFile ; Escribe los datos en el archivo y devuelve bytes escritos en EAX

	jc errorEscritura ; verificamos si la bandera carryflag (CF) se activo y determina si hay error
	
	; determinar si se escribio correctamente en el archivo
	cmp eax, SIZEOF texto - 1 ; comparamos el tamaño de texto con eax ya que contiene la longitud de bytes escritos
	jne errorEscritura ; Si no se escribieron todos los bytes, salta a 'errorEscritura'

	; 3. CERRAR ARCHIVO TXT
	mov eax, archivoHandle ; Pasa el ID del archivo a EAX para cerrarlo
	call CloseFile ; Cierra el archivo abierto

	test eax, eax ; verifica si eax = 0 para determinar si hay error o no, activando la zeroFlag
	jz error ; Si devuelve 0, salta a 'error'

	mov edx, OFFSET mensajeExito ; Direccion del mensaje de exito
	call WriteString ; Imprime el aviso de archivo guardado
	jmp fin ; Salta al final del programa

errorEscritura: ; Seccion si falla la escritura
	mov eax, archivoHandle ; Carga el ID del archivo abierto
	call CloseFile ; Cierra el archivo antes de mostrar el error
error: ; Seccion para mostrar mensaje de fallo
	mov edx, OFFSET mensajeError ; Direccion del mensaje de error
	call WriteString ; Imprime el error en pantalla
fin:
	exit

	exit
main ENDP

END main