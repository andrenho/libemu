; '2600 for Newbies
; Session 15 - Playfield Continued
; This kernel draws a simple box around the screen border
; Introduces playfield reflection 

               processor 6502
               include "vcs.h"
               include "macro.h"
;------------------------------------------------------------------------------

               SEG
               ORG $F000

Reset

  ; Clear RAM and all TIA registers

               ldx #0 
               lda #0 
Clear           sta 0,x 
              inx 
               bne Clear



      ;------------------------------------------------

      ; Once-only initialisation...

               lda #$45
               sta COLUPF             ; set the playfield colour

               lda #%00000001
               sta CTRLPF             ; reflect playfield

      ;------------------------------------------------



StartOfFrame

   

  ; Start of new frame

  ; Start of vertical blank processing

   

               lda #%00000000

               sta CTRLPF    ; copy playfield



               

               lda #$AE

               sta COLUBK   ; set the background color (sky)





               lda #0

               sta VBLANK

   

               lda #2

               sta VSYNC

   

               sta WSYNC

               sta WSYNC

               sta WSYNC   ; 3 scanlines of VSYNC signal

   

               lda #0

               sta VSYNC



      ;------------------------------------------------------------------

      ; 37 scanlines of vertical blank...

           

               ldx #0

VerticalBlank

               sta WSYNC

               inx

               cpx #37

               bne VerticalBlank

           

      ;------------------------------------------------------------------

      ; Do 192 scanlines of color-changing (our picture)

       

               ldx #0   ; this counts our scanline number
;--------------------------------------------------------------------------



TopSkyLines

               sta WSYNC

               lda #$0A

               sta COLUPF    ; set playfield color (cloud)

               

               lda #%11100000

               sta PF0       ; write graphics for PF0(a) - cloud

               lda #%11000000

               sta PF1       ; write graphics for PF1(a) - cloud

               lda #0

               sta PF2       ; zero out graphics for PF2(a)



               SLEEP 12



               lda #0

               sta PF0

               

               SLEEP 8



               lda #0

               sta PF1

               lda #$1E

               sta COLUPF   ; set playfield color (sun)

                               

               nop

               lda #%01100000

               sta PF2

               

               inx

               cpx #4          ; are we at line 4?

               bne TopSkyLines   ; No, so do another




;--------------------------------------------------------------------------                    



MidSkyLines

               sta WSYNC

               lda #$0A

               sta COLUPF    ; set playfield color (cloud)

               

               lda #%11110000

               sta PF0

               lda #%11100000

               sta PF1

               lda #0

               sta PF2



               SLEEP 12



               lda #0

               sta PF0

               

               SLEEP 8



               lda #0

               sta PF1

               lda #$1E

               sta COLUPF   ; set playfield color (sun)

                               

               nop

               lda #%11110000

               sta PF2

               

               inx

               cpx #14          ; are we at line 14?

               bne MidSkyLines   ; No, so do another




;--------------------------------------------------------------------------

LastSkyLines

               sta WSYNC

               lda #$0A

               sta COLUPF    ; set playfield color (cloud)

               

               lda #%01100000

               sta PF0

               lda #%11000000

               sta PF1

               lda #0

               sta PF2



               SLEEP 12



               lda #0

               sta PF0

               

               SLEEP 8



               lda #0

               sta PF1

               lda #$1E

               sta COLUPF   ; set playfield color (sun)

                               

               nop

               lda #%01100000

               sta PF2

               

               inx

               cpx #18          ; are we at line 18?

               bne LastSkyLines   ; No, so do another

                               
;--------------------------------------------------------------------------

                   

               lda #0   ; PF0 is mirrored <--- direction, low

                                ; 4 bits ignored

               sta PF0

               sta PF1

               sta PF2

                                                   

MiddleLines

               sta WSYNC

               inx

               cpx #140

               bne MiddleLines

                                   

               sta WSYNC

               lda #$C6

               sta COLUPF   ; set playfield color (tree leaves)

               

               SLEEP 50



               lda #%00010000

               sta PF2   ; set graphics for right side leaves

               

               inx


;--------------------------------------------------------------------------



Leaf1stLines

               sta WSYNC

               lda #0

               sta PF2   ; clear left side

               

               SLEEP 50



               lda #%00010000

               sta PF2   ; write graphics for PF2(b) - right side leaves

               

               inx

               cpx #149          ; are we at line 149?

               bne Leaf1stLines   ; No, so do another
;--------------------------------------------------------------------------

