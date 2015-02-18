create view sbdstats_ist.timestamp as
SELECT TimeSent,
		TimeReceived
FROM sbdstats_ist.dmt
WHERE TimeReceived > '2014-03-27 00:00:00'
ORDER BY TimeReceived DESC;

-- SELECT TimeReceived from sbdstats_ist.timestamp;