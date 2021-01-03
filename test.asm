;----------------------------------------------------------------
; Name - Khushbu Shah                                           |
; Date -12-02-2020                                              |
; Computer System-1                                             |
; Project-3                                                     |
;----------------------------------------------------------------
segment .data 
   msg0 db "Enter an Operation code ", 0xA, 0XD   ;prompting user to enter code
   len0 equ $- msg0                               ;user input                              
   
   msg1 db "Enter a digit ", 0xA, 0xD             ;prompting user to enter the digit
   len1 equ $- msg1                               ;user input

   msg2 db "Please enter a second digit", 0xA, 0xD ;prompting user to enter the second digit
   len2 equ $- msg2                                ;user input

   msg3 db "The result is: "                       ;will print result
   len3 equ $- msg3                               
;--------------------------------------  
Lableoperator: db "s"       ;variable assignment 
    var3 resw 100           ;storing into register

Addsign: db "+"             ;variable assignment
   var resw 100             ;storing into register
;--------------------
Minussign: db "-"          ;variable assigning
   var2 resw 100           ;storing into register
;-------------------           
segment .bss               ;statically allocating the variable
num1 resb 100              ;aloocating the var
num2 resb 100
res resb 100   

section .text	
		
Read:                ;read function
mov     rax, 4      ; write        
mov     rbx, 1      ; stdout        
mov     rcx,msg0 ; where characters start        
mov     rdx,len0  ; 16 characters
int     0x80
               
mov     rax, 3      ; read        
mov     rbx, 0      ; from stdin        
mov     rcx, var    ; storage starting        
mov     rdx,100     ; no more than 64 (?) chars   
int     0x80
;--------------Subtraction-----------------------------------
;mov     rax, 4      ; write        
;mov     rbx, 1      ; stdout        
;mov     rcx,msg0    ; where characters start        
;mov     rdx,len0    ; 16 characters
;int     0x80
               
mov     rax, 3      ; read        
mov     rbx, 0      ; from stdin        
mov     rcx, var2 ; start of storage        
mov     rdx,100   ; no more than 64 (?) chars   
int     0x80
;----------------s operator---------------------
mov     rax, 3      ; read        
mov     rbx, 0      ; from stdin        
mov     rcx, var3 ; start of storage        
mov     rdx,100   ; no more than 64 (?) chars   
int     0x80
;-------------------------------------------------------
Numbers:
   mov eax, 4     ;to write       
   mov ebx, 1     ;stdout       
   mov ecx, msg1  ;message place into register        
   mov edx, len1  ; user input placed into register 
   int 0x80                

   mov eax, 3     ;reading
   mov ebx, 0     ;stdin
   mov ecx, num1  ;num1 into ecx register
   mov edx, 100   ;bytes storage
   int 0x80            

   mov eax, 4     ;to write      
   mov ebx, 1     ;stdout    
   mov ecx, msg2  ;message place into register        
   mov edx, len2   ;user input      
   int 0x80

   mov eax, 3    ;reading
   mov ebx, 0    ;stdin
   mov ecx, num2 ;num2 into register 
   mov edx, 100  ;bytes storage
   int 0x80        

   mov eax, 4    ;reading        
   mov ebx, 1    ;reading     
   mov ecx, msg3 ;message place into register         
   mov edx, len3  ;user input       
   int 0x80

   ; moving the first number to eax register and second number to ebx
   ; and subtracting ascii '0' to convert it into a decimal number
;------------------------------------------------------------------------   
Addition:	      ;addition function
   mov eax, [num1]    ;value of num1 stored into eax
   sub eax, '0'       ;subtract 0 to convert from decimam to ASCII
	
   mov ebx, [num2]    ;value of num2 stored into eax
   sub ebx, '0'       ;subtract 0 to convert..
    add eax, ebx      ; add eax and ebx
   add eax, '0'       ; add '0' to to convert the sum from decimal to ASCII
   
  ; storing the sum in memory location res
   ;mov [res], eax
   mov  al,[res]
;-------------------------------------------------------------------
Subtraction:          ;subtraction function
   mov eax, [num1]    ;value of num1 stored into eax
   sub eax, '0'       ;add 0 to convert..
	
   mov ebx, [num2]    ;value of num2 stored into ebx
   sub ebx, '0'       ;add 0 to convert..

   ; sub eax and ebx
   sub eax, ebx
   ; add '0' to to convert the sum from decimal to ASCII
   add eax, '0'

   ; storing the sum in memory location res
   mov [res], eax
   ;mov  [res],ah
;-------------------------------------------
Printing:
   mov eax, 4       ;to write       
   mov ebx, 1       ;stdout
   mov ecx, res          
   mov edx, 1       ;stdout
   int 0x80         ;return contols to linux
   
exit:    
   
   mov eax, 1  
   xor ebx, ebx  ;clear register
   int 0x80
   
global _start  
   
_start:             ;entry point
        
	
	call Read
	
	mov esi,Lableoperator   ;moving variable to esi register
	
	mov al,Byte[esi]        ;printing the value thats into storage
	
	cmp al,"s"             ;if s
	
	call Read             ;call read func
	
	mov ax, "+"           ;storing +
	
	mov bx, "-"           ;storing -
	
	call Read
	call Numbers         ; calling Numbers
	
	cmp ax,"+"           ;if +
	
	je  Addition        ;calling addition
	
	
	
	cmp bx,"-"         ;if -    
	
	je Subtraction      ;call subtraction
	
	;call Subtraction
	
	
	call Printing        ;call printing
   
         call exit           ;call exit 
;_________________________________END OF THE PROGRAM_____________________________________