Leaf2ndLines

               sta WSYNC

               

               lda #%10000000

               sta PF0       ; write graphics for PF0(a) - left side tree leaves

               lda #0

               sta PF1       ; zero out graphics for PF1(a and b)

               sta PF2       ; zero out graphics for PF2(a)



               SLEEP 18



               lda #0

               sta PF0   ; zero out graphics for PF0(b)

               

               SLEEP 18



               lda #%00111000

               sta PF2   ; write graphics for PF2(b) - right side tree leaves

               

               inx

               cpx #152          ; are we at line 152?

               bne Leaf2ndLines   ; No, so do another


;--------------------------------------------------------------------------



Leaf3rdLines

               sta WSYNC

               

               lda #%11000000

               sta PF0       ; write graphics for PF0(a) - left side tree leaves

               lda #%10000000

               sta PF1       ; write graphics for PF1(a) - left side tree leaves

               lda #0

               sta PF2       ; zero out graphics for PF2(a)



               SLEEP 16



               lda #0

               sta PF0   ; zero out graphics for PF0(b)

               

               SLEEP 8



               lda #0

               sta PF1   ; zero out graphics for PF1(b)

                               

               SLEEP 6



               lda #%00111000

               sta PF2   ; write graphics for PF2(b) - right side tree leaves

               

               inx

               cpx #156          ; are we at line 156?

               bne Leaf3rdLines   ; No, so do another




;--------------------------------------------------------------------------

Leaf4thLines

               sta WSYNC

               

               lda #%11100000

               sta PF0       ; write graphics for PF0(a) - left side tree leaves

               lda #%11000000

               sta PF1       ; write graphics for PF1(a) - left side tree leaves

               lda #0

               sta PF2       ; zero out graphics for PF2(a)



               SLEEP 16



               lda #0

               sta PF0   ; zero out graphics for PF0(b)

               

               SLEEP 8



               lda #0

               sta PF1   ; zero out graphics for PF1(b)

                               

               SLEEP 6



               lda #%00111000

               sta PF2   ; write graphics for PF2(b) - right side tree leaves

               

               inx

               cpx #158          ; are we at line 158?

               bne Leaf4thLines   ; No, so do another




;--------------------------------------------------------------------------

LastLeafLines

               sta WSYNC

               

               lda #%11100000

               sta PF0       ; write graphics for PF0(a) - left side tree leaves

               lda #%11000000

               sta PF1       ; write graphics for PF1(a) - left side tree leaves

               lda #0

               sta PF2       ; zero out graphics for PF2(a)



               SLEEP 16



               lda #0

               sta PF0   ; zero out graphics for PF0(b)

               

               SLEEP 8



               lda #0

               sta PF1   ; zero out graphics for PF1(b)

                               

               SLEEP 6



               lda #%01111100

               sta PF2   ; write graphics for PF2(b) - right side tree leaves

               

               inx

               cpx #164          ; are we at line 164?

               bne LastLeafLines   ; No, so do another




;--------------------------------------------------------------------------



               lda #%00000001

               sta CTRLPF    ; reflect playfield

               lda #0

               sta PF2   ; zero out graphics for PF2(a and b)

               lda #$20

               sta COLUPF    ; set playfield color (tree trunk)

               lda #%10000000

               sta PF0





               

                   
;--------------------------------------------------------------------------



TreeTrunkLines

               sta WSYNC

               

               inx

               cpx #182          ; are we at line 182?

               bne TreeTrunkLines   ; No, so do another


;--------------------------------------------------------------------------

                   

               lda #$DA

               sta COLUPF   ; set playfield color (grass)

               

               lda #$98

               sta COLUBK   ; set background color (water)



               lda #%11111111

               sta PF0   ; fill in graphics for PF0 (a and b)

               sta PF1   ; fill in graphics for PF1 (a and b)

               lda #%00000111

               sta PF2   ; set graphics for first line of pond





               
;--------------------------------------------------------------------------
; Pond Lines Follow: 

               

               sta WSYNC

               inx

               lda #%00001111

               sta PF2   ; set graphics for second line of pond

               

               sta WSYNC

               inx

               lda #%00011111

               sta PF2   ; set graphics for third line of pond

               

               sta WSYNC

               inx

               lda #%11111111

               sta PF2   ; fill in graphics for PF2 (a and b) - grass
;--------------------------------------------------------------------------

               

               

               

Bottom6Lines

               sta WSYNC

               inx

               cpx #192

               bne Bottom6Lines

           

      ;--------------------------------------------------------------------------

           

               lda #%01000010

               sta VBLANK   ; end of screen - enter blanking

           

      ; 30 scanlines of overscan...

       

               ldx #0

Overscan

               sta WSYNC

               inx

               cpx #30

               bne Overscan

           

               jmp StartOfFrame




;------------------------------------------------------------------------------



           ORG $FFFA



InterruptVectors



           .word Reset          ; NMI

           .word Reset          ; RESET

           .word Reset          ; IRQ



     END

