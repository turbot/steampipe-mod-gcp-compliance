locals {
  cis_v300_4_common_tags = merge(local.cis_v300_common_tags, {
    cis_section_id = "4"
  })
}

benchmark "cis_v300_4" {
  title         = "4 Virtual Machines"
  documentation = file("./cis_v300/docs/cis_v300_4.md")
  children = [
    control.cis_v300_4_1,
    control.cis_v300_4_2,
    control.cis_v300_4_3,
    control.cis_v300_4_4,
    control.cis_v300_4_5,
    control.cis_v300_4_6,
    control.cis_v300_4_7,
    control.cis_v300_4_8,
    control.cis_v300_4_9,
    control.cis_v300_4_10,
    control.cis_v300_4_11,
    control.cis_v300_4_12
  ]

  tags = merge(local.cis_v300_4_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v300_4_1" {
  title         = "4.1 Ensure That Instances Are Not Configured To Use the Default Service Account"
  description   = "It is recommended to configure your instance to not use the default Compute Engine service account because it has the Editor role on the project."
  query         = query.compute_instance_with_no_default_service_account
  documentation = file("./cis_v300/docs/cis_v300_4_1.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_2" {
  title         = "4.2 Ensure That Instances Are Not Configured To Use the Default Service Account With Full Access to All Cloud APIs"
  description   = "To support principle of least privileges and prevent potential privilege escalation it is recommended that instances are not assigned to default service account Compute Engine default service account with Scope Allow full access to all Cloud APIs."
  query         = query.compute_instance_with_no_default_service_account_with_full_access
  documentation = file("./cis_v300/docs/cis_v300_4_2.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.2"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_3" {
  title         = "4.3 Ensure 'Block Project-Wide SSH Keys' Is Enabled for VM Instances"
  description   = "It is recommended to use Instance specific SSH key(s) instead of using common/shared project-wide SSH key(s) to access Instances."
  query         = query.compute_instance_block_project_wide_ssh_enabled
  documentation = file("./cis_v300/docs/cis_v300_4_3.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_4" {
  title         = "4.4 Ensure Oslogin Is Enabled for a Project"
  description   = "Enabling OS login binds SSH certificates to IAM users and facilitates effective SSH certificate management."
  query         = query.compute_instance_oslogin_enabled
  documentation = file("./cis_v300/docs/cis_v300_4_4.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.4"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_5" {
  title         = "4.5 Ensure ‘Enable Connecting to Serial Ports’ Is Not Enabled for VM Instance "
  description   = "Interacting with a serial port is often referred to as the serial console, which is similar to using a terminal window, in that input and output is entirely in text mode and there is no graphical interface or mouse support."
  query         = query.compute_instance_serial_port_connection_disabled
  documentation = file("./cis_v300/docs/cis_v300_4_5.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.5"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_6" {
  title         = "4.6 Ensure That IP Forwarding Is Not Enabled on Instances"
  description   = "Compute Engine instance cannot forward a packet unless the source IP address of the packet matches the IP address of the instance. Similarly, GCP won't deliver a packet whose destination IP address is different than the IP address of the instance receiving the packet. However, both capabilities are required if you want to use instances to help route packets."
  query         = query.compute_instance_ip_forwarding_disabled
  documentation = file("./cis_v300/docs/cis_v300_4_6.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_7" {
  title         = "4.7 Ensure VM Disks for Critical VMs Are Encrypted With Customer-Supplied Encryption Keys"
  description   = "Customer-Supplied Encryption Keys (CSEK) are a feature in Google Cloud Storage and Google Compute Engine. If you supply your own encryption keys, Google uses your key to protect the Google-generated keys used to encrypt and decrypt your data. By default, Google Compute Engine encrypts all data at rest. Compute Engine handles and manages this encryption for you without any additional actions on your part. However, if you wanted to control and manage this encryption yourself, you can provide your own encryption keys."
  query         = query.compute_disk_encrypted_with_csk
  documentation = file("./cis_v300/docs/cis_v300_4_7.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.7"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_8" {
  title         = "4.8 Ensure Compute Instances Are Launched With Shielded VM Enabled"
  description   = "To defend against against advanced threats and ensure that the boot loader and firmware on your VMs are signed and untampered, it is recommended that Compute instances are launched with Shielded VM enabled."
  query         = query.compute_instance_shielded_vm_enabled
  documentation = file("./cis_v300/docs/cis_v300_4_8.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.8"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_9" {
  title         = "4.9 Ensure That Compute Instances Do Not Have Public IP Addresses"
  description   = "Compute instances should not be configured to have external IP addresses."
  query         = query.compute_instance_with_no_public_ip_addresses
  documentation = file("./cis_v300/docs/cis_v300_4_9.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.9"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_10" {
  title         = "4.10 Ensure That App Engine Applications Enforce HTTPS Connections"
  description   = "In order to maintain the highest level of security all connections to an application should be secure by default."
  documentation = file("./cis_v300/docs/cis_v300_4_10.md")
  query         = query.manual_control

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.10"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/AppEngine"
  })
}

control "cis_v300_4_11" {
  title         = "4.11 Ensure That Compute Instances Have Confidential Computing Enabled"
  description   = "Google Cloud encrypts data at-rest and in-transit, but customer data must be decrypted for processing. Confidential Computing is a breakthrough technology which encrypts data in-use—while it is being processed. Confidential Computing environments keep data encrypted in memory and elsewhere outside the central processing unit (CPU)."
  query         = query.compute_instance_confidential_computing_enabled
  documentation = file("./cis_v300/docs/cis_v300_4_11.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.11"
    cis_level   = "2"
    cis_type    = "automated"
    service     = "GCP/Compute"
  })
}

control "cis_v300_4_12" {
  title         = "4.12 Ensure the Latest Operating System Updates Are Installed On Your Virtual Machines in All Project"
  description   = "Google Cloud Virtual Machines have the ability via an OS Config agent API to periodically (about every 10 minutes) report OS inventory data. A patch compliance API periodically reads this data, and cross references metadata to determine if the latest updates are installed."
  query         = query.manual_control
  documentation = file("./cis_v300/docs/cis_v300_4_12.md")

  tags = merge(local.cis_v300_4_common_tags, {
    cis_item_id = "4.12"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "GCP/Compute"
  })
}
