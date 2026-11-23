# Hardware and Network Configuration

## Networks

### OAC Networks

|     Network Name    | VLAN ID |      CIDR     |
| ------------------- | ------- | ------------- |
| Prod Infra          | 213     | 10.20.8.0/23 |
| Staging Workload    | 214     | 10.20.10.0/23 |
| Prod Workload       | 216     | 10.20.12.0/23 |
| BU IST Demo Infra    | 223     | 10.20.26.0/23 |
| BU IST Demo Workload | 224     | 10.20.28.0/23 |
| NIST Dev Infra      | 219     | 10.20.18.0/23 |
| OAC Bare Metal 1    | 225     | 10.20.30.0/24 |
| PureStorage Infra   | 2311    | 10.9.1.0/24   |
| PureStorage Staging | 2312    | 10.9.2.0/24   |
| PureStorage Prod    | 2313    | 10.9.8.0/22   |
| PureStorage BU IST Demo Infra    | 2321 | 10.9.15.0/24 |
| PureStorage BU IST Demo Workload | 2322 | 10.9.16.0/24 |
| PureStorage NIST Dev Infra | 2317 | 10.9.7.0/24 |

### Other Networks

|     Network Name    | VLAN ID |
| ------------------- | ------- |
| IPMI                | 911     |

## Nodes

### R440s

