{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 Calibri;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT \
	CONCAT( `VoucherMD`, `VoucherCT`, `VoucherYear`, `SequenceNumber` , 'P') AS ExternalID,\
	`CheckNumber` as tranId,\
	'
\f1\b\fs22 1015 Cash, Checking - Peoples
\f0\b0\fs24 ' AS payableAccountRef,\
	vendors.Name as name,\
	DATE_FORMAT( CONCAT( PayCt, PayYear, LPAD( PayMMDD, 4, 0 ) ), '%m/%d/%Y' ) as tranDate,\
	DATE_FORMAT( CONCAT( PayCt, PayYear, LPAD( PayMMDD, 4, 0 ) ),'%b %Y' ) as postingPeriodRef,\
	`InvRef` AS memo,\
	CONCAT( `VoucherMD`, `VoucherCT`, `VoucherYear`, `SequenceNumber`) AS applyLine1_tranIdRef,\
	`InvAmount` AS applyLine1_paymentAmount\
FROM \
	ACPPAID_copy paid,\
	VendorsNS vendors\
WHERE\
	paid.VendorNumber = vendors.ExternalId}