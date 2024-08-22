locals {
  soc_2_2017_common_tags = merge(local.gcp_compliance_common_tags, {
    soc_2_2017  = "true"
    type      = "Benchmark"
  })
}

benchmark "soc_2_2017" {
  title         = "SOC2 2017"
  description   = ""
  documentation = file("./soc2_2017/docs/soc_2_2017_overview.md")
  children = [
  ]
  tags = local.soc_2_2017_common_tags
}