The networking for these nodes are configured through [MOC2-CORE-1](https://github.com/CCI-MOC/ansible-switches/blob/main/host_vars/MOC2-CORE-1/interfaces.yaml) and
[MOC2-CORE-2](https://github.com/CCI-MOC/ansible-switches/blob/main/host_vars/MOC2-CORE-2/interfaces.yaml).

|     Node Name      | Resource Class | IPMI Address | Networking | Purpose                  |
| ------------------ | -------------- | ------------ | ---------- | ------------------------ |
| MOC-R440-U14       | r440           | 10.3.10.114  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Control |
| MOC-R440-U15       | r440           | 10.3.10.115  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Control |
| MOC-R440-U16       | r440           | 10.3.10.116  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Control |
| MOC-R440-U17       | r440           | 10.3.10.117  |                       |                             |
| MOC-R440-U18       | r440           | 10.3.10.118  |                       |                             |
| MOC-R440-U19       | r440           | 10.3.10.119  |                       |                             |
| MOC-R440-U20       | r440           | 10.3.10.120  |                       |                             |
| MOC-R440-U21       | r440           | 10.3.10.121  |                       |                             |

### SD530s

The networking for these nodes are configured through [MOC2-R4PCC06-SW-TORS-A](https://github.com/CCI-MOC/ansible-switches/blob/main/host_vars/MOC2-R4PCC06-SW-TORS-A/interfaces.yaml) and
[MOC2-R4PCC06-SW-TORS-B](https://github.com/CCI-MOC/ansible-switches/blob/main/host_vars/MOC2-R4PCC06-SW-TORS-B/interfaces.yaml).

|     Node Name      | Resource Class | IPMI Address |       Networking      | Purpose                  |
| ------------------ | -------------- | ------------ | --------------------- | ------------------------ |
| MOC-R4PCC06U01-N01 | sd530          | 10.2.22.51   | NIC1: 911             | FIPS Build Host          |
| MOC-R4PCC06U01-N02 | sd530          | 10.2.22.52   |                       |                          |
| MOC-R4PCC06U01-N03 | sd530          | 10.2.22.53   |                       |                          |
| MOC-R4PCC06U01-N04 | sd530          | 10.2.22.54   |                       |                          |
| MOC-R4PCC06U03-N01 | sd530          | 10.2.22.61   |                       |                          |
| MOC-R4PCC06U03-N02 | sd530          | 10.2.22.62   |                       |                          |
| MOC-R4PCC06U03-N03 | sd530          | 10.2.22.63   |                       |                          |
| MOC-R4PCC06U03-N04 | sd530          | 10.2.22.64   |                       |                          |
| MOC-R4PCC06U05-N01 | sd530          | 10.2.22.71   |                       |                          |
| MOC-R4PCC06U05-N02 | sd530          | 10.2.22.72   |                       |                          |
| MOC-R4PCC06U05-N03 | sd530          | 10.2.22.73   |                       |                          |
| MOC-R4PCC06U05-N04 | sd530          | 10.2.22.74   |                       |                          |
| MOC-R4PCC06U07-N01 | sd530          | 10.2.22.81   |                       |                          |
| MOC-R4PCC06U07-N02 | sd530          | 10.2.22.82   |                       |                          |
| MOC-R4PCC06U07-N03 | sd530          | 10.2.22.83   |                       |                          |
| MOC-R4PCC06U07-N04 | sd530          | 10.2.22.84   |                       |                          |
| MOC-R4PCC06U09-N01 | sd530          | 10.2.22.91   |                       |                          |
| MOC-R4PCC06U09-N02 | sd530          | 10.2.22.92   |                       |                          |
| MOC-R4PCC06U09-N03 | sd530          | 10.2.22.93   |                       |                          |
| MOC-R4PCC06U09-N04 | sd530          | 10.2.22.94   |                       |                          |
| MOC-R4PCC06U11-N01 | sd530          | 10.2.22.101  |                       |                          |
| MOC-R4PCC06U11-N02 | sd530          | 10.2.22.102  |                       |                          |
| MOC-R4PCC06U11-N03 | sd530          | 10.2.22.103  |                       |                          |
| MOC-R4PCC06U11-N04 | sd530          | 10.2.22.104  |                       |                          |
| MOC-R4PCC06U13-N01 | sd530          | 10.2.22.111  |                       |                          |
| MOC-R4PCC06U13-N02 | sd530          | 10.2.22.112  |                       |                          |
| MOC-R4PCC06U13-N03 | sd530          | 10.2.22.113  |                       |                          |
| MOC-R4PCC06U13-N04 | sd530          | 10.2.22.114  |                       |                          |
| MOC-R4PCC06U15-N01 | sd530          | 10.2.22.121  |                       |                          |
| MOC-R4PCC06U15-N02 | sd530          | 10.2.22.122  |                       |                          |
| MOC-R4PCC06U15-N03 | sd530          | 10.2.22.123  |                       |                          |
| MOC-R4PCC06U15-N04 | sd530          | 10.2.22.124  |                       |                          |
| MOC-R4PCC06U17-N01 | sd530          | 10.2.22.131  |                       |                          |
| MOC-R4PCC06U17-N02 | sd530          | 10.2.22.132  |                       |                          |
| MOC-R4PCC06U17-N03 | sd530          | 10.2.22.133  |                       |                          |
| MOC-R4PCC06U17-N04 | sd530          | 10.2.22.134  |                       |                          |
| MOC-R4PCC06U19-N01 | sd530          | 10.2.22.141  |                       |                          |
| MOC-R4PCC06U19-N02 | sd530          | 10.2.22.142  |                       |                          |
| MOC-R4PCC06U19-N03 | sd530          | 10.2.22.143  |                       |                          |
| MOC-R4PCC06U19-N04 | sd530          | 10.2.22.144  |                       |                          |
| MOC-R4PCC06U21-N01 | sd530          | 10.2.22.151  |                       | DOWN FOR NOW             |
| MOC-R4PCC06U21-N02 | sd530          | 10.2.22.152  |                       | DOWN FOR NOW             |
| MOC-R4PCC06U21-N03 | sd530          | 10.2.22.153  |                       | DOWN FOR NOW             |
| MOC-R4PCC06U21-N04 | sd530          | 10.2.22.154  |                       | DOWN FOR NOW             |
| MOC-R4PCC06U23-N01 | sd530          | 10.2.22.161  |                       |                          |
| MOC-R4PCC06U23-N02 | sd530          | 10.2.22.162  |                       |                          |
| MOC-R4PCC06U23-N03 | sd530          | 10.2.22.163  |                       |                          |
| MOC-R4PCC06U23-N04 | sd530          | 10.2.22.164  |                       |                          |
| MOC-R4PCC06U25-N01 | sd530          | 10.2.22.171  |                       |                          |
| MOC-R4PCC06U25-N02 | sd530          | 10.2.22.172  |                       |                          |
| MOC-R4PCC06U25-N03 | sd530          | 10.2.22.173  |                       |                          |
| MOC-R4PCC06U25-N04 | sd530          | 10.2.22.174  |                       |                          |

### A100s

|    Node Name    | Resource Class | IPMI Address |      Networking       | Purpose                  |
| ----------------| -------------- | ------------ | --------------------- | ------------------------ |
| MOC-R8PAC23U26  | a100           | 10.2.18.126  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |
| MOC-R8PAC23U31  | a100           | 10.2.18.131  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |

### H100s

|    Node Name    | Resource Class | IPMI Address |      Networking       | Purpose                  |
| ----------------| -------------- | ------------ | --------------------- | ------------------------ |
| MOC-R4PCC02U30  | h100           | 10.2.19.130  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |
| MOC-R4PCC02U32  | h100           | 10.2.19.132  | NIC1: 225             | OAC Bare Metal           |
| MOC-R4PCC04U03  | h100           | 10.2.20.103  | NIC1: 225             | OAC Bare Metal           |
| MOC-R4PCC04U09  | h100           | 10.2.20.109  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |
| MOC-R4PCC04U11  | h100           | 10.2.20.111  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |
| MOC-R4PCC04U12  | h100           | 10.2.20.112  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |
| MOC-R4PCC04U16  | h100           | 10.2.20.116  | NIC1: 216, NIC2: 2313 | Prod Workload Compute    |

###  Rack R4PAC10

The nodes in rack R4PAC10 have been removed from ESI and dedicated to this project.

|     Node Name      | Resource Class | IPMI Address |      Networking       | Purpose                   |
| ------------------ | -------------- | ------------ | --------------------- | ------------------------- |
| MOC-R4PAC10U37-S1A | fc430          | 10.2.13.191  | NIC1: 213, NIC2: 911  | Bastion                   |
| MOC-R4PAC10U37-S1B | fc430          | 10.2.13.192  |                       | Nist Dev Workload0        |
| MOC-R4PAC10U37-S1C | fc430          | 10.2.13.193  |                       |                           |
| MOC-R4PAC10U37-S1D | fc430          | 10.2.13.194  |                       | Nist Dev Workload0        |
| MOC-R4PAC10U37-S3C | fc430          | 10.2.13.197  | NIC1: 213, NIC2: 2311 | Prod Infra Control Plane  |
| MOC-R4PAC10U35-S1A | fc430          | 10.2.13.181  | NIC1: 223, NIC2: 2321 | BU IST Demo Infra Control |
| MOC-R4PAC10U35-S1B | fc430          | 10.2.13.182  |                       |                           |
| MOC-R4PAC10U35-S1C | fc430          | 10.2.13.183  |                       |                           |
| MOC-R4PAC10U35-S1D | fc430          | 10.2.13.184  |                       |                           |
| MOC-R4PAC10U35-S3B | fc430          | 10.2.13.186  | NIC1: 213, NIC2: 2311 | Prod Infra Control Plane  |
| MOC-R4PAC10U35-S3C | fc430          | 10.2.13.187  |                       |                           |
| MOC-R4PAC10U35-S3D | fc430          | 10.2.13.188  |                       |                           |
| MOC-R4PAC10U33-S1A | fc430          | 10.2.13.171  | NIC1: 213, NIC2: 2311 | Prod Infra Control Plane  |
| MOC-R4PAC10U33-S1B | fc430          | 10.2.13.172  |                       | * Disk Issue              |
| MOC-R4PAC10U33-S1C | fc430          | 10.2.13.173  |                       | Dev Workload1             |
| MOC-R4PAC10U33-S1D | fc430          | 10.2.13.174  | NIC1: 223, NIC2: 2321 | BU IST Demo Infra Control |
| MOC-R4PAC10U33-S3A | fc430          | 10.2.13.175  |                       | * Won't Power On          |
| MOC-R4PAC10U33-S3B | fc430          | 10.2.13.176  |                       | Dev Workload1             |
| MOC-R4PAC10U33-S3C | fc430          | 10.2.13.177  |                       |                           |
| MOC-R4PAC10U33-S3D | fc430          | 10.2.13.178  |                       |                           |
| MOC-R4PAC10U31-S1A | fc430          | 10.2.13.161  | NIC1: 223, NIC2: 2321 | BU IST Demo Infra Control |
| MOC-R4PAC10U31-S1B | fc430          | 10.2.13.162  | NIC1: 224, NIC2: 2322 | BU IST Demo Workload      |
| MOC-R4PAC10U31-S1C | fc430          | 10.2.13.163  | NIC1: 224, NIC2: 2322 | BU IST Demo Workload      |
| MOC-R4PAC10U31-S1D | fc430          | 10.2.13.164  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Worker |
| MOC-R4PAC10U31-S3A | fc430          | 10.2.13.165  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Worker |
| MOC-R4PAC10U31-S3B | fc430          | 10.2.13.166  | NIC1: 219, NIC2: 2317 | Compliant Dev Infra Worker |
| MOC-R4PAC10U31-S3C | fc430          | 10.2.13.167  |                       |                           |
| MOC-R4PAC10U31-S3D | fc430          | 10.2.13.168  |                       |                           |
| MOC-R4PAC10U29-S1  | fc830-nvme     | 10.2.13.151  | NIC1: 214, NIC2: 2312 | Staging Workload Compute  |
| MOC-R4PAC10U29-S3  | fc830          | 10.2.13.152  | NIC1: 216, NIC2: 2313 | Prod Workload Compute     |
| MOC-R4PAC10U27-S1  | fc830          | 10.2.13.141  | NIC1: 214, NIC2: 2312 | Staging Workload Compute  |
| MOC-R4PAC10U27-S3  | fc830          | 10.2.13.142  | NIC1: 216, NIC2: 2313 | Prod Workload Compute     |
| MOC-R4PAC10U25-S1  | fc830          | 10.2.13.131  | NIC1: 214, NIC2: 2312 | Staging Workload Compute  |
| MOC-R4PAC10U25-S3  | fc830          | 10.2.13.132  | NIC1: 216, NIC2: 2313 | Prod Workload Compute     |
| MOC-R4PAC10U23-S1  | fc830          | 10.2.13.121  |                       | * Boot Issue              |
| MOC-R4PAC10U23-S3  | fc830          | 10.2.13.122  |                       |                           |
| MOC-R4PAC10U21-S1  | fc830          | 10.2.13.111  |                       | * IPMI Unreachable        |
| MOC-R4PAC10U21-S3  | fc830          | 10.2.13.112  |                       | * IPMI Unreachable        |
| MOC-R4PAC10U19-S1  | fc830          | 10.2.13.101  | NIC1: 213, NIC2: 2311 | Prod Infra Compute (Temp) |
| MOC-R4PAC10U19-S3  | fc830          | 10.2.13.102  |                       | * Won't power on          |
| MOC-R4PAC10U17-S3  | fc830          | 10.2.13.92   |                       | Nist Dev Infra            |
| MOC-R4PAC10U15-S1  | fc830          | 10.2.13.81   |                       | Nist Dev Infra            |
| MOC-R4PAC10U15-S3  | fc830          | 10.2.13.82   |                       |                           |
| MOC-R4PAC10U13-S1  | fc830          | 10.2.13.71   |                       | Nist Dev Infra            |
| MOC-R4PAC10U13-S3  | fc830          | 10.2.13.72   |                       | * Boot Issue              |
| MOC-R4PAC10U11-S1  | fc830          | 10.2.13.61   |                       | * Boot Issue              |
| MOC-R4PAC10U11-S3  | fc830          | 10.2.13.62   | NIC1: 213, NIC2: 2311 | Prod Infra Compute (Temp) |
| MOC-R4PAC10U09-S1  | fc830-nvme     | 10.2.13.51   |                       | * Boot Issue              |
| MOC-R4PAC10U09-S3  | fc830          | 10.2.13.52   | NIC1: 213, NIC2: 2311 | Prod Infra Compute (Temp) |
| MOC-R4PAC10U07-S1  | fc830          | 10.2.13.41   |                       | Disaster Recovery Infra   |
| MOC-R4PAC10U07-S3  | fc830          | 10.2.13.42   |                       | Disaster Recovery Infra   |
| MOC-R4PAC10U05-S1  | fc830          | 10.2.13.31   |                       | Disaster Recovery Infra   |
| MOC-R4PAC10U05-S3  | fc830          | 10.2.13.32   |                       | Disaster Recovery Infra   |
| MOC-R4PAC10U03-S1  | fc830          | 10.2.13.21   |                       | Disaster Recovery Infra   |
| MOC-R4PAC10U03-S3  | fc830          | 10.2.13.22   |                       | Disaster Recovery Infra   |
