#!/bin/bash
docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

