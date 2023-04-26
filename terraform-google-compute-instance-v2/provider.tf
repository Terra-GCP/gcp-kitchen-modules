#..................................... Provider Block ......................................#

provider "google" {
    #credentials = file("${var.credentials}")
    project = var.project_id
}
provider "google-beta" {
    #credentials = file("${var.credentials}") 
    project = var.project_id
}