{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT\
	CONCAT ('BB', age.Account, '00') as ExternalID,\
	CONCAT ('BB', age.Account, '00') as tranId,\
	CONCAT ('zzcirc ',age.Name) as customerRef,\
	'09/30/2013' AS tranDate,\
	'Sept 2013' AS PostingPeriod,\
	'1200' AS receivableAccountRef,\
	'Beginning Balance Import' AS memo,	\
	'BEGINNING BALANCE IMPORT CIRCULATION' AS itemLine_itemRef,\
	'1' AS itemLine_quantity,\
	age.period1 + age.period2 + age.period3 + age.period4 AS 'itemLine_salesPrice',\
	'Bangor' AS itemLine_locationRef\
FROM\
	Aging age}