SET PATH TO f:\sueldos\empre2
SET DELETED ON
liquida = "112018"
SELECT legajo as chapa,this.nombrep() as nombre ,this.contrato() as contrato, this.seccion()as seccion,this.banc() as banco,this.cuentabanc() as cuenta ,this.cuil() as cuil,SUM(aporte + sinaporte -descuento)as sntecob,SUM(valoruni)as pagdo,SUM(IIF(CONCEPTO = 99,DESCUENTO,0.00))as sadel,;
   SUM(IIF(CONCEPTO=130 .OR. CONCEPTO = 654 ,DESCUENTO,0.00))as snacion,SUM(IIF(CONCEPTO =123,DESCUENTO,0.00))as smutual,this.contribucion() as Contrb,this.contribsindical() as ContrSind,;
   SUM(IIF(CONCEPTO = 126.OR.CONCEPTO = 127 .OR. CONCEPTO = 142 .OR. CONCEPTO = 150 .OR. CONCEPTO = 153 .OR. CONCEPTO=875,DESCUENTO,0.00))AS embargo,SUM(IIF(CONCEPTO =10000,APORTE,0.00)) as sneto,;
   this.totsu() as totalsu,this.tarjeta() as tarjeta,SUM(APORTE) as sbruto,SUM(SINAPORTE) as sviatico,SUM(IIF(CONCEPTO =1,aporte,0.00))as basico,SUM(IIF(CONCEPTO =80 .or. concepto = 81 .or.concepto=82 .or. concepto =83 .or. concepto = 84 .or. concepto=86 .or.concepto=87;
   .or. concepto= 131 .or. concepto=800 .or. concepto=810.or. concepto=820.or. concepto=830.or. concepto=840.or. concepto=850.or. concepto=851.or. concepto=870,descuento,0.00))as descuento;
   FROM liquida group BY liquida,legajo INTO CURSOR SUE3 READWRITE