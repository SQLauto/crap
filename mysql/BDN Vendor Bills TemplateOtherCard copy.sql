{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh5860\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT \
	CONCAT( acp.VoucherMD, acp.VoucherCT, acp.VoucherYear, acp.SequenceNumber ) AS ExternalID,\
	CONCAT( chart.accountRef, ' ', chart.Title ) AS purchaseExpenseLine_accountRef,\
	acp.DistAmt AS purchaseExpenseLine_amount,\
	acp.DistRef AS purchaseExpenseLine_memo,\
	chart.Department AS purchaseExpenseLine_departmentRef,\
	'Bangor' AS purchaseExpenseLine_locationRef\
FROM \
	ACPINV_copy acp,\
	ChartOfActs chart\
WHERE \
	chart.IBMAccountNumber = acp.GLNo\
AND \
	acp.CardCode <> 1}