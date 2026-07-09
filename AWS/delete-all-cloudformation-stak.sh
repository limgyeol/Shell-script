STACKS=$(aws cloudformation list-stacks \
  --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE ROLLBACK_COMPLETE \
    CREATE_FAILED DELETE_FAILED UPDATE_ROLLBACK_COMPLETE UPDATE_ROLLBACK_FAILED \
  --query "StackSummaries[].StackName" --output text)

for STACK in $STACKS; do
  echo "삭제 진행: $STACK"

  aws cloudformation update-termination-protection \
    --stack-name "$STACK" \
    --no-enable-termination-protection

  aws cloudformation delete-stack --stack-name "$STACK"
done 