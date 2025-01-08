locals {
  app        = "recipe-backend"
  create_api = var.env != "preview" && var.env != "spreview"

  platform = var.common_tags.businessArea == "Cross-Cutting" ? "sds" : "cft"

  # list of the thumbprints of the SSL certificates that should be accepted by the API (gateway)
  allowed_certificate_thumbprints = [
    # API tests
    var.api_gateway_test_certificate_thumbprint,
    "8B0666A1041156C83BCE832906F9BC7C2542B65A"
  ]

  thumbprints_in_quotes     = formatlist("&quot;%s&quot;", local.allowed_certificate_thumbprints)
  thumbprints_in_quotes_str = join(",", local.thumbprints_in_quotes)
  api_policy                = replace(file("template/api-policy.xml"), "ALLOWED_CERTIFICATE_THUMBPRINTS", local.thumbprints_in_quotes_str)
  api_base_path             = "${var.product}-api"
  shared_infra_rg           = "${var.product}-shared-infrastructure-${var.env}"
  vault_name                = "${var.product}kv-${var.env}"

  servicebus_namespace_name = "${var.product}-servicebus-${var.env}"

  tags = merge(
    var.common_tags,
    tomap({ "Team Contact" = var.team_contact })
  )

}
