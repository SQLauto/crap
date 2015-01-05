{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT\
	CONCAT (ara.AddressNumber,ara.AInsMonth,ara.AInsDay) AS ExternalID,\
	CONCAT (ara.AddressNumber,ara.AInsMonth,ara.AInsDay) as tranId,\
	cus.Name AS customerRef,\
	CURDATE() tranDate,\
	'Pending Fulfillment' AS orderstatus,\
CASE WHEN \
	ara.AddressNumber LIKE '5%' THEN 'ADS : AdPerfect' ELSE ' ADS : Retail Ads' END As classRef,\
	rep.salesrep AS salesRepRef,\
CASE WHEN\
	ara.AddressNumber LIKE '5%' THEN 'Classified Print Import' WHEN  ara.AddressNumber LIKE '8%' THEN 'Weekly Print Import' ELSE 'Retail Print Import' END As itemLine_itemRef,\
	'1' AS itemLine_quantity,\
	'0' AS itemLine_salesPrice\
FROM\
	ARADOR_copy ara,\
	customers_copy cus,\
	salesrep_copy rep\
WHERE\
	ara.AAccountNumber = cus.ExternalID\
AND\
	rep.ASMNO = ara.ASMNo}