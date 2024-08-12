# Project 01

## Project Breakdown

### 1. Configuring Jobs and Targets
- **Task:** Set up a Prometheus server to monitor multiple services running on different nodes.
- **Deliverables:**
  - Configure Prometheus with jobs for monitoring different services like web servers, databases, and system metrics.
+ prometheus.yml
```yml
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds.
  evaluation_interval: 15s # Evaluate rules every 15 seconds.

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           - localhost:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
   - "alert_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'node_exporter_aws'
    static_configs:
      - targets: ['13.233.208.255:9100']
  # database target setup
  - job_name: "mysqld_exporter"
    static_configs:
      - targets: ["13.233.208.255:9104"]

```

### 2. Using Exporters (Node Exporter)
- **Task:** Use Node Exporter to monitor system-level metrics like CPU, memory, disk usage, and network statistics.

![alt text](img/image3.png)
![alt text](img/image4.png)

### 3. Hands-on Exercise: Setting Up Exporters
- **Task:** Configure at least two different types of exporters (e.g., Node Exporter and MySQL Exporter) and integrate them with Prometheus.
```bash
# before installing mysqld_exporter install the mysql-server and create the new mysqld_exporter user
$ sudo apt install mysql-server
$ sudo mysql -u root -p
mysql> CREATE USER 'mysqld_exporter'@'localhost' IDENTIFIED BY '<your_password>';
mysql> GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'mysqld_exporter'@'localhost';
mysql> FLUSH PRIVILEGES;
mysql> EXIT

# Then install the mysqld_exporter using the below command
$ wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-amd64.tar.gz
$ tar -xvf mysqld_exporter-0.15.1.linux-amd
```

```bash
# before starting the mysqld_exporter first edit the .my.cnf file
[client]
user=mysqld_exporter
password=<your_password>
```

```bash
$ cd mysqld_exporter-0.15.1.linux-amd
$ ./mysqld_exporter
```

![alt text](img/image5.png)
![alt text](img/image6.png)

### 4. Introduction to PromQL
- **Task:** Write basic queries to retrieve metrics like average CPU usage, memory consumption, and disk I/O over time.
+ Average CPU Usage Over Time
```PromQL
100 - 100 * (avg by (group, instance, job) (irate(node_cpu_seconds_total{mode="idle"}[5m])))
```
![alt text](img/image8.png)
![alt text](img/image7.png)

+ Memory Consumption
```PromQL
node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100
```
![alt text](img/image11.png)
![alt text](img/image12.png)

+ Average Disk I/O Over Time
```PromQL
avg(rate(node_disk_written_bytes_total[5m])) by (instance)
```
![alt text](img/image9.png)
![alt text](img/image10.png)

### 5. Basic Queries (Selectors, Functions, Operators)
- **Task:**
  - Write PromQL queries to calculate the 95th percentile of CPU usage.
  - Use functions like `rate()`, `increase()`, and `histogram_quantile()` to perform more complex analysis.

### 6. Advanced Queries and Aggregations
- **Task:** 
  - Write queries to calculate the total memory usage across all nodes.
  ```PromQL
  sum by (instance)(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)
  ```
  ![alt text](img/image13.png)
  ![alt text](img/image14.png)

  - Aggregate data to find the maximum disk space usage among all nodes.
  ```PromQl
  max(node_filesystem_size_bytes - node_filesystem_free_bytes)
  ```
![alt text](img/image16.png)
![alt text](img/image15.png)

### 7. Configuring Alertmanager
- **Task:**
  - Configure Alertmanager with Prometheus.
  ![alt text](img/image1.png)
  ![alt text](img/image2.png)

### 8. Writing Alerting Rules
- **Task:** 
  - Create alerting rules for high CPU usage, memory leaks, and disk space running low.
```yml
groups:
  - name: low_disk
    rules:
      - alert: LowDiskSpace
        expr: node_filesystem_free_bytes / node_filesystem_size_bytes < 0.10
        for: 3m
        labels:
          severity: critical
        annotations:
          summary: "Low Disk Space on instance {{ $labels.instance }}"
          description: "Disk space is below 10%."

  - name: high_cpu
    rules:
      - alert: HighCPUUsage
        expr: avg(rate(node_cpu_seconds_total[5m])) by (instance) > 0.85
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High CPU Usage on instance {{ $labels.instance }}"
          description: "CPU usage is above 85% for more than 2 minutes."

  - name: instance_down
    rules:
    - alert: InstanceDown
      expr: up == 0
      for: 3m
      labels:
        severity: critical
      annotations:
        summary: "Instance {{ $labels.instance }} is down"
        description: "The instance {{ $labels.instance }} is not reachable."
```
![alt text](img/image17.png)

### 9. Setting Up Notification Channels (Email, Slack, etc.)
- **Task:** Integrate Alertmanager with multiple notification channels like Email and Slack.
  - Integrate Slack for real-time alerts and notifications.

```yml
route:
  receiver: 'email'
  group_by: ['alertname']

receivers:
  - name: 'email'
    email_configs:
      - to: 'admin@example.com'
        from: 'prometheus@example.com'
        smarthost: 'smtp.example.com:587'
        auth_username: 'user'
        auth_password: 'password'

  - name: 'slack'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX'
        channel: '#alerts'
```

### 10. Hands-on Exercise: Creating Alerts
- **Task:** Test the entire alerting pipeline by creating and triggering custom alerts.
- **Deliverables:**
  - Simulate a scenario where a node exceeds 90% CPU usage and ensure alerts are triggered and sent to both Email and Slack.
  - Validate the alerts in both notification channels.

![alt text](img/image18.png)
![alt text](img/image19.png)
