resource "oci_core_instance" "example" {
  count               = 1
  compartment_id      = "${var.compartment_ocid}"
  availability_domain = "${var.availability_domain}"
  subnet_id           = "${var.subnet_ocid}"
  display_name        = "example"
  image               = "${lookup(data.oci_core_images.image-list.images[0], "id")}"
shape = "VM.Standard1.1"

