#!/bin/bash

# Цвета
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}=== Настройка Gradle Build ===${NC}"
read -p "Что имитируем? (1-Успех, 2-Ошибка, 3-Ворнинги): " MODE
read -p "Сколько секунд будет идти «сборка»? (напр. 5): " DURATION

echo -e "\n${BLUE}Starting Gradle Daemon...${NC}"
sleep 1

# Рассчитываем задержку между тасками
tasks=(":compileJava" ":processResources" ":classes" ":jar" ":assemble")
delay=$(echo "scale=2; $DURATION / ${#tasks[@]}" | bc)

for i in "${!tasks[@]}"; do
    task=${tasks[$i]}
    echo -e "> Task ${GREEN}$task${NC}"
    sleep $delay

    # Если выбрали ворнинги (3) на этапе компиляции
    if [[ "$MODE" == "3" && "$task" == ":compileJava" ]]; then
        echo -e "${YELLOW}warning: [deprecation] stop() in Thread has been deprecated${NC}"
        echo -e "${YELLOW}warning: [unchecked] unchecked cast to java.util.List<java.lang.String>${NC}"
    fi

    # Если выбрана ошибка (2) на полпути
    if [[ "$MODE" == "2" && $i -eq 2 ]]; then
        echo -e "\n${RED}FAILED${NC}"
        echo -e "${RED}Error: Command failed with exit code 1: ./javac src/Main.java${NC}"
        echo -e "${RED}src/Main.java:12: error: ';' expected${NC}"
        echo -e "\n${RED}BUILD FAILED${NC} in ${DURATION}s"
        exit 1
    fi
done

# Финал для успешных сценариев
echo -e "\n${GREEN}BUILD SUCCESSFUL${NC} in ${DURATION}s"
echo -e "${#tasks[@]} actionable tasks: ${#tasks[@]} executed"
