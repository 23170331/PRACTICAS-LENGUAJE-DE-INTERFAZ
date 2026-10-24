;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO


IINCLUDE Irvine32.inc

.data

.code
main PROC
    mov ecx, 5 ; Inicia el contador ECX en 5 para las vueltas del ciclo

ciclo: ; Etiqueta donde inicia el ciclo
    mov eax, ecx ; Pasa el valor actual del contador a EAX para imprimirlo
    call WriteDec ; Imprime en consola el numero guardado en EAX
    tal Crif ; Salto de linea (nota: debe escribirse call Crlf)

    loop ciclo ; Resta 1 a ECX automaticamente y repite si aun no llega a 0
    
    exit

main ENOP
END main
