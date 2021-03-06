#!/bin/bash

cmd=$1

case "$cmd" in

    # Development
    --ui-dev)
        cd ./ui && npm run serve
        ;;

    --api-dev)
        go run main.go
        ;;

    --dev)
        cd ./ui && npm run build && cd .. && GIN_MODE=debug go run main.go
        ;;

    # Build
    --build-ui)
        cd ./ui && npm run build
        ;;

    --build-amd64)
        env GOOS=linux GOARCH=amd64 go build -o pods_amd64.out
        ;;

    --build)
        cd ./ui && npm run build && cd .. && go build -o pods.out
        ;;

    # Deploy
    --release)
        ./repository/db.sh --rm && ./repository/db.sh --up && GIN_MODE=release ./pods.out
        ;;

    # Unexpected
    *)
        echo "Unknown command '$cmd'"
        exit 1
        ;;

esac
