provider "vsphere" {
  vsphere_server = var.vsphere_server
  user = var.vsphere_user
  password = var.vsphere_password
  allow_unverified_ssl = true
}

# --- VARIABLE-DECLARATION

data "vsphere_datacenter" "dc" {
  name = "dc-home"
}

data "vsphere_compute_cluster" "cluster" {
  name = "cluster-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name = "rp-home"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = "openshift_storage"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "dpg-home-prod"
  datacenter_id = data.vsphere_datacenter.dc.id
}

variable "ocp-folder" {
  default = "/dc-home/vm/ocp43-patrick"
}

# --- Create VM OCP-Load Balancer#1--- #
resource "vsphere_virtual_machine" "ocp-lb1" {
  name = var.vm_name_ocp-lb1
  folder = var.ocp-folder
  guest_id = var.lb_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "efi"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:b1:11"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}

# --- Create VM OCP-Load Balancer#2--- #
resource "vsphere_virtual_machine" "ocp-lb2" {
  name = var.vm_name_ocp-lb2
  folder = var.ocp-folder
  guest_id = var.lb_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "efi"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:b1:12"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}
