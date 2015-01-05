{\rtf1\ansi\ansicpg1252\cocoartf1265
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 SELECT\
            '' as tranId,\
            DATE_FORMAT( g.realdate,'%b %Y' ) as postingperiod,\
            DATE_FORMAT( g.realdate , '%m/%d/%Y' ) as tranDate,\
            Chart.accountRef as journalItemLine_accountRef,\
            g.DistAmt as journalItemLine_debitAmount,\
            g.DistRef as journalItemLine_memo,\
            Chart.Department as journalItemLine_departmentRef,\
            Chart.Location as journalItemLine_locationRef\
    FROM\
            `GENTRN_copy` g,\
            ChartOfActs Chart\
    WHERE\
            Chart.IBMAccountNumber = g.GLNumber\
#    GROUP BY\
#           g.GLMonth,\
#         Chart.accountRef,\
#            Chart.Department}