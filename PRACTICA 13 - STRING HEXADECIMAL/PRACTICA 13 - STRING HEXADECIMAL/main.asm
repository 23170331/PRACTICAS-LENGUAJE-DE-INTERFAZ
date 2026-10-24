;MATERIA: LENGUAJES DE INTERFAZ
;HORARIO: 8 a 9 AM
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;ALUMNO: SAlAZAR ORTIZ CARLOS ALBERTO

INCLUDE Irvine32.inc
 
.data
    numero      DWORD 1A2B3FFFh ; Valor en hexadecimal a convertir
    cadenaHex   BYTE  8 DUP(?), 0 ; buffer para 8 caracteres
    msg         BYTE  "Cadena Hex ASCII: ", 0 ; Texto descriptivo a mostrar
 
.code
main PROC
    mov eax, numero ; eax sera el valor a convertir
    mov edi, OFFSET cadenaHex ; edi nos apunta el inicio del buffer de texto
    
    call BinToHexASCII ; Llama al procedimiento de conversion
 
    ; mostrar resultado
    mov edx, OFFSET msg ; Direccion del mensaje descriptivo
    call WriteString ; Imprime el mensaje en consola
    
    mov edx, OFFSET cadenaHex ; edx apunta a la cadena ya convertida
    call WriteString ; Imprime el numero hexadecimal en texto
    call Crlf ; Salto de linea
 
    exit
main ENDP
 
BinToHexASCII PROC
    pushad ; guardamos todos los registros
    mov ecx, 8 ; contador de 8 digitos hexadecimales de 32 bits
 
CicloHex: ; Inicio del ciclo para extraer cada digito
    rol eax, 4 ; Rota 4 bits a la izquierda para pasar el digito mas alto al final
    mov bl, al ; movemos el byte bajo a BL para no modificar eax
    and bl, 0Fh ; solo valores de 0 a 15
 
    cmp bl, 9 ; compara si el digito es menor o igual a 9
    jbe EsNumero ; si es 0-9 salta a EsNumero
    
    ; Si es de 10 a 15 (A - F):
    add bl, 37h ; 10 + 37h (55) = 41h ('A' en ASCII)
    jmp GuardarDigito ; Salta para guardar el caracter convertido
 
EsNumero: ; Seccion para convertir digitos del 0 al 9
    ; Si es de 0 a 9:
    add bl, 30h ; 0 + 30h (48) = 30h ('0' en ASCII)
 
GuardarDigito: ; Seccion que escribe el caracter en el buffer
    mov [edi], bl ; guardar el caracter ascii
    inc edi ; avanza a la siguiente posicion
    loop CicloHex ; Resta 1 a ECX y repite si no es 0
 
    mov BYTE PTR [edi], 0 ; agregar el valor nulo al final
    popad ; restaura los registros 
    ret ; Regresa al procedimiento principal
BinToHexASCII ENDP
 
END main
