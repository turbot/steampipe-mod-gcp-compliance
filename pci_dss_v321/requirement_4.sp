locals {
  pci_dss_v321_requirement_4_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "4"
  })
}

benchmark "pci_dss_v321_requirement_4" {
  title       = "Requirement 4: Encrypt transmission of cardholder data across open, public networks"
  description = "Similar to requirement 3, in this requirement, you must secure the card data when it is transmitted over an open or public network (e.g. Internet, 802.11, Bluetooth, GSM, CDMA, GPRS). You must know where you are going to send/receive the card data to/from. Majorly, the card data is transmitted to the payment gateway, processor, etc. for processing transactions. Cybercriminals can potentially access cardholder data when it’s transmitted across public networks. Encrypting cardholder data prior to transmitting using a secure version of transmission protocols such as TLS, SSH, etc. can limit the likelihood of such data getting compromised."

  children = [
    benchmark.pci_dss_v321_requirement_4_1
  ]

  tags = local.pci_dss_v321_requirement_4_common_tags
}

benchmark "pci_dss_v321_requirement_4_1" {
  title       = "4.1 Use strong cryptography and security protocols to safeguard sensitive cardholder data during transmission over open, public networks"
  description = "GCP customers are responsible for strong cryptography and security protocols for connections to any storage system that is transmitting cardholder data. Customers are responsible for ensuring the data is encrypted in transit over open, public networks. Customers are responsible for using web browsers and client endpoints that do not support TLS1.0 or ciphers that are weaker than AES128."
  children = [
    control.disable_gke_legacy_abac,
    control.require_ssl_sql,
    control.compute_ssl_policy_with_no_weak_cipher
  ]

  tags = merge(local.pci_dss_v321_requirement_4_common_tags, {
    pci_dss_v321_item_id = "4.1"
  })
}

