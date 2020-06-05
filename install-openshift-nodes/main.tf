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

# --- Create VM OCP-Master#1--- #
resource "vsphere_virtual_machine" "ocp-master1" {
  name = var.vm_name_ocp-master1
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:e3:78"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}

# --- Create VM OCP-Master#2 --- #
resource "vsphere_virtual_machine" "ocp-master2" {
  name = var.vm_name_ocp-master2
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:84:6d"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}

# --- Create VM OCP-Master#3 --- #
resource "vsphere_virtual_machine" "ocp-master3" {
  name = var.vm_name_ocp-master3
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:0c:86"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}

# --- Create VM OCP-Worker#1 --- #
resource "vsphere_virtual_machine" "ocp-worker1" {
  name = var.vm_name_ocp-worker1
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:c4:67"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}
# --- Create VM OCP-Worker#2 --- #
resource "vsphere_virtual_machine" "ocp-worker2" {
  name = var.vm_name_ocp-worker2
  folder = var.ocp-folder
  guest_id = var.master_guest_id_tag
  resource_pool_id = data.vsphere_resource_pool.pool.id
  firmware = "bios"
  datastore_id = data.vsphere_datastore.datastore.id
  num_cpus = 8
  memory = 16384
  wait_for_guest_ip_timeout = 10
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
    use_static_mac = true
    mac_address = "00:50:56:a6:0f:e8"
  }
  disk {
    label = "rootvolume"
    size  = "120"
    thin_provisioned  = "true"
    unit_number = 0
  }
}
