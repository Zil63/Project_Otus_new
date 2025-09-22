#!/bin/bash
# Health check script for automatic recovery

SERVICES=("nginx" "python_app" "wordpress" "database" "prometheus" "grafana")
MAX_RETRIES=3
RETRY_DELAY=10

check_service() {
    local service=$1
    local retries=0
    
    while [ $retries -lt $MAX_RETRIES ]; do
        if docker inspect -f '{{.State.Status}}' "$service" 2>/dev/null | grep -q "running"; then
            echo "✓ $service is running"
            return 0
        fi
        
        echo "⚠ $service is down (attempt $((retries+1))/$MAX_RETRIES)"
        retries=$((retries+1))
        sleep $RETRY_DELAY
    done
    
    echo "✗ $service failed to start after $MAX_RETRIES attempts"
    return 1
}

# Main health check
for service in "${SERVICES[@]}"; do
    if ! check_service "$service"; then
        echo "Initiating recovery for $service..."
        ansible-playbook emergency-recovery.yml -i hosts --tags "${service%%_*}" -v
    fi
done