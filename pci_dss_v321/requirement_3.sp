locals {
  pci_dss_v321_requirement_3_common_tags = merge(local.pci_dss_v321_common_tags, {
    control_set = "3"
  })
}

benchmark "pci_dss_v321_requirement_3" {
  title       = "Requirement 3: Protect stored cardholder data"
  description = "This is THE most important requirement of the PCI standard. According to requirement 3, you must first know all the data you are going to store along with its location and retention period.  All such cardholder data must be either encrypted using industry-accepted algorithms (e.g., AES-256, RSA 2048), truncated, tokenized or hashed (e.g. SHA 256, PBKDF2). Along with card data encryption, this requirement also talks about a strong PCI DSS encryption key management process. Many times service providers or merchants don’t know they store unencrypted primary account numbers (PAN) and therefore running a tool like card data discovery becomes important. You would note that common locations where card data is found are log files, databases, spreadsheets, etc. This requirement also includes rules for how primary account numbers should be displayed, such as revealing only the first six and last four digits."

  children = [
    benchmark.pci_dss_v321_requirement_3_5
  ]

  tags = local.pci_dss_v321_requirement_3_common_tags
}

benchmark "pci_dss_v321_requirement_3_5" {
  title       = "3.5  Document and implement procedures to protect keys used to secure stored cardholder data against disclosure and misuse."
  description = "Customers are responsible for maintaining appropriate data retention policies and procedures, encryption technologies and key management processes for maintaining PCI DSS requirements."

  children = [
    benchmark.pci_dss_v321_requirement_3_5_2,
    control.kms_key_rotated_within_90_day
  ]

  tags = merge(local.pci_dss_v321_requirement_3_common_tags, {
    pci_dss_v321_item_id = "3.5"
  })
}

benchmark "pci_dss_v321_requirement_3_5_2" {
  title       = "3.5.2 Restrict access to cryptographic keys to the fewest number of custodians necessary."
  description = "Customers are responsible for maintaining appropriate data retention policies and procedures, encryption technologies and key management processes for maintaining PCI DSS requirements."

  children = [
    control.kms_key_users_limited_to_3
  ]

  tags = merge(local.pci_dss_v321_requirement_3_common_tags, {
    pci_dss_v321_item_id = "3.5.2"
  })
}

