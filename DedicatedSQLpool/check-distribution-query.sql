SELECT  
    tb.Name
    ,tb.object_id
    ,np.pdw_node_id
	,np.distribution_id
	,np.index_id
	,np.partition_number
	,np.rows
	,distribution_policy_desc
FROM
	     sys.schemas as sm
	join sys.tables	as tb								                on sm.schema_id			    =      tb.schema_id							
	join sys.pdw_table_distribution_properties as dp    on tb.object_id			    =      dp.object_id
	join sys.pdw_table_mappings as mp				            on tb.object_id			    =      mp.object_id
	join sys.pdw_nodes_tables as nt						          on nt.name				      =      mp.physical_name
	join sys.pdw_nodes_partitions as np				          on np.object_id  		    =      nt.object_id
														                          and np.pdw_node_id	    =      nt.pdw_node_id
														                          and np.distribution_id	=      nt.distribution_id 
WHERE tb.Name = 'Dimcity' --table name
ORDER BY distribution_id
