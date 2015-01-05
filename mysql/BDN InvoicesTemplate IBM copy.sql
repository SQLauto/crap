{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT\
	CONCAT ('BB', act.AccountNumber, act.TransactionAge) AS ExternalID,\
	CONCAT ('BB', act.AccountNumber, act.TransactionAge) AS tranId,\
	cus.Name AS customerRef,\
CASE WHEN \
	act.TransactionAge LIKE '00' THEN '9/30/2013' WHEN act.TransactionAge LIKE '30' THEN '8/31/2013' WHEN act.TransactionAge LIKE '60' THEN '7/31/2013' ELSE '6/30/2013' END As classRef,\
CASE WHEN \
	act.TransactionAge LIKE '00' THEN 'Sep 2013' WHEN act.TransactionAge LIKE '30' THEN 'Aug 2013' WHEN act.TransactionAge LIKE '60' THEN 'Jul 2013' ELSE 'Jun 2013' END As postingPeriodRef,\
	'1200 Accounts Receivable' AS receivableAccountRef,\
	'ADS' AS classRef,\
	'Beginning Balance Import' AS memo,\
	'BEGINNING BALANCE IMPORT ADVERTISING' AS itemLine_itemRef,\
	'1' AS itemLine_quantity,\
	act.PaymentAmount AS itemLine_salesPrice,\
	'Bangor' AS itemLine_locationRef\
FROM\
	ACTBALNS_copy act,\
	customers_copy cus\
WHERE\
	act.AccountNumber = cus.ExternalID}