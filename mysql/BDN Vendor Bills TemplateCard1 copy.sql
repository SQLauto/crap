{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8840\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT \
	CONCAT( acp.VoucherMD, acp.VoucherCT, acp.VoucherYear, acp.SequenceNumber) AS ExternalID,\
CASE WHEN\
	acp.InvNo = '' THEN CONCAT( acp.VoucherMD, acp.VoucherCT, acp.VoucherYear, acp.SequenceNumber ) ELSE acp.InvNo END AS referNAMenceId,\
	DATE_FORMAT( realdate,'%b %Y' ) AS postingPeriodRef,\
	vendors.Name AS name,\
	DATE_FORMAT( realdate , '%m/%d/%Y' ) AS tranDate,\
	'2010 Accounts Payable' AS payableAccountsRef,\
	'Net 30' AS termsRef\
FROM \
	ACPINV_copy acp,\
	VendorsNS_copy vendors\
WHERE\
	acp.VendNumber = vendors.ExternalId\
AND\
	acp.CardCode = 1}