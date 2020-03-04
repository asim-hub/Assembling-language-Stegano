%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

bruteforce_singlebyte_xor:
    push ebp
    mov ebp,esp
    mov ebx,-1;cheie
    mov ecx,0;index
newkey:
    inc ebx
    cmp ebx,255
    jg final
    ;mov ebx,48
    ;inceputul matricei
    mov eax,[ebp+8]
    mov eax,[eax]
    mov ecx,0
mesaj:
    ;aplic cheia pe matrice
    mov edx,[eax + 4*ecx]
    xor edx,ebx
    mov [eax +4*ecx],edx
    inc ecx
    mov edx,[ebp+12];aici e nr de elem din vector
    cmp ecx,edx
    jl mesaj
    ;verific daca se gaseste mesajul cautat,pot folosi edx,ecx
    xor eax,eax
    mov eax,[ebp+8]
    mov eax,[eax]
    xor ecx,ecx
    mov ecx,-1
repeta:
    inc ecx
    mov edx,[ebp+12];dim mat
    cmp dword ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'r'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'e'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'v'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'i'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'e'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'n'
    jne repeta
    inc ecx
    cmp ecx,edx;nu am ajuns la sfarsit
    jge restaurare
    cmp dword [eax+4*ecx],'t'
    jne repeta
    xor esi,esi;aici pun lungimea liniei
    mov esi,[img_width]
    xor edx,edx;deimpartit
    xor eax,eax;deimpartit
    mov eax,ecx;impartitor
    idiv esi
    jmp final
    
restaurare:
    xor eax,eax
    mov eax,[ebp+8]
    mov eax,[eax]
    mov ecx,0
eticheta:
    mov edx,[eax + 4*ecx]
    xor edx,ebx
    mov [eax +4*ecx],edx  
    inc ecx 
    cmp ecx,[ebp+12]
    jl eticheta             
    jmp newkey             
final:                 
    leave
    ret
    
overwrite:
    push ebp
    mov ebp,esp
    mov eax,[ebp+16];cheia
    mov ebx,[ebp+12];linia
    ;new key
    imul eax,2
    add eax,3
    xor edx,edx
    xor esi,esi
    mov esi,5
    idiv esi
    add eax,-4
    ;imaginea
    xor ecx,ecx
    mov ecx,[ebp+8]
    mov ecx,[ecx]
    ;index pozitie de unde suprascriu
    inc ebx
    imul ebx,[img_width] 
    mov byte [ecx+4*ebx],'C'
    inc ebx
    mov byte [ecx+4*ebx],"'"
    inc ebx
    mov byte [ecx+4*ebx],'e'
    inc ebx
    mov byte [ecx+4*ebx],'s'
    inc ebx
    mov byte [ecx+4*ebx],'t'
    inc ebx
    mov byte [ecx+4*ebx],' '
    inc ebx
    mov byte [ecx+4*ebx],'u'
    inc ebx
    mov byte [ecx+4*ebx],'n'
    inc ebx
    mov byte [ecx+4*ebx],' '
    inc ebx
    mov byte [ecx+4*ebx],'p'
    inc ebx
    mov byte [ecx+4*ebx],'r'
    inc ebx
    mov byte [ecx+4*ebx],'o'
    inc ebx
    mov byte [ecx+4*ebx],'v'
    inc ebx
    mov byte [ecx+4*ebx],'e'
    inc ebx
    mov byte [ecx+4*ebx],'r'
    inc ebx
    mov byte [ecx+4*ebx],'b'
    inc ebx
    mov byte [ecx+4*ebx],'e'
    inc ebx
    mov byte [ecx+4*ebx],' '
    inc ebx
    mov byte [ecx+4*ebx],'f'
    inc ebx
    mov byte [ecx+4*ebx],'r'
    inc ebx
    mov byte [ecx+4*ebx],'a'
    inc ebx
    mov byte [ecx+4*ebx],'n'
    inc ebx
    mov byte [ecx+4*ebx],'c'
    inc ebx
    mov byte [ecx+4*ebx],'a'
    inc ebx
    mov byte [ecx+4*ebx],'i'
    inc ebx
    mov byte [ecx+4*ebx],'s'
    inc ebx
    mov byte [ecx+4*ebx],'.'
    inc ebx
    mov byte [ecx+4*ebx],0
    ;aplic cheia pe toata matricea
    ;registre ocupate:ecx-matricea,eax-cheia
    xor ebx,ebx;dimensiune vector
    mov dword ebx,[img_height]
    imul ebx,[img_width]
    xor edx,edx;index matrice
    
    matrice:
    mov esi,[ecx + 4*edx]
    xor esi,eax
    mov [ecx +4*edx],esi
    inc edx
    cmp edx,ebx
    jl matrice

    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp,12
    
    leave
    ret
    
