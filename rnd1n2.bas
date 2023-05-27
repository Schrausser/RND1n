! /////////////////////////////////////////////////////////////////
! // Random Number Screen                                        //
! // Dietmar G. Schrausser, 2018-23
! //
_name$="RND1n"
_ver$="v2.5.3"
INCLUDE strg_.inc
CONSOLE.TITLE _name$
a=255
GR.OPEN a,a/2,a/2,a/2,0,1
zl=0:csw=1:rnsw=1
dlg:
IF rnsw=1: rnm$=smq$+"SIGMA":ELSE:rnm$=smq$+"System":ENDIF
ARRAY.LOAD rnm$[],rnm$,"Ok"
DIALOG.SELECT rnm,rnm$[], "Select Random Generator..."
SW.BEGIN rnm
 SW.CASE 1:rnsw=rnsw*-1:GOTO dlg:SW.BREAK
 SW.CASE 2:GOTO dlg0:SW.BREAK
SW.END
dlg0:
INPUT "Random Numbers n=...",nrn,3000
nrn=ABS(nrn):IF n<2|n>50000:n=50000:ENDIF
GR.CLOSE
st0:                                             % // start      //
__sd_=RND()                                      % // timeseed   //
IF csw=1: GR.OPEN a,30,80,30,0,-1
GR.COLOR a,30,a,30,1:ENDIF
IF csw=2: GR.OPEN a,0,0,0,0,-1
GR.COLOR a,a,a,a,1:ENDIF
IF csw=3: GR.OPEN a,a,a,a,0,-1
GR.COLOR a,0,0,0,1:ENDIF
IF csw=4: GR.OPEN a,a/2,a/2,a/2,0,-1
GR.COLOR a,a,a,a,1:ENDIF
IF csw=5: GR.OPEN a,20,10,0,0,-1
GR.COLOR a/6,a,a,240,1:ENDIF
IF csw=6: GR.OPEN a,80,30,30,0,-1
GR.COLOR a,a,30,30,1:ENDIF
DO                                               % // main       //
 GR.SCREEN h,w
 IF h<w:txz=h/40:ELSE:txz=w/40:ENDIF
 GR.TEXT.SIZE txz
 n=ROUND(RND()*1000)
 IF rnsw=1                                       % // rnd Sigma  //
  GOSUB rand:xn=(h+h/16)*nx-h/32
  GOSUB rand:yn=(w+w/16)*nx-w/32
 ENDIF
 IF rnsw=-1                                      % // rnd System //
  xn=(h+h/16)*RND()-h/32:yn=(w+w/16)*RND()-w/32
 ENDIF
 GR.TEXT.DRAW p,xn,yn,FORMAT$("####",n)
 IF zl=nrn:GR.CLS:zl=0:ENDIF
 GR.RENDER:zl=zl+1
 GR.TOUCH tc,tx,ty
 GR.TOUCH2 tc2,tx2,ty2
 IF tc: csw=csw+1
  IF csw=7:csw=1:ENDIF
 GR.CLOSE:GOTO st0:ENDIF
 IF tc2: GOSUB fin: END:ENDIF
UNTIL 0                                          % // main end   //
ONERROR: 
GOSUB fin: END
ONBACKKEY: 
GOSUB fin
END
rand::INCLUDE sigma.inc:nx=n__:RETURN
fin: 
PRINT _name$+" Random Number Screen "+_ver$
PRINT"Copyright "+_cr$+" 2023 by Dietmar Gerald Schrausser"
PRINT "https://github.com/Schrausser/RND1n"
RETURN
!// END //
!//
