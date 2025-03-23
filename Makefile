# python_piscine/Makefile

.PHONY: help build 00 01 02 03 04 05 06 07 08 09 check clean fclean

# Set default target to help
.DEFAULT_GOAL := help

# ========================================<<< VARIABLES >>>========================================

# Image name for the Docker build
IMAGE_NAME = python-piscine

# Base Docker run command with automatic container removal
DOCKER_RUN = docker run --rm

# Docker run command with automatic container removal and interactive terminal for user input
DOCKER_RUN_IT = docker run --rm -it

# Colors for terminal output
GREEN := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RED := $(shell tput -Txterm setaf 5)
BLUE := $(shell tput -Txterm setaf 6)
RESET := $(shell tput -Txterm sgr0)

# ========================================<<< COMMANDS >>>========================================

# Show available commands
help:
	@echo "  $(GREEN)AVAILABLE COMMANDS:$(RESET)"
	@echo "  $(YELLOW)make 00$(RESET)        - Run exercise 00 (Hello greetings)"
	@echo "  $(YELLOW)make 01$(RESET)        - Run exercise 01 (Time formatting)"
	@echo "  $(YELLOW)make 02$(RESET)        - Run exercise 02 (Type identification)"
	@echo "  $(YELLOW)make 03$(RESET)        - Run exercise 03 (Null-like checks)"
	@echo "  $(YELLOW)make 04$(RESET)        - Run exercise 04 (Odd/Even check, use ARG=<number>)"
	@echo "  $(YELLOW)make 05$(RESET)        - Run exercise 05 (Character count, use ARG=<text> or interactive)"
	@echo "  $(YELLOW)make 06$(RESET)        - Run exercise 06 (String filter, use ARG=\"text length\")"
	@echo "  $(YELLOW)make 07$(RESET)        - Run exercise 07 (Morse code, use ARG=<text>)"
	@echo "  $(YELLOW)make 08$(RESET)        - Run exercise 08 (Progress bar)"
	@echo "  $(YELLOW)make 09$(RESET)        - Run exercise 09 (Install and test package)"
	@echo ""
	@echo "  $(YELLOW)make clean$(RESET)     - Remove the project image"
	@echo "  $(YELLOW)make fclean$(RESET)    - Remove all unused Docker resources"
	@echo "  $(YELLOW)make build$(RESET)     - Build the Docker image (automatically)"

# Build the Docker image from Dockerfile only if it doesn't exist
build:
	@docker images -q $(IMAGE_NAME) | grep -q . && \
	echo "$(YELLOW)Image $(IMAGE_NAME) already exists. Launch container!!!$(RESET)" || \
	(echo "$(BLUE)Building image for Python 3.10...$(RESET)" && \
		docker build -q -t $(IMAGE_NAME) . > /dev/null 2>&1 && \
		echo "$(BLUE)Image $(IMAGE_NAME) successfully built$(RESET)")
	@echo ""

# RUN EXERSICES:
00: build
	@echo "$(GREEN)Running: python ex00/Hello.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex00/Hello.py | cat -e

01: build
	@echo "$(GREEN)Running: python ex01/format_ft_time.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex01/format_ft_time.py | cat -e

02: build
	@echo "$(GREEN)Running: python ex02/tester.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex02/tester.py | cat -e
	@echo ""
	@echo "$(GREEN)Running: python ex02/find_ft_type.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex02/find_ft_type.py | cat -e

03: build
	@echo "$(GREEN)Running: python ex03/tester.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex03/tester.py | cat -e
	@echo ""
	@echo "$(GREEN)Running: python ex03/NULL_not_found.py | cat -e$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex03/NULL_not_found.py | cat -e

# Accepts ARG for command-line argument
04: build
	@echo "$(GREEN)Running ex04 with ARG=$(ARG)$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex04/whatis.py $(ARG)

# Uses -it for possible user input
05: build
	@echo "$(GREEN)Running ex05 with ARG=$(ARG)$(RESET)"
	@$(DOCKER_RUN_IT) $(IMAGE_NAME) python ex05/building.py $(ARG)

# Accepts ARG for command-line arguments
06: build
	@echo "$(GREEN)Running ex06 with ARG=$(ARG)$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex06/filterstring.py $(ARG)

# Accepts ARG for command-line argument
07: build
	@echo "$(GREEN)Running ex07 with ARG=$(ARG)$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex07/sos.py $(ARG) | cat -e

08: build
	@echo "$(GREEN)Running ex08$(RESET)"
	@$(DOCKER_RUN) $(IMAGE_NAME) python ex08/Loading.py

# Install and test ft_package locally
09: build
	@echo "$(GREEN)Installing and running ex09$(RESET)"
	@echo ""
	@pip install ./ex09 > /dev/null 2>&1 && python -c "from ft_package import ft_package; ft_package.say_hello()"

# =========================================<<< CLEAN >>>=========================================

# Delete the project image
clean:
	@echo "$(RED)Removing Docker image:$(RESET) $(IMAGE_NAME)"
	@-docker rmi $(IMAGE_NAME) > /dev/null 2>&1 || true

# Thorough cleanup: remove all unused Docker resources
fclean: clean
	@echo "$(RED)Removing all unused Docker resources...$(RESET)"
	@docker system prune -a -f > /dev/null 2>&1
	@echo "$(GREEN)Check running containers:$(RESET)"
	@docker ps
	@echo "$(GREEN)Check all containers (including stopped):$(RESET)"
	@docker ps -a