morse_encrypt:
    push ebp
    mov ebp,esp
    mov eax,[esp+8]
    mov eax,[eax];img
    mov ebx,[esp+12];mesaj
    mov edx,[esp+16];index
    xor ecx,ecx;index petru mesaj
    re:
    cmp byte [ebx+ecx],'A'
    jne next1
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next1:
    cmp byte [ebx+ecx],'B'
    jne next2
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next2:
    cmp byte [ebx+ecx],'C'
    jne next3
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next3:
    cmp byte [ebx+ecx],'D'
    jne next4
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next4:
    cmp byte [ebx+ecx],'E'
    jne next5
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next5:
    cmp byte [ebx+ecx],'F'
    jne next6
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next6:
    cmp byte [ebx+ecx],'G'
    jne next7
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next7:
    cmp byte [ebx+ecx],'H'
    jne next8
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next8:
    cmp byte [ebx+ecx],'I'
    jne next9
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next9:
    cmp byte [ebx+ecx],'J'
    jne next10
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next10:
    cmp byte [ebx+ecx],'K'
    jne next11
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next11:
    cmp byte [ebx+ecx],'L'
    jne next12
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx  
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next12:
    cmp byte [ebx+ecx],'M'
    jne next13  
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next13:
    cmp byte [ebx+ecx],'N'
    jne next14
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next14:
    cmp byte [ebx+ecx],'O'
    jne next15
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next15:
    cmp byte [ebx+ecx],'P'
    jne next16
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next16:
    cmp byte [ebx+ecx],'Q'
    jne next17
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next17:
    cmp byte [ebx+ecx],'R'
    jne next18
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next18:
    cmp byte [ebx+ecx],'S'
    jne next19
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next19:
    cmp byte [ebx+ecx],'T'
    jne next20
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next20:
    cmp byte [ebx+ecx],'U'
    jne next21
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next21:
    cmp byte [ebx+ecx],'V'
    jne next22
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next22:
    cmp byte [ebx+ecx],'W'
    jne next23
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next23:
    cmp byte [ebx+ecx],'X'
    jne next24
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next24:
    cmp byte [ebx+ecx],'Y'
    jne next25
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next25:
    cmp byte [ebx+ecx],'Z'
    jne next26
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next26:
    cmp byte [ebx+ecx],'1'
    jne next27
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next27:
    cmp byte [ebx+ecx],'2'
    jne next28
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next28:
    cmp byte [ebx+ecx],'3'
    jne next29
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next29:
    cmp byte [ebx+ecx],'4'
    jne next30
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next30:
    cmp byte [ebx+ecx],'5'
    jne next31
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next31:
    cmp byte [ebx+ecx],'6'
    jne next32
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next32:
    cmp byte [ebx+ecx],'7'
    jne next33
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next33:
    cmp byte [ebx+ecx],'8'
    jne next34
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next34:
    cmp byte [ebx+ecx],'9'
    jne next35
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next35:
    cmp byte [ebx+ecx],'0'
    jne next36
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
next36:   
    cmp byte [ebx+ecx],','
    jne next37
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'.'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],'-'
    inc edx
    mov byte [eax+4*edx],' '
    inc edx
    mov byte [eax+4*edx],' '
next37:
    ;aici verific daca nu am ajuns la final
    inc ecx
    cmp byte [ebx+ecx],0
    jne re
    dec edx
    mov byte [eax+4*edx],0
    ;afisez matricea 
    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp,12
    
    leave
    ret  
    
lsb_encode:
    push ebp
    mov ebp,esp
    mov eax,[esp+8]
    mov eax,[eax];img
    mov ebx,[esp+12];mesaj
    mov edi,[esp+16];index
    dec edi
    xor esi,esi
    xor ecx,ecx
    xor edx,edx
    
mask:    
    mov dl,128
    mov cl,128
lsb:
    and byte dl,[ebx+esi]
    cmp dl,cl
    jne zero
    or dword [eax +4*edi],1
    jmp next
zero:
    and dword[eax +4*edi],4294967294
next:
    inc edi
    ;shift la dreapta masca esi
    shr cl,1
    mov dl,cl
    cmp byte cl,0
    jg lsb
    inc esi
    cmp byte [ebx+esi],0
    jne mask
    
    xor ecx,ecx
    mov ecx,edi
    add ecx,8
endbyte:    
    and dword[eax +4*edi],4294967294
    inc edi
    cmp edi,ecx
    jl endbyte
    
    ;afisez matricea
    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp,12
    leave
    ret  

solve_task1:
    ;TODO Task1
    mov dword eax,[img_height]
    imul eax,[img_width]
    push eax
    push img
    call bruteforce_singlebyte_xor
    add esp,8
    xor esi,esi
    mov ecx,[img]
    mov edx,eax
    imul edx,[img_width]
    mov esi,edx
    add esi,[img_width]
afisare:
    cmp dword [ecx+4*edx],0
    je fin
    PRINT_CHAR [ecx+4*edx]
    inc edx 
    cmp edx,esi
    jl afisare
fin:
    NEWLINE
    PRINT_DEC 2,ebx
    NEWLINE
    PRINT_DEC 4,eax
    NEWLINE
    jmp done
    
solve_task2:
    ; TODO Task2
    mov dword eax,[img_height]
    imul eax,[img_width]
    push eax
    push img
    call bruteforce_singlebyte_xor
    add esp,8
    ;interschimb eax cu ebx
    push eax
    push ebx
    pop eax;key
    pop ebx;linia
    push eax
    push ebx
    push img
    call overwrite
    add esp,12
    jmp done
    
solve_task3:
    ; TODO Task3
    ;index
    mov ecx,[ebp+12]
    mov eax,[ecx+16]
    push dword eax
    call atoi
    add esp,4
    push eax
    xor ecx,ecx
    xor eax,eax
    mov ecx,[ebp+12]
    mov eax,[ecx+12]
    push eax
    push img
    call morse_encrypt
    add esp,12
    jmp done
solve_task4:
    ; TODO Task4
     mov ecx,[ebp+12]
    mov eax,[ecx+16]
    push dword eax
    call atoi
    add esp,4
    push eax;index
    xor ecx,ecx
    xor eax,eax
    mov ecx,[ebp+12]
    mov eax,[ecx+12]
    push eax;mesaj
    push img
    call lsb_encode
    add esp,12
    jmp done
    
solve_task5:
    ; TODO Task5
    jmp done
solve_task6:
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
 