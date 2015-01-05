#!/bin/bash
startDate=`date`

echo "*** Creating Mongo Export"
/usr/bin/mysql -umls_admin -penjoy+buffalo\!bean%fell -htbdb.homesmartagent.com --skip-column-names MLS_${RETSUNAME} -e "select CONCAT('{tid:',TERABITZ_ID,' , loc:[',LATITUDE,',',LONGITUDE,']}') from view_homesmart_solr" > /var/data/mlsdata/$RETSUNAME.json

else
        echo Skipping splitting, file does not exist
        echo Check logs files
        echo "   /var/data/tools/mls/logs/${RETSUNAME}_Client_out.log"
        echo "   /var/data/tools/mls/logs/${RETSUNAME}_2tnf_out.log"
fi

endDate=`date`