#Requirements: oci cli installed and available in PATH
#Documentation: https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/copyingobjects.htm 

export SBUCKET=bucket-velero
export DBUCKET=bucket-velero
export NAMESPACE=frsxwtjslf35
export D_REGION_ID=uk-london-1

# List all objects in source bucket and export list to text file
oci os object list --bucket-name=$SBUCKET --all | grep name | awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g' > objects.list;

# Bulk copy of all objects in text file to destination bucket in destination region:
for id in $(cat objects.list)
do oci os object copy --bucket-name $SBUCKET --source-object-name $id --destination-bucket $DBUCKET --namespace-name=$NAMESPACE  --destination-namespace=$NAMESPACE  --destination-region=$D_REGION_ID
done
