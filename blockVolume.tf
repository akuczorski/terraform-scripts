variable "DBSize" {
  default = "50" // size in GBs, min: 50, max 16384
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

resource "oci_core_volume" "t" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.0.name}"
  compartment_id = "${var.tenancy_ocid}"
  display_name = "-tf-volume"
  size_in_gbs = "${var.DBSize}"
}

data "oci_core_volumes" "test_volumes" {
  compartment_id = "${var.tenancy_ocid}"

  filter {
    name = "id"
    values = ["${oci_core_volume.t.id}"]
  }
}

output "volumes" {
  value = "${data.oci_core_volumes.test_volumes.volumes}"
}